require 'spec_helper'
require 'blockchain'

describe Blockchain::Address do

  before :all do
    FakeWeb.allow_net_connect = false
    @test = '1EzwoHtiXB4iFwedPr49iywjZn2nnekhoj'
    @as = Blockchain::Address.from_multiple('1', '2', '3')
    @a = Blockchain::Address.new(@test)
  end

  it 'should add with other addresses' do
    c = @a + @as
    expect(c.to_a).to eq([@test, '1', '2', '3'])
  end

  it 'can take multiple addresses' do
    expect(@as.to_a).to eq(["1", "2", "3"])
  end

  it 'can take one address' do
    expect(@a.to_a).to eq([@test])
    expect(@a.to_s).to eq(@test)
  end

  it 'should get balance' do
    fake('addressbalance', '200000')
    expect(btc_equal(200000, @a.balance)).to be true
  end

  it 'should get received' do
    fake('getreceivedbyaddress', '1234.1234')
    expect(btc_equal(1234.1234, @a.received)).to be true
  end

  it 'should get sent' do
    fake('getsentbyaddress', '.000012345')
    expect(btc_equal(0.000012345, @a.sent)).to be true
  end

  it 'should get first seen' do
    fake('addressfirstseen', '1331482301')
    expect(@a.firstseen).to eq(DateTime.strptime('1331482301', '%s'))
    fake('addressfirstseen', '1331482301', @as.to_a[1])
    expect(@as.firstseen(1)).to eq(DateTime.strptime('1331482301', '%s'))
  end

  def btc_equal(amt, actual)
    Money.new(amt, 'BTC') == actual
  end

  def fake(path, body, address = @test)
    FakeWeb.register_uri(:get, "#{Blockchain::ROOT}/#{Blockchain::Q}/#{path}/#{address}?confirmations=1",
                         body: body, status: 200)
  end
end