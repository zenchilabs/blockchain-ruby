module Blockchain
  class Address
    attr_reader :hash160, :address, :n_tx, :n_unredeemed, :total_received
    attr_reader :total_sent, :final_balance, :txs

    def self.find(address)
      self.new(Blockchain.rawaddr(address))
    end

    def initialize(a)
      a.each_key { |k| instance_variable_set("@#{k}", a[k]) }
      @total_received = Btc.from_satoshis(@total_received)
      @total_sent = Btc.from_satoshis(@total_sent)
      @final_balance = Btc.from_satoshis(@final_balance)
      txs # todo
    end

    # can only get one
    def firstseen
      DateTime.strptime(Blockchain.q("addressfirstseen/#{@address}"), '%s')
    end

    def to_s
      @address
    end
  end
end