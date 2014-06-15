module Blockchain
  ROOT = 'https://blockchain.info'

  def self.get(path)
    response = open("#{ROOT}/#{path}")
    response.read if response.status.first == '200'
  end

  module Query
    URI = 'q'
    def self.q(path)
      Blockchain.get("#{URI}/#{path}")
    end

  end
end

require 'money'
require 'bigdecimal'
require 'open-uri'
require 'date'
require 'realtime'
require 'address'
