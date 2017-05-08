# You can search by 0, 1, or 2 keywords
function ec2hosts {
  aws ec2 describe-instances --filters "Name=instance-state-code,Values=16" "Name=tag:Name,Values=*$1*$2*" --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value[],PrivateIpAddress,PublicIpAddress]' | grep '"' | sed 's/[ ",]//g'
}

# First arg is env, second (optional) arg is command; ssh agent auth-forwarding enabled
function onjump {
  unset CMD
  for word in "${@:2}"; do
    CMD=("${CMD[@]}" `printf %q "$word"`)
  done
  if [ -z "$CMD" ] || ! [ -z "$FORCE_TTY" ]; then
    T="-t"
  else
    T=""
  fi
  ssh $T -A `ec2hosts $1 jump | sed '3q;d'` "${CMD[@]}"
}

# First arg is env, second arg is service, optional third arg is command
# This is tricky, because one host may not be running the service
function onservice {
  if [ -z "$3" ] || ! [ -z "$FORCE_TTY" ]; then
    T="-t"
  else
    T=""
  fi
  HOST1=`ec2hosts $1 $2 | sed '2q;d'`
  HOST2=`ec2hosts $1 $2 | sed '4q;d'`
  HOST=$HOST1
  # We have to not consume stdin here, saving it for the final ssh; thus </dev/null
  if ! ( </dev/null onhost $1 $HOST docker ps | grep $2 >/dev/null ); then
    HOST=$HOST2
  fi
  CID=`</dev/null onhost $1 $HOST docker ps | grep $2 | awk '{print \$1}'`
  if [ -z "$CID" ]; then
    >&2 echo "No service running on $HOST1 or $HOST2?!"
    return
  fi
  FORCE_TTY=$T onhost $1 $HOST docker exec $T -i $CID ${3:-sh} "${@:4}"
}

# First arg is jumpbox env, second arg is internal host IP, third arg is command
function onhost {
  unset CMD
  for word in "${@:3}"; do
    CMD=("${CMD[@]}" `printf %q "$word"`)
  done
  if [ -z "$CMD" ] || ! [ -z "$FORCE_TTY" ]; then
    T="-t"
  else
    T=""
  fi
  FORCE_TTY=$T onjump $1 ssh $T -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $2 "${CMD[@]}"
}

