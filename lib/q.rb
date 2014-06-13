module Blockchain
  module Q
    SUBROOT = 'q'
    PATH = "#{Blockchain::ROOT}/#{SUBROOT}"

    def getdifficulty
      BigDecimal.new(get('getdifficulty'))
    end

    def getblockcount
      get('getblockcount').to_i
    end

    def latesthash
      get('latesthash')
    end

    def bcperblock
      get('bcperblock').to_i
    end

    def totalbc
      get('totalbc').to_i
    end

    def probability
      BigDecimal.new(get('probability'))
    end

    def hashestowin
      get('hashestowin').to_i
    end

    def nextretarget
      get('nextretarget').to_i
    end

    def get(path)
      response = open("#{PATH}/#{path}")
      response.read if response.status.first == '200'
    end
  end
end