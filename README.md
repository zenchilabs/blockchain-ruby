blockchain-ruby
===============

Gives Rubyists the ability to traverse the blockchain in a semantic way.

The following functionality has been implemented:

Addresses
---------
Search for addresses with hash160 or address
returns `nil` if not found
~~~ruby
a = Blockchain::Address.find('143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr')
a.hash160 # => '217810f57fd7cdf79274c5d5e4a891fadc74887b'
a.address # => '143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr'
a.n_tx # => 143
a.n_unredeemed # => 56
a.total_received # => #<Btc BTC:0.00124124 mBTC:1.24124 uBTC:1241.24 Satoshis:124124.0>
a.total_sent # => #<Btc BTC:5.829e-05 mBTC:0.05829 uBTC:58.29 Satoshis:5829.0>
a.final_balance # => #<Btc BTC:0.00090215 mBTC:0.90215 uBTC:902.15 Satoshis:90215.0>
a.refresh! # refreshes the address
a.to_s # => '217810f57fd7cdf79274c5d5e4a891fadc74887b'
a.first_seen # => #<DateTime: 2014-08-22T18:05:32-04:00 ((2456892j,79532s,800786000n),-14400s,2299161j)>
txs = a.txs
~~~

Transactions
------------
Search for transactions with transaction index or hash
returns `nil` if not found
~~~ruby
t = txs[0]
t.hsh # => 'bebc1f8db50669d8ab7c7181aa92ffe3f170510d5894cb0a4100af23e335210f'
t.ver # => 1
t.vin_sz # => 1
t.vout_sz # => 2
t.time # => #<DateTime: 2014-08-22T18:05:32-04:00 ((2456892j,79532s,800786000n),-14400s,2299161j)>
t.size # => 258
t.result # => 0
t.relayed_by # => "127.0.01"
t.double_spend # => false
t.block_height # => 317010
t.tx_index # => 62922222

t.txtotalbtcoutput # => #<Btc BTC:0.00124124 mBTC:1.24124 uBTC:1241.24 Satoshis:124124.0>
t.txtotalbtcinput # => #<Btc BTC:5.829e-05 mBTC:0.05829 uBTC:58.29 Satoshis:5829.0>
t.txfee # => #<Btc BTC:0.00090215 mBTC:0.90215 uBTC:902.15 Satoshis:90215.0>

inputs = t.inputs # array of Blockchain::Transaction::Input
out = t.out # array of Blockchain::Transaction::Output

# INPUTs
i = inputs[0]
i.script # => '76a9141f689f046aae32021905eeec37baef94dd591ff588ac'
i.prev_out # => Blockchain::Transaction.find(62918382) | the tx_index of last tx

# OUTPUTs
o = out[0]
o.script # => '76a9141f689f046aae32021905eeec37baef94dd591ff588ac'
o.n # => 0
o.value # => 10000
o.addr # => '13s5H9qsCDxsbCuZF5mGbg6rMLziQAnrxr'
o.tx_index # => 62922222
o.spent # => true
o.type # => 0
~~~

Blocks
------
Search for blocks with block index or block hash
returns `nil` if not found
~~~ruby
b = Blockchain::Block.find(458453)
b.hsh # => '000000000000000024b816f859d85a955dfe8db09e3735d51755cb5f9cf2f63f'
b.ver # => 2
b.prev_block # => '00000000000000000894f4f2cbd1dbc8dd0b6d2f3a9a89582f5456516f2bc7d9'
b.mrkl_root # => 'baab986e40ac0ea11b7fff8f207b9c8cdbcf49b6b58e66829f8fe9cc5c017e09'
b.time # => #<DateTime: 2014-08-22T22:12:23+00:00 ((2456892j,79943s,0n),+0s,2299161j)>
b.bits # => 405675096
b.fee # => #<Btc BTC:0.16328705 mBTC:163.28705 uBTC:163287.05 Satoshis:16328705.0>
b.nonce # => 2030590116
b.n_tx # => 979
b.size # => 539809
b.block_index # => 458453
b.main_chain # => true
b.height # => 317016
b.received_time # => #<DateTime: 2014-08-22T22:12:23+00:00 ((2456892j,79943s,0n),+0s,2299161j)>
b.relayed_by # => "193.187.79.76"
b.tx # => array of Blockchain::Transaction in the block
~~~



