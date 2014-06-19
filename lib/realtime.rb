module Blockchain
  def self.difficulty
    BigDecimal.new(self.q('getdifficulty'))
  end

  def self.block_count
    self.q('getblockcount').to_i
  end

  def self.latest_hash
    self.q('latesthash')
  end

  def self.bc_per_block
    Btc.new(self.q('bcperblock'))
  end

  def self.total
    Btc.new(self.q('totalbc'))
  end

  def self.probability
    BigDecimal.new(self.q('probability'))
  end

  def self.hashes_to_win
    self.q('hashestowin').to_i
  end

  def self.next_retarget
    self.q('nextretarget').to_i
  end

  def self.avg_tx_size
    self.q('avgtxsize').to_i
  end

  def self.avg_tx_value
    self.q('avgtxvalue').to_i
  end

  def self.interval
    BigDecimal.new(self.q('interval'))
  end

  def self.eta
    BigDecimal.new(self.q('eta'))
  end

  def self.avg_tx_number
    self.q('avgtxnumber').to_i
  end
end