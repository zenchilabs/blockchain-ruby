module Blockchain
  class Block
    RAWBLOCK = 'rawblock'
    INDEX = 'block-index'
    attr_reader :hash, :ver, :prev_block, :mrkl_root
    attr_reader :time, :bits, :nonce, :n_tx, :size
    attr_reader :block_index, :main_chain, :height, :received_time
    attr_reader :relayed_by, :transactions

    def initialize(id)
      return if id.nil?
      meta_init(Block.raw_block(id))
    end

    def previous
      Block.new(@prev_block)
    end

    def meta_init(b)
      raw_txs = b.delete('tx')
      b.each_key { |k| instance_variable_set("@#{k}", b[k]) }
      @time = DateTime.strptime(@time.to_s, '%s')
      @received_time = DateTime.striptime(@received_time, '%s')
      raw_txs # todo
    end
    private :meta_init

    def self.raw_block(query)
      JSON.parse(Blockchain.get("#{RAWBLOCK}/#{query}"))
    end
  end
end
