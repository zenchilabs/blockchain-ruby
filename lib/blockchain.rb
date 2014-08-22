module Blockchain
  ROOT = 'https://blockchain.info'

  def self.get(path)
    response = open("#{ROOT}/#{path}")
    response.read if response.status.first == '200'
  end

  def self.q(path)
    self.get("q/#{path}")
  end

  def self.rawblock(block)
    JSON.parse(self.get("rawblock/#{block}"))
  end

  def self.rawtx(tx)
    JSON.parse(self.get("rawtx/#{tx}"))
  end

  def self.rawaddr(address)
    JSON.parse(self.get("rawaddr/#{address}"))
  end
end

require 'money'
require 'bigdecimal'
require 'open-uri'
require 'date'
require 'btc'
require 'realtime'
require 'transaction'
require 'address'
require 'block'

