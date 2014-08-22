require 'spec_helper'


describe Blockchain::Transaction do

  before :all do
    FakeWeb.allow_net_connect = true
    @test = 'b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da'
    fake(@test, TEST_TRANSACTION)
    @t = Blockchain::Transaction.find(@test)
  end

  it 'should return txtotalbtcoutput' do
    fake_q("txtotalbtcoutput/#{@test}", '12345')
    expect(@t.txtotalbtcoutput).to eq(Btc.from_satoshis('12345'))
  end

  it 'should return txtotalbtcinput' do
    fake_q("txtotalbtcinput/#{@test}", '12345')
    expect(@t.txtotalbtcinput).to eq(Btc.from_satoshis('12345'))
  end

  it 'should return txfee' do
    fake_q("txfee/#{@test}", '12345')
    expect(@t.txfee).to eq(Btc.from_satoshis('12345'))
  end

  it 'should parse and store all basic fields' do
    expect(@t.hsh).to eq('b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da')
    expect(@t.ver).to eq (1)
    expect(@t.vin_sz).to eq(1)
    expect(@t.vout_sz).to eq(2)
    expect(@t.time).to eq(DateTime.strptime('1408744310', '%s'))
    expect(@t.size).to eq(258)
    expect(@t.relayed_by).to eq("64.179.201.80")
    expect(@t.block_height).to eq(12200)
    expect(@t.tx_index).to eq("12563028")
    expect(@t.result).to eq(0)
    expect(@t.double_spend).to be_falsey
  end

  describe Blockchain::Transaction::Input do
    before :all do
      @is = @t.inputs
    end

    it 'should assign prev out fields correctly' do
      expect(@is[0].script).to eq('76a914641ad5051edd97029a003fe9efb29359fcee409d88ac')
      expect(@is[0].addr).to eq('143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr')
      expect(@is[0].n).to eq(1)
      expect(@is[0].tx_index).to eq(12554260)
    end

    it 'should return prevout as a transaction' do
      expect(@is[0].prev_out).to be_a(Blockchain::Transaction)
    end

  end

  describe Blockchain::Transaction::Output do
    before :all do
      @os = @t.out
    end

    it 'should assign second out correctly' do
      o = @os[1]
      expect(o.n).to eq(1)
      expect(o.addr).to eq('143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr')
      expect(o.tx_index).to eq(62922222)
      expect(o.spent).to eq(true)
      expect(o.type).to eq(0)
      expect(o.script).to eq('76a914217810f57fd7cdf79274c5d5e4a891fadc74887b88ac')
    end
  end

  def fake(t, body)
    FakeWeb.register_uri(:get,
                         "#{Blockchain::ROOT}/rawtx/#{t}",
                         body: body, status: 200)
  end

  def fake_q(path, body)
    FakeWeb.register_uri(:get,
                         "#{Blockchain::ROOT}/q/#{path}",
                         body: body, status: 200)
  end
end
