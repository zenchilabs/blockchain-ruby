require 'spec_helper'
require 'blockchain'

describe Blockchain do

  before :all do
    FakeWeb.allow_net_connect = false
    @test_i = 123456
    @test_i_s = '123456'
    @test_f = 12345.12345
    @test_f_s = '12345.12345'
  end

  it 'should get difficulty' do
    fake('getdifficulty', @test_f_s)
    expect(Blockchain.difficulty.to_f).to eq(@test_f)
  end

  it 'should get blockcount' do
    fake('getblockcount', @test_i_s)
    expect(Blockchain.block_count).to eq(@test_i)
  end

  it 'should get latesthash' do
    fake('latesthash', @test_i_s)
    expect(Blockchain.latest_hash).to eq(@test_i_s)
  end

  it 'should get bcperblock' do
    fake('bcperblock', @test_i_s)
    expect(Blockchain.bc_per_block).to eq(@test_i)
  end

  it 'should get total' do
    fake('totalbc', @test_i_s)
    expect(Blockchain.total).to eq(@test_i)
  end

  it 'should get probability' do
    fake('probability', @test_f_s)
    expect(Blockchain.probability.to_f).to eq(@test_f)
  end

  it 'should get hashestowin' do
    fake('hashestowin', @test_i_s)
    expect(Blockchain.hashes_to_win).to eq(@test_i)
  end

  it 'should get nextretarget' do
    fake('nextretarget', @test_i_s)
    expect(Blockchain.next_retarget).to eq(@test_i)
  end

  it 'should get avg_tx_size' do
    fake('avgtxsize', @test_i_s)
    expect(Blockchain.avg_tx_size).to eq(@test_i)
  end

  it 'should get avg_tx_value' do
    fake('avgtxvalue', @test_i_s)
    expect(Blockchain.avg_tx_value).to eq(@test_i)
  end

  it 'should get avg_tx_number' do
    fake('avgtxnumber', @test_i_s)
    expect(Blockchain.avg_tx_number).to eq(@test_i)
  end

  it 'should get interval' do
    fake('interval', @test_f_s)
    expect(Blockchain.interval.to_f).to eq(@test_f)
  end

  it 'should get eta' do
    fake('eta', @test_f_s)
    expect(Blockchain.eta.to_f).to eq(@test_f)
  end

  def fake(path, body)
    FakeWeb.register_uri(:get, "#{Blockchain::ROOT}/#{Blockchain::Q}/#{path}",
                         body: body,  status: 200)
  end
end