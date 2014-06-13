module Blockchain
  module Query

    def self.getdifficulty
      BigDecimal.new(q('getdifficulty'))
    end

    def self.getblockcount
      q('getblockcount').to_i
    end

    def self.latesthash
      q('latesthash')
    end

    def self.bcperblock
      q('bcperblock').to_i
    end

    def self.totalbc
      q('totalbc').to_i
    end

    def self.probability
      BigDecimal.new(q('probability'))
    end

    def self.hashestowin
      q('hashestowin').to_i
    end

    def self.nextretarget
      q('nextretarget').to_i
    end

    def self.avgtxsize
      q('avgtxsize').to_i
    end

    def self.avgtxvalue
      q('avgtxvalue').to_i
    end

    def self.interval
      BigDecimal.new(q('interval'))
    end

    def self.eta
      BigDecimal.new(q('eta'))
    end

    def self.avgtxnumber
      q('avgtxnumber').to_i
    end
  end
end