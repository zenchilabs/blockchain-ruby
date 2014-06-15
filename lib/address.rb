module Blockchain
  class Address

    def initialize(address)
      @address = address
    end

    def self.from_multiple(*addresses)
      Address.new(addresses.join('|'))
    end

    def to_a
      @address.split('|')
    end

    def to_s
      @address
    end

    # start_time, end_time only work for this endpoint. why? no idea
    def received(options = {})
      Money.new(info('getreceivedbyaddress', options), 'BTC')
    end

    def sent(options = {})
      Money.new(info('getsentbyaddress', options), 'BTC')
    end

    def balance(options = {})
      Money.new(info('addressbalance', options), 'BTC')
    end

    # can only get one
    def firstseen(i = 0, options = {})
      DateTime.strptime(info('addressfirstseen', options, self.to_a[i]), '%s')
    end

    private def info(path, options, address = @address)
      start_time, end_time = options[:start], options[:end]
      confs = options[:confirmations] || 1
      full = "#{path}/#{address}?confirmations=#{confs}"
      full << "&#{start_time.strftime('%Q')}" unless start_time.nil?
      full << "&#{end_time.strftime('%Q')}" unless end_time.nil?
      Query.q("#{path}/#{address}?confirmations=#{confs}")
    end
  end
end