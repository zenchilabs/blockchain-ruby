module Blockchain
  module Query

    def getdifficulty
      BigDecimal.new(q('getdifficulty'))
    end

    def getblockcount
      q('getblockcount').to_i
    end

    def latesthash
      q('latesthash')
    end

    def bcperblock
      q('bcperblock').to_i
    end

    def totalbc
      q('totalbc').to_i
    end

    def probability
      BigDecimal.new(q('probability'))
    end

    def hashestowin
      q('hashestowin').to_i
    end

    def nextretarget
      q('nextretarget').to_i
    end

    def avgtxsize
      q('avgtxsize').to_i
    end

    def avgtxvalue
      q('avgtxvalue').to_i
    end

    def interval
      BigDecimal.new(q('interval'))
    end

    def eta
      BigDecimal.new(q('eta'))
    end

    def avgtxnumber
      q('avgtxnumber').to_i
    end
  end
end