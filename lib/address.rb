module Blockchain
  class Address

    def initialize(address)
      @address = address
    end

    def self.from_multiple(*addresses)
      Address.new(addresses.join('|'))
    end

    # start_time, end_time only work for this endpoint. why? no idea
    def received(options = {})
      Btc.new(info('getreceivedbyaddress', options))
    end

    def sent(options = {})
      Btc.new(info('getsentbyaddress', options))
    end

    def balance(options = {})
      Btc.new(info('addressbalance', options))
    end

    # can only get one
    def firstseen(i = 0, options = {})
      DateTime.strptime(info('addressfirstseen', options, self.to_a[i]), '%s')
    end

    def to_a
      @address.split('|')
    end

    def to_s
      @address
    end

    def +(other)
      Address.from_multiple(self.to_a + other.to_a)
    end

    private def info(path, options, address = @address)
      start_time, end_time = options[:start], options[:end]
      confs = options[:confirmations] || 1
      full = "#{path}/#{address}?confirmations=#{confs}"
      full << "&#{start_time.strftime('%Q')}" unless start_time.nil?
      full << "&#{end_time.strftime('%Q')}" unless end_time.nil?
      Blockchain.q("#{path}/#{address}?confirmations=#{confs}")
    end
  end
end