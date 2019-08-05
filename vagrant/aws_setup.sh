#!/usr/bin/env bash
VAGRANT_RPM=/tmp/vagrant_2.2.5_x86_64.rpm

sudo yum install -y qemu libvirt libvirt-devel ruby-devel gcc qemu-kvm libxslt-devel libxml2-devel libguestfs-tools-c

curl https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.rpm -o ${VAGRANT_RPM}
sudo yum install -y ${VAGRANT_RPM}
rm ${VAGRANT_RPM}
vagrant plugin install vagrant-libvirt
