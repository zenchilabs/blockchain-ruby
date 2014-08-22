module Blockchain
  class Transaction
    attr_reader :hsh, :ver, :vin_sz, :vout_sz, :lock_time, :size
    attr_reader :relayed_by, :block_height, :tx_index, :inputs, :out

    def self.find(transaction)
      self.new(Blockchain.rawtx(transaction))
    end

    def initialize(t)
      @hsh = t.delete('hash')
      t.each_key { |k| instance_variable_set("@#{k}", t[k]) }
      @inputs.map! { |i| Input.new(i) }
      @out.map! { |o| Output.new(o) }
    end

    def txtotalbtcoutput
      Btc.from_satoshis(Blockchain.q("txtotalbtcoutput/#{@hsh}"))
    end

    def txtotalbtcinput
      Btc.from_satoshis(Blockchain.q("txtotalbtcinput/#{@hsh}"))
    end

    def txfee
      Btc.from_satoshis(Blockchain.q("txfee/#{@hsh}"))
    end

    def ==(o)
      o.instance_variables == self.instance_variables
    end

    class Input
      attr_reader :script

      def initialize(i)
        @script = i['script']
        @prev_out = i['prev_out']
      end

      def prev_out
        Transaction.find(@prev_out['tx_index'])
      end
    end

    class Output
      attr_reader :value, :hsh, :script

      def initialize(o)
        @hsh = o['hash']
        @value = Btc.from_satoshis(o['value'])
        @script = o['script']
      end
    end
  end
end