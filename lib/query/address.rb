module Blockchain
  module Query
    class Address

      attr_accessor :addresses

      def initialize(*addresses)
        @addresses= addresses
      end

      # start_time, end_time only work for this endpoint. why? no idea
      def received(options = {})
        BigDecimal.new(endpoint('getreceivedbyaddress', options))
      end

      def sent(options = {})
        BigDecimal.new(endpoint('getsentbyaddress', options))
      end

      def balance(options = {})
        BigDecimal.new(endpoint('addressbalance', options))
      end

      # can only get one
      def firstseen(index = 0, options = {})
        DateTime.strptime(endpoint('addressfirstseen', options, @addresses[index]), '%s')
      end

      def endpoint(path, options, addresses = @addresses)
        start_time, end_time = options[:start], options[:end]
        confs = options[:confirmations] || 1
        full = "#{path}/#{addresses.join("|")}?confirmations=#{confs}"
        full << "&#{start_time.strftime('%Q')}" unless start_time.nil?
        full << "&#{end_time.strftime('%Q')}" unless end_time.nil?
        q("#{path}/#{joined}?confirmations=#{confs}")
      end
      private :endpoint
    end

  end
end