blockchain-ruby
===============

Gives Rubyists the ability to traverse the blockchain in a semantic way.

The following functionality has been implemented:

Addresses
---------
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
~~~ruby
t = txs[0]
t.hsh # => '


