module Blockchain
  class Block
    attr_reader :hsh, :ver, :prev_block, :mrkl_root
    attr_reader :time, :bits, :nonce, :n_tx, :size
    attr_reader :block_index, :main_chain, :height, :received_time
    attr_reader :relayed_by, :tx

    # id can be block_hash or block_index
    def self.find(id)
      self.new(Blockchain.rawblock(id)) rescue nil
    end

    def initialize(b)
      @hsh = b.delete('hash') # hash is an unfortunate word
      b.each_key { |k| instance_variable_set("@#{k}", b[k]) }
      @time = DateTime.strptime(@time.to_s, '%s')
      @received_time = DateTime.strptime(@received_time.to_s, '%s')
      tx # todo
    end

    def previous
      Block.find(@prev_block)
    end
  end

end
