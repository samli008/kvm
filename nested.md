## host configure:
```
cat /sys/module/kvm_intel/parameters/nested  #display Y or N
```
## onboot enable kvm nested
```
cat > /etc/modprobe.d/kvm-intel.conf << EOF
options kvm_intel nested=1
options ignore_msrs=1
EOF
modprobe -r kvm_intel
modprobe kvm_intel
```
## update qeum-kvm
```
/usr/libexec/qemu-kvm -version
yum -y install centos-release-qemu-ev
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/CentOS-QEMU-EV.repo
yum --enablerepo=centos-qemu-ev -y install qemu-kvm-ev
systemctl restart libvirtd
/usr/libexec/qemu-kvm -version
```
