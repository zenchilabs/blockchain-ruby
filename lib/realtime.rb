module Blockchain
  def self.difficulty
    BigDecimal.new(Query.q('getdifficulty'))
  end

  def self.block_count
    Query.q('getblockcount').to_i
  end

  def self.latest_hash
    Query.q('latesthash')
  end

  def self.bc_per_block
    Query.q('bcperblock').to_i
  end

  def self.total
    Query.q('totalbc').to_i
  end

  def self.probability
    BigDecimal.new(Query.q('probability'))
  end

  def self.hashes_to_win
    Query.q('hashestowin').to_i
  end

  def self.next_retarget
    Query.q('nextretarget').to_i
  end

  def self.avg_tx_size
    Query.q('avgtxsize').to_i
  end

  def self.avg_tx_value
    Query.q('avgtxvalue').to_i
  end

  def self.interval
    BigDecimal.new(Query.q('interval'))
  end

  def self.eta
    BigDecimal.new(Query.q('eta'))
  end

  def self.avg_tx_number
    Query.q('avgtxnumber').to_i
  end
end