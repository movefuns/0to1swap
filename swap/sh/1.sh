aptos move publish  --assume-yes  --gas-unit-price 100


curl --location --request POST https://faucet.devnet.aptoslabs.com/mint?address=0xb0e40f8cf1da627d68db58f31c51dad6e2cc60c8ff8ef647cb5de6aa518b01cd&amount=10000000000000000


aptos move run --assume-yes --function-id 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::mint_me  --args u64:10000000000
aptos move run --assume-yes --function-id 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdt::mint_me  --args u64:10000000000


aptos move run --assume-yes --function-id 0xb0e40f8cf1da627d68db58f31c51dad6e2cc60c8ff8ef647cb5de6aa518b01cd::router::create_pool --type-args 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::USDC  0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdt::USDT


aptos move run --assume-yes --function-id 0xb0e40f8cf1da627d68db58f31c51dad6e2cc60c8ff8ef647cb5de6aa518b01cd::router::add_to_pool --type-args 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::USDC  0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdt::USDT --args u64:10000000000 u64:10000000000


aptos move run --assume-yes --function-id 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::mint_me  --args u64:1000

aptos move run --assume-yes --function-id 0xb0e40f8cf1da627d68db58f31c51dad6e2cc60c8ff8ef647cb5de6aa518b01cd::router::swap --type-args 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::USDC  0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdt::USDT --args u64:1000


aptos move run --assume-yes --function-id 0xb0e40f8cf1da627d68db58f31c51dad6e2cc60c8ff8ef647cb5de6aa518b01cd::router::swap --type-args 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdt::USDT 0x5b20f9e4788b60e78f42f93ca9feaac9d8a1e3143a64d7e389c088927abee177::usdc::USDC   --args u64:1000


