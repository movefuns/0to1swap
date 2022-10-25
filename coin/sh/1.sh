curl --location --request POST https://faucet.devnet.aptoslabs.com/mint?address=0x78688dee28de03ca4c52a4e2775af16a86410c5380b21329492331913ee5ab8f&amount=10000000000000000


aptos move publish  --gas-unit-price 100



aptos move run --assume-yes --function-id 0x78688dee28de03ca4c52a4e2775af16a86410c5380b21329492331913ee5ab8f::usdc::init

aptos move run --assume-yes --function-id 0x78688dee28de03ca4c52a4e2775af16a86410c5380b21329492331913ee5ab8f::usdt::init





aptos move run --assume-yes --function-id 0x78688dee28de03ca4c52a4e2775af16a86410c5380b21329492331913ee5ab8f::usdc::mint_me  --args u64:10000000000
aptos move run --assume-yes --function-id 0x78688dee28de03ca4c52a4e2775af16a86410c5380b21329492331913ee5ab8f::usdt::mint_me  --args u64:10000000000

