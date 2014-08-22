require 'spec_helper'


describe Blockchain::Transaction do

  TEST_TRANSACTION = <<-eos
    {
      "hash":"b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da",
      "ver":1,
      "vin_sz":1,
      "vout_sz":2,
      "lock_time":"Unavailable",
      "size":258,
      "relayed_by":"64.179.201.80",
      "block_height": 12200,
      "tx_index":"12563028",
      "inputs":[
        {
          "prev_out":{
            "hash":"a3e2bcc9a5f776112497a32b05f4b9e5b2405ed9",
            "value":"100000000",
            "tx_index":"12554260",
            "n":"2"
          },
          "script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
        }
      ],
      "out":[
        {
          "value":"98000000",
          "hash":"29d6a3540acfa0a950bef2bfdc75cd51c24390fd",
          "script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
        },
        {
          "value":"2000000",
          "hash":"17b5038a413f5c5ee288caa64cfab35a0c01914e",
          "script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
        }
      ]
    }
  eos

  before :all do
    FakeWeb.allow_net_connect = true
    @test = 'b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da'
    fake(@test, TEST_TRANSACTION)
    @t = Blockchain::Transaction.find(@test)
  end

  it 'should parse and store all basic fields' do
    expect(@t.hsh).to eq('b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da')
    expect(@t.ver).to eq (1)
    expect(@t.vin_sz).to eq(1)
    expect(@t.vout_sz).to eq(2)
    expect(@t.lock_time).to eq("Unavailable")
    expect(@t.size).to eq(258)
    expect(@t.relayed_by).to eq("64.179.201.80")
    expect(@t.block_height).to eq(12200)
    expect(@t.tx_index).to eq("12563028")
  end

  describe Blockchain::Transaction::Input do
    before :all do
      @is = @t.inputs
    end

    it 'should assign script correctly' do
      expect(@is[0].script).to eq('76a914641ad5051edd97029a003fe9efb29359fcee409d88ac')
    end

    it 'should return prevout as a transaction' do
      expect(@is[0].prev_out).to be_a(Blockchain::Transaction)
    end

  end

  describe Blockchain::Transaction::Output do
    before :all do
      @os = @t.out
    end

    it 'should assign first out correctly' do
      o = @os[0]
      expect(o.hsh).to eq('29d6a3540acfa0a950bef2bfdc75cd51c24390fd')
      expect(o.value).to eq(Btc.from_satoshis('98000000'))
      expect(o.script).to eq('76a914641ad5051edd97029a003fe9efb29359fcee409d88ac')
    end

    it 'should assign second out correctly' do
      o = @os[1]
      expect(o.hsh).to eq('17b5038a413f5c5ee288caa64cfab35a0c01914e')
      expect(o.value).to eq(Btc.from_satoshis('2000000'))
      expect(o.script).to eq('76a914641ad5051edd97029a003fe9efb29359fcee409d88ac')
    end
  end

  def fake(t, body)
    FakeWeb.register_uri(:get,
                         "#{Blockchain::ROOT}/rawtx/#{t}",
                         body: body, status: 200)
  end
end
