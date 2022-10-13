#!/bin/bash

$1

clear 

for i in $(tail -n 1 /etc/hosts | awk '{ print $NF }' | cut -c 8)
do
        for hostname in $(echo "ansible$(echo $((1+$i)))")
        do
                echo "Nazwa nowej maszyny to: $hostname"
        done
        for ipadr in $(echo "192.168.0.$(echo $((161+$i)))")
        do
                echo "Adres ip nowej maszyny to: $ipadr"
                echo "$ipadr   $hostname" >> /etc/hosts
		echo "$1" > /home/ansible/ansible/FilipsBoom/inventory
        done
done
cat opie.sh | tail -n 19 | cut -b 2-560 > playbook.yml
sed -i s/hostnamescr/$hostname/g /home/ansible/ansible/FilipsBoom/playbook.yml
sed -i s/ipadresc/$ipadr/g /home/ansible/ansible/FilipsBoom/playbook.yml

ansible-playbook /home/ansible/ansible/FilipsBoom/playbook.yml

sleep 5s 

rm -f /home/ansible/ansible/FilipsBoom/playbook.yml

 
#---
#  - name: Swiatlosc
#    hosts: all
#    tasks:
#      - name: Reposy 1 z 2
#        raw: 'touch /etc/yum.repos.d/AppStream.repo; echo [AppStream] > /etc/yum.repos.d/AppStream.repo; echo name=AppStream >> /etc/yum.repos.d/AppStream.repo; echo baseurl=file:///repo/AppStream >> /etc/yum.repos.d/AppStream.repo; echo gpgcheck=0 >> /etc/yum.repos.d/AppStream.repo; touch /etc/yum.repos.d/BaseOS.repo; echo [BaseOS] > /etc/yum.repos.d/BaseOS.repo; echo "name=BaseOS" >> /etc/yum.repos.d/BaseOS.repo; echo baseurl=file:///repo/BaseOS >> /etc/yum.repos.d/BaseOS.repo; echo "gpgcheck=0" >> /etc/yum.repos.d/BaseOS.repo'
#      - name: Reposy 2 z 2
#        raw: 'mkdir /repo; echo "/dev/sr0     /repo    iso9660    defaults    0 0" >> /etc/fstab; mount -a;'
#      - name: Ansible user dodawany
#        raw: 'useradd ansible; echo "password" | passwd --stdin ansible; touch /etc/sudoers.d/ansible; echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible'
#      - name: Python3 instaleczka
#        raw: 'yum install python3 -y'
#      - name: Nazwa Hosta
#        raw: 'hostname hostnamescr'
#      - name: No i adresik jeszcze
#        raw: 'nmcli con mod enp0s3 +ipv4.addresses ipadresc'
#      - name: To juz koniec
#        raw: 'systemctl restart NetworkManager'
#...