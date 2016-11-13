#!/bin/bash

# usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

# while getopts ":s:p:" o; do
#     case "${o}" in
#         s)
#             s=${OPTARG}
#             ((s == 45 || s == 90)) || usage
#             ;;
#         p)
#             p=${OPTARG}
#             ;;
#         *)
#             usage
#             ;;
#     esac
# done
# shift $((OPTIND-1))

# if [ -z "${s}" ] || [ -z "${p}" ]; then
#     usage
# fi

# echo "s = ${s}"
# echo "p = ${p}"
# echo "1 = $1"


echo -e '$d\nw\nq'| ed mysql.yaml
echo -e '$d\nw\nq'| ed mysql.yaml

echo "        pdName: hanusek-mysql-disk" >> mysql.yaml
echo "        fsType: ext4" >> mysql.yaml

echo -e '$d\nw\nq'| ed mysql.yaml
echo -e '$d\nw\nq'| ed mysql.yaml

echo "        pdName: mysql-disk" >> mysql.yaml
echo "        fsType: ext4" >> mysql.yaml

# echo -e '$d\nw\nq'| ed mysql.yaml
# echo -e '$d\nw\nq'| ed mysql.yaml

# echo "        pdName: mysql-disk" >> mysql.yaml
# echo "        fsType: ext4" >> mysql.yaml

# gke-vvsmedia-default-pool-a289df19-clnm
# gcloud compute ssh gke-vvsmedia-default-pool-a289df19-clnm

# wordpress
# gcloud compute --project "development-environment-149008" ssh --zone "us-west1-a" "gke-vvsmedia-default-pool-8c5135d0-fkwc"
# gcloud compute ssh gke-vvsmedia-default-pool-a289df19-clnm --command "cd /var; ls -al"
# gcloud compute ssh gke-vvsmedia-default-pool-8c5135d0-fkwc  

# kubectl exec wpfrontend -- "cd ~/; ls -al; pwd"

# kubectl describe pods wordpress-persistent-storage
# sudo docker exec -i -t vvsmedia-wordpress-disk /bin/bash 

# kubectl exec wordpress -- /bin/bash  -c "cd /home; ls -al; pwd"
# kubectl exec wordpress -- /bin/bash  -c "cd ~/; mkdir tmp; cd tmp; curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; php wp-cli.phar --info; chmod +x wp-cli.phar; mv wp-cli.phar /usr/local/bin/wp; wp --info"
# kubectl exec wordpress -- /bin/bash  -c "cd ~/tmp; ls -al; rm wp-cli.phar"
# kubectl exec wordpress -- /bin/bash  -c "sudo wpuser; wp --info"
# kubectl exec wordpress -- /bin/bash  -c "useradd -u 12345 -g users -d /home/wpuser -s /bin/bash -p $(echo surfer | openssl passwd -1 -stdin) wpuser"
# useradd -u 12345 -g users -d /home/wpuser -s /bin/bash -p $(echo surfer | openssl passwd -1 -stdin) wpuser
# kubectl exec wordpress -- /bin/bash  -c "cd ~/; ls -al"

# ssh vvsmedia-wordpress-disk.us-west1-a.development-environment-149008

# ssh wpfrontend.us-west1-a.development-environment-149008

# ssh -i ~/.ssh/gcp-key.pub hanusek@104.196.231.24

# ./fastwp.sh create vvsmedia development-environment-149008
# ./fastwp.sh delete vvsmedia development-environment-149008

# ./fastwp.sh create clemantine development-environment-149008
# ./fastwp.sh delete clemantine development-environment-149008

# gcloud compute development-environment-149008 describe
