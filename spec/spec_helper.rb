require 'fakeweb'
require 'blockchain'

TEST_TRANSACTION = <<-eos
    {
      "hash":"b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da",
      "ver":1,
      "vin_sz":1,
      "vout_sz":2,
      "time":1408744310,
      "size":258,
      "relayed_by":"64.179.201.80",
      "block_height": 12200,
      "tx_index":"12563028",
      "result": 0,
      "inputs":[
        {
          "prev_out":{
            "n":1,
            "addr":"143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr",
            "value":"100000000",
            "tx_index":12554260,
            "type":0,
            "script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
          },
          "script":"76a914641ad5051edd97029a003fe9efb29359fcee409d88ac"
        }
      ],
      "out":[
        {
          "n": 0,
          "value": 100000,
          "addr": "13s5H9qsCDxsbCuZF5mGbg6rMLziQAnrxr",
          "tx_index": 62922222,
          "spent": true,
          "type": 0,
          "script": "76a9141f689f046aae32021905eeec37baef94dd591ff588ac"
        },
        {
          "n": 1,
          "value": 1883055,
          "addr": "143y8gQbhmgePi4QJyL6QBi8zk4PSM5KQr",
          "tx_index": 62922222,
          "spent": true,
          "type": 0,
          "script": "76a914217810f57fd7cdf79274c5d5e4a891fadc74887b88ac"
        }
      ]
    }
eos

TEST_BLOCK = <<-eos
    {
      "hash":"0000000000000bae09a7a393a8acded75aa67e46cb81f7acaa5ad94f9eacd103",
      "ver":1,
      "prev_block":"00000000000007d0f98d9edca880a6c124e25095712df8952e0439ac7409738a",
      "mrkl_root":"935aa0ed2e29a4b81e0c995c39e06995ecce7ddbebb26ed32d550a72e8200bf5",
      "time":1322131230,
      "bits":437129626,
      "nonce":2964215930,
      "fee":12345678,
      "n_tx":22,
      "size":9195,
      "block_index":818044,
      "main_chain":true,
      "height":154595,
      "received_time":1322131301,
      "relayed_by":"108.60.208.156",
      "tx": [#{TEST_TRANSACTION}]
    }
eos

TEST_ADDRESS = <<-eos
    {
      "hash160":"660d4ef3a743e3e696ad990364e555c271ad504b",
      "address":"1AJbsFZ64EpEfS5UAjAfcUG8pH8Jn3rn1F",
      "n_tx":17,
      "n_unredeemed":2,
      "total_received":1031350000,
      "total_sent":931250000,
      "final_balance":100100000,
      "txs": [#{TEST_TRANSACTION}]
    }
eos
