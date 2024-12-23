touch bonds.out
echo
for addr in $(cat $NAMADA_CLI_TOOLS/accounts/transparent_accounts.txt); do
  echo "-- $addr ------------------------------\n"
  namadac bonds --owner $addr --node $DO_RPC
#  namadac bonds --owner $addr --node $DO_RPC >> bonds.out
#  echo $output
  namadac bonds --owner $addr --node $DO_RPC | grep 'All bonds total active' | cut -d' ' -f5 >> bonds.out
  echo
done

echo "----------------- TOTAL STAKED --------------------------\n"
echo "Total active bonded NAM: $(cat bonds.out | awk '{sum += $1} END {print sum}')"
rm bonds.out
