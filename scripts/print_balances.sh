tokens=("nam")

touch balances.out
echo
for addr in $(cat $NAMADA_CLI_TOOLS/accounts/transparent_accounts.txt); do
  echo "$addr ------------"
  for tok in "${tokens[@]}"; do
    output=$(namadac balance --owner $addr --token $tok --node $DO_RPC)
    echo $output
    echo $output | grep nam | cut -d' ' -f2 >> balances.out
  done
  echo
done

echo "Total balance: $(cat balances.out | awk '{sum += $1} END {print sum}') NAM"
rm balances.out
