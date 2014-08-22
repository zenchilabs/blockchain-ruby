module Blockchain
  class Address
    attr_reader :hash160, :address, :total_received
    attr_reader :total_sent, :final_balance, :txs

    def self.find(address)
      self.new(Blockchain.rawaddr(address)) rescue nil
    end

    def initialize(a)
      meta_init(a)
    end

    private def meta_init(a)
      a.each_key { |k| instance_variable_set("@#{k}", a[k]) }
      @total_received = Btc.from_satoshis(@total_received || 0)
      @total_sent = Btc.from_satoshis(@total_sent || 0)
      @final_balance = Btc.from_satoshis(@final_balance || 0)
      @txs.map! { |t| Blockchain::Transaction.new(t) }
    end

    def n_tx
      @n_tx || 0
    end

    def n_unredeemed
      @n_unredeemed || 0
    end

    def firstseen
      DateTime.strptime(Blockchain.q("addressfirstseen/#{@address}"), '%s')
    end

    def to_s
      @address
    end

    def ==(o)
      o.instance_variables == self.instance_variables
    end

    def refresh!
      address = @address
      instance_variables.each { |i| instance_variable_set(i, nil) }
      meta_init(Blockchain.rawaddr(address))
    end
  end
end