echo
for addr in $(cat $NAMADA_CLI_TOOLS/accounts/transparent_accounts.txt); do
  echo "$addr ------------\n"
  for val in $(namadac bonds --owner $addr --node $DO_RPC | grep 'Delegations from' | cut -d' ' -f5 | tr -d ':'); do
    echo "$val -> $(namadac rewards --source $addr --validator $val --node $DO_RPC)"
  done
  echo
done
