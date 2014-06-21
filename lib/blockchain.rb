module Blockchain
  ROOT = 'https://blockchain.info'
  Q = 'q'
  RAWBLOCK = 'rawblock'

  def self.get(path)
    response = open("#{ROOT}/#{path}")
    response.read if response.status.first == '200'
  end

  def self.q(path)
    self.get("#{Q}/#{path}")
  end

  def self.raw_block(path)
    JSON.parse(self.get("#{RAWBLOCK}/#{path}"))
  end

end

require 'money'
require 'bigdecimal'
require 'open-uri'
require 'date'
require 'btc'
require 'realtime'
require 'address'
require 'block'

