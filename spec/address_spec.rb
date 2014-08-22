require 'spec_helper'

describe Blockchain::Address do

  before :all do
    FakeWeb.allow_net_connect = false
    @test = '1AJbsFZ64EpEfS5UAjAfcUG8pH8Jn3rn1F'
    fake_raw(TEST_ADDRESS)
    @a = Blockchain::Address.find(@test)
  end

  it 'should get first seen' do
    fake_q('addressfirstseen', '1331482301')
    expect(@a.firstseen).to eq(DateTime.strptime('1331482301', '%s'))
  end

  it 'should init all fields' do
    expect(@a.hash160).to eq('660d4ef3a743e3e696ad990364e555c271ad504b')
    expect(@a.address).to eq('1AJbsFZ64EpEfS5UAjAfcUG8pH8Jn3rn1F')
    expect(@a.n_tx).to eq(17)
    expect(@a.n_unredeemed).to eq(2)
    expect(@a.total_received).to eq(Btc.from_satoshis(1031350000))
    expect(@a.total_sent).to eq(Btc.from_satoshis(931250000))
    expect(@a.final_balance).to eq(Btc.from_satoshis(100100000))
    expect(@a.txs).to eq([Blockchain::Transaction.new(JSON.parse(TEST_TRANSACTION))])
  end

  def fake_q(path, body, address = @test)
    FakeWeb.register_uri(:get,
                         "#{Blockchain::ROOT}/q/#{path}/#{address}",
                         body: body, status: 200)
  end

  def fake_raw(body, address = @test)
    FakeWeb.register_uri(:get,
                         "#{Blockchain::ROOT}/rawaddr/#{address}",
                         body: body, status: 200)
  end
end