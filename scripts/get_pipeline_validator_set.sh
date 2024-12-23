epoch=$(namadac epoch --node $RPC_NAMADA_MAINNET | cut -d' ' -f4)
pipeline_epoch=$(($epoch + 2))
echo "Pipeline epoch right now = $pipeline_epoch"
namadac bonded-stake --epoch $pipeline_epoch --node $RPC_NAMADA_MAINNET > validator_set_pipeline.out
total_stake=$(cat validator_set_pipeline.out | grep 'Total bonded' | cut -d' ' -f4)

num_vals=25

echo "\nTop $num_vals validators by fractional stake:"
for line in $(cat validator_set_pipeline.out| grep tnam | head -n $num_vals | tr -d ' '); do
  addr=$(echo $line | cut -d':' -f1)
  stake=$(echo $line | cut -d':' -f2)
  frac=$(echo "scale=4; 100* $stake / $total_stake" | bc)
  name=$(namadac validator-metadata --validator $addr --node $RPC_NAMADA_MAINNET | grep name | cut -d':' -f2)
  echo "${frac}% ----- $name"
done
