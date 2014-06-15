module Blockchain
  ROOT = 'https://blockchain.info'
  Q = 'q'

  def self.get(path)
    response = open("#{ROOT}/#{path}")
    response.read if response.status.first == '200'
  end

  def self.q(path)
    self.get("#{Q}/#{path}")
  end

end

require 'money'
require 'bigdecimal'
require 'open-uri'
require 'date'
require 'realtime'
require 'address'
