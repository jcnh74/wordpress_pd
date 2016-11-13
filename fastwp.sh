#!/bin/bash

# ./fastwp.sh create [cluster name] development-environment-149008
# ./fastwp.sh delete [cluster name] development-environment-149008



usage() { echo "Usage: $0 [-s <45|90>] [-p <string>]" 1>&2; exit 1; }

if [ -z "${1}" ]; then
    usage
fi

if [ $1 = "delete" ]; then
	echo $1
	#### Delete Pod Error
	if [ -z "$2" ]; then
		echo "ERROR: Need email"
	else
		/usr/bin/expect <<EOF

		set prompt "#|>|\\$"
		set timeout 500

		spawn gcloud auth activate-service-account 442059658580-compute@developer.gserviceaccount.com --key-file development-environment-149008.json --project ${2}
		expect prompt

		spawn gcloud config set core/project ${3}
		expect prompt
		
		spawn gcloud config set compute/zone us-west1-a
		expect prompt

		spawn gcloud container clusters get-credentials $2
		expect prompt
		
		spawn kubectl config set-cluster $2
		expect prompt

		spawn kubectl delete service wpfrontend
		expect prompt

		spawn kubectl delete service mysql
		expect prompt

		spawn kubectl delete pod wordpress
		expect prompt

		spawn kubectl delete pod mysql
		expect prompt

		spawn gcloud container clusters delete $2
		expect "(Y/n)?"
		send "Y\r"
		expect prompt

		spawn gcloud compute disks delete ${2}-mysql-disk ${2}-wordpress-disk
		expect "(Y/n)?"
		send "Y\r"
		expect prompt

EOF
		echo "finished deleting ${2}"
		clusters="$(gcloud container clusters list)"
		echo "${clusters}"
	fi
elif [ $1 = "create" ]; then
	if [ -z "$2" ]; then
		echo "ERROR: Need email"
	else
		#myhash=$(createHash "hanusek@gmail.com")
		echo "creating $2"
		# f1-micro, g1-small, n1-standard-1,
		/usr/bin/expect <<EOF

		set prompt "#|>|\\$"
		set timeout 500
		
		spawn gcloud auth activate-service-account 442059658580-compute@developer.gserviceaccount.com --key-file development-environment-149008.json --project ${2}
		expect prompt

		spawn gcloud config set core/project ${3}
		expect prompt
		
		spawn gcloud config set compute/zone us-west1-a
		expect prompt

		spawn gcloud container clusters create ${2} --num-nodes 2 --zone us-west1-a --machine-type g1-small
		expect prompt
			
EOF
		echo "finished ${2}"
		clusters="$(gcloud container clusters list)"
		echo "${clusters}"

		/usr/bin/expect <<EOF

		spawn gcloud compute disks create --size 200GB ${2}-mysql-disk
		expect prompt

		spawn gcloud compute disks create --size 200GB ${2}-wordpress-disk
		expect prompt

		spawn kubectl config set-cluster $2
		expect prompt

EOF
############################################
######### Customize MYSQL Pod File #########
#########          START           #########
############################################

		echo -e '$d\nw\nq'| ed mysql.yaml
		echo -e '$d\nw\nq'| ed mysql.yaml

		echo "        pdName: ${2}-mysql-disk" >> mysql.yaml
		echo "        fsType: ext4" >> mysql.yaml

/usr/bin/expect <<EOF

		spawn kubectl create -f mysql.yaml --validate=false
		expect prompt
EOF
		echo -e '$d\nw\nq'| ed mysql.yaml
		echo -e '$d\nw\nq'| ed mysql.yaml

		echo "        pdName: mysql-disk" >> mysql.yaml
		echo "        fsType: ext4" >> mysql.yaml

############################################
######### Customize MYSQL Pod File #########
#########          FINISH          #########
############################################

/usr/bin/expect <<EOF

		spawn kubectl create -f mysql-service.yaml --validate=false
		expect prompt
EOF

################################################
######### Customize WORDPRESS Pod File #########
#########             START            #########
################################################


		echo -e '$d\nw\nq'| ed wordpress.yaml
		echo -e '$d\nw\nq'| ed wordpress.yaml

		echo "        pdName: ${2}-wordpress-disk" >> wordpress.yaml
		echo "        fsType: ext4" >> wordpress.yaml

/usr/bin/expect <<EOF

		spawn kubectl create -f wordpress.yaml --validate=false
		expect prompt

EOF
		echo -e '$d\nw\nq'| ed wordpress.yaml
		echo -e '$d\nw\nq'| ed wordpress.yaml

		echo "        pdName: wordpress-disk" >> wordpress.yaml
		echo "        fsType: ext4" >> wordpress.yaml

################################################
######### Customize WORDPRESS Pod File #########
#########             FINISH           #########
################################################

/usr/bin/expect <<EOF

		spawn kubectl get pod wordpress
		expect prompt

		spawn kubectl create -f wordpress-service.yaml --validate=false
		expect prompt

		spawn kubectl get service wpfrontend
		expect prompt

		spawn kubectl describe service wpfrontend
		expect prompt

EOF
		echo "finished ${2}"
		wpfrontend="$(kubectl get services wpfrontend)"
		echo "${wpfrontend}"


	fi
else
	echo "nada"
fi