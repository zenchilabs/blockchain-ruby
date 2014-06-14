module Blockchain

  ROOT = 'http://blockchain.info'

  def self.get(path)
    response = open("#{ROOT}/#{path}")
    response.read if response.status.first == '200'
  end

  module Query
    QUERY = 'q'

    def self.q(path)
      Blockchain.get("#{QUERY}/#{path}")
    end

  end
end

require 'bigdecimal'
require 'open-uri'
require 'date'
require_relative './query/realtime'
require_relative './query/address'
