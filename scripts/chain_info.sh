echo "\n---------- Block height and epoch -------------\n"
namadac next-epoch-info --node $RPC_NAMADA_MAINNET

echo "\n---------- Staking rewards -------------\n"
namadac staking-rewards-rate --node $RPC_NAMADA_MAINNET

echo "\n---------- Balances -------------\n"
echo "PGF balance -> $(namadac balance --owner pgf --node $RPC_NAMADA_MAINNET --token nam)"
echo "Gov balance -> $(namadac balance --owner governance --node $RPC_NAMADA_MAINNET --token nam)"

total_supply=$(namadac native-supply --node $RPC_NAMADA_MAINNET)
echo "Total native supply -> $total_supply"

echo "\n---------- Staked tokens -------------\n"
total_stake=$(namadac bonded-stake --epoch 10000 --node $RPC_NAMADA_MAINNET | grep 'Total bonded')
echo $total_stake

tot_stake=$(echo $total_stake | cut -d' ' -f4)
tot_supply=$(echo $total_supply | tr -d ' ' | cut -d':' -f2)
echo "Staked ratio: $(echo "scale=3; 100 * $tot_stake / $tot_supply" | bc)%"
