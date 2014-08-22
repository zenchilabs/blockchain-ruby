require 'spec_helper'

describe Blockchain do

  TEST_BLOCK = <<-eos
    {
      "hash":"0000000000000bae09a7a393a8acded75aa67e46cb81f7acaa5ad94f9eacd103",
      "ver":1,
      "prev_block":"00000000000007d0f98d9edca880a6c124e25095712df8952e0439ac7409738a",
      "mrkl_root":"935aa0ed2e29a4b81e0c995c39e06995ecce7ddbebb26ed32d550a72e8200bf5",
      "time":1322131230,
      "bits":437129626,
      "nonce":2964215930,
      "n_tx":22,
      "size":9195,
      "block_index":818044,
      "main_chain":true,
      "height":154595,
      "received_time":1322131301,
      "relayed_by":"108.60.208.156",
      "tx": {}
    }
  eos

  before(:each) do
    FakeWeb.allow_net_connect = false
  end

  describe '.find' do
    it 'should return nil if invalid raw block' do
      FakeWeb.allow_net_connect = true
      expect(Blockchain::Block.find('nonsense')).to be_nil
    end

    it 'it should init all fields' do
      fake('someid', TEST_BLOCK)
      b = Blockchain::Block.find('someid')
      expect(b.hsh).to eq('0000000000000bae09a7a393a8acded75aa67e46cb81f7acaa5ad94f9eacd103')
      expect(b.ver).to eq(1)
      expect(b.prev_block).to eq('00000000000007d0f98d9edca880a6c124e25095712df8952e0439ac7409738a')
      expect(b.mrkl_root).to eq('935aa0ed2e29a4b81e0c995c39e06995ecce7ddbebb26ed32d550a72e8200bf5')
      expect(b.time).to eq(DateTime.strptime('1322131230', '%s'))
      expect(b.bits).to eq(437129626)
      expect(b.nonce).to eq(2964215930)
      expect(b.n_tx).to eq(22)
      expect(b.size).to eq(9195)
      expect(b.block_index).to eq(818044)
      expect(b.main_chain).to eq(true)
      expect(b.height).to eq(154595)
      expect(b.received_time).to eq(DateTime.strptime('1322131301', '%s'))
      expect(b.relayed_by).to eq('108.60.208.156')
      expect(b.tx).to eq({})
    end
  end

  def fake(id, body)
    FakeWeb.register_uri(:get, "#{Blockchain::ROOT}/rawblock/#{id}",
                         body: body, status: 200)
  end

end