include MonitorMixin

require "monitor"

class Redis
  @@messages = {:test_redis=>[]}

  def initialize(options = {})
    @options = options.dup
    #puts "HU#{@@messages}"
    super()   # Monitor#initialize
    #Monitor.new
  end

  def publish key, value
      #puts "mock - #{key}: #{value}"
      #RedisTest.create(:key=>key, :value=>value)
      @@messages[:test_redis]<<{:key=>key, :value=>value}
  end

  def subscribe(*channels, &block)
    #yield "hu"
    #subscription( channels, block)
    #message
    sub = Subscription.new(&block)
    #if @@messages[:test_redis].any?
    #  @@messages[:test_redis].each do |message|
    #    rest = [message[:key], message[:value]]
    #    @@messages[:test_redis].delete(message)

    #    sub.callbacks["message"].call(*rest)
    #  end
    #end
    puts "co? #{block}"
    rest = [:web2web, '{"command":"kill_websocket","time":1456477470}']

    sub.callbacks["message"].call(*rest)
  end

  def unsubscribe(*channels)
    call([:unsubscribe, *channels])
  end


  protected



  def subscription(channels, block)
    sub = SubscriptionM.new(&block)
    #sub = Subscription.new(channels)
    #Thread.new do
    #  until false  do
    while (true) do
        puts("channels: #{channels}" )
        if @@messages[:test_redis].any?
          @@messages[:test_redis].each do |message|
            rest = [message[:key], message[:value]]
            @@messages[:test_redis].delete(message)

            sub.callbacks["message"].call(*rest)
          end
        end
        #sub.message table  if table
        sleep(0.01)
    end
   # end

  end


  class Subscription
    attr :callbacks

    def initialize
     # puts "block: #{block}"
      @callbacks = Hash.new do |hash, key|
        hash[key] = lambda { |*_| }
      end

      yield(self)
    end

    def subscribe(&block)
      puts "subscribe..."
      @callbacks["subscribe"] = [:web2web, '{"command":"kill_websocket","time":1456477470}']#block
    end

    def unsubscribe(&block)
      @callbacks["unsubscribe"] = block
    end

    def message(&block)
      puts "Subscription: #{block}"
      @callbacks["message"] = block
    end

    def psubscribe(&block)
      @callbacks["psubscribe"] = block
    end

    def punsubscribe(&block)
      @callbacks["punsubscribe"] = block
    end

    def pmessage(&block)
      @callbacks["pmessage"] = block
    end
  end


  #class Subscription
  #  attr :callbacks

  #  def initialize
  #    yield(self)
  #  end



    #def message(db)
   #   puts "mock msg: #{{db.key=>db.value }}"
   #   hash = {db.key=>db.value }
      #db.destroy
   #   hash
   # end


 # end

end