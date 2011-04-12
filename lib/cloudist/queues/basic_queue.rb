module Cloudist
  class UnknownReplyTo < RuntimeError; end
  class ExpiredMessage < RuntimeError; end
  
  module Queues
    class BasicQueue
      attr_reader :queue_name, :opts
      attr_reader :q, :ex, :mq

      def initialize(queue_name, opts = {})
        opts = {
          :auto_delete => true,
          :durable => false,
          :prefetch => 1
        }.update(opts)

        @queue_name, @opts = queue_name, opts
      end

      def setup
        # return if @setup.eql?(true)
        
        @mq = AMQP::Channel.new
        
        # Set up QOS. If you do not do this then the subscribe in receive_message
        # will get overwelmd and the whole thing will collapse in on itself.
        @mq.prefetch(1)
        opts = {:durable => false}.merge(opts)
        
        @ex = MQ::Exchange.new(@mq, :direct, queue_name.to_s, opts)
        @q = MQ::Queue.new(@mq, queue_name.to_s, opts).bind(@ex)
        
                # 
                # 
                # @mq = AMQP::Channel.new
                # @q = @mq.queue(queue_name, opts)
                # 
                # # Set up QOS. If you do not do this then the subscribe in receive_message
                # # will get overwelmd and the whole thing will collapse in on itself.
                # @mq.prefetch(1)
                # 
                # #  do |queue, message_count, consumer_count|
                # #   puts "Queue #{queue.name} declared!"
                # #   puts "Message count: #{message_count}"
                # #   puts "Consumer count: #{consumer_count}"
                # # end
                # 
                # # if we don't specify an exchange name it defaults to the queue_name
                # @ex = @mq.direct(opts[:exchange_name] || queue_name)
                # 
                # q.bind(ex) if ex
        
        @setup = true
      end

      def log
        Cloudist.log
      end

      def tag
        s = ''
        s << "queue=#{q.name}" if q
        s << " exchange=#{ex.name}" if ex
        s
      end
      
      # Not yet supported
      def subscribe_pop(amqp_opts={}, opts={})
        setup
        print_status
        
        q.pop { |queue_header, encoded_message|
          unless encoded_message
            # queue was empty
            p [Time.now, :queue_empty!]

            # try again in 1 second
            EM.add_timer(1) { q.pop }
          else
            request = Cloudist::Request.new(self, encoded_message, queue_header)

            begin
              raise Cloudist::ExpiredMessage if request.expired?
              yield request if block_given?
              # finished = Time.now.utc.to_i
              # log.debug("Finished Job in #{finished - request.start} seconds")

            rescue Cloudist::ExpiredMessage
              log.error "AMQP Message Timeout: #{tag} ttl=#{request.ttl} age=#{request.age}"
              request.ack if amqp_opts[:ack]

            rescue => e
              request.ack if amqp_opts[:ack]
              Cloudist.handle_error(e)
            end

            # get the next message in the queue
            q.pop
          end
        }
      end

      def subscribe(amqp_opts={}, opts={})
        setup
        # print_status
        q.subscribe do |queue_header, encoded_message|
          next if Cloudist.closing?
          request = Cloudist::Request.new(self, encoded_message, queue_header)
          
          begin
            raise Cloudist::ExpiredMessage if request.expired?
            yield request if block_given?
            # finished = Time.now.utc.to_i
            # log.debug("Finished Job in #{finished - request.start} seconds")

          rescue Cloudist::ExpiredMessage
            log.error "AMQP Message Timeout: #{tag} ttl=#{request.ttl} age=#{request.age}"
            request.ack if amqp_opts[:ack]

          rescue => e
            request.ack if amqp_opts[:ack]
            Cloudist.handle_error(e)
          end
        end
        self
      end

      def print_status
        # q.status{ |num_messages, num_consumers|
        #   log.info("STATUS: #{q.name}: JOBS: #{num_messages} WORKERS: #{num_consumers+1}")
        # }
      end

      def publish(payload)
        payload.set_reply_to(queue_name)
        body, headers = payload.formatted
        ex.publish(body, headers)
        payload.publish
      end

      def publish_to_q(payload)
        body, headers = payload.formatted
        q.publish(body, headers)
        payload.publish
        return headers
      end

      def teardown
        @q.unsubscribe
        @mq.close
        log.debug "AMQP Unsubscribed: #{tag}"
      end

      def destroy
        teardown
      end
    end
  end
end