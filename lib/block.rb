module Blockchain
  class Block
    RAWBLOCK = 'rawblock'
    attr_reader :hsh, :ver, :prev_block, :mrkl_root
    attr_reader :time, :bits, :nonce, :n_tx, :size
    attr_reader :block_index, :main_chain, :height, :received_time
    attr_reader :relayed_by, :transactions

    def initialize(b)
      meta_init(b)
    end

    # id can be block_hash or block_index
    def self.find(id)
      Block.new(Blockchain.raw_block(id)) rescue nil
    end

    def previous
      Block.find(@prev_block)
    end

    def meta_init(b)
      raw_txs = b.delete('tx')
      @hsh = b.delete('hash')
      b.each_key { |k| instance_variable_set("@#{k}", b[k]) }
      @time = DateTime.strptime(@time.to_s, '%s')
      @received_time = DateTime.strptime(@received_time.to_s, '%s')
      raw_txs # todo
    end
    private :meta_init
  end

end
