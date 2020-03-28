yum -y install qemu-kvm qemu-kvm-tools libvirt virt-install bridge-utils virt-manager libguestfs-tools createrepo lrzsz net-tools

systemctl start libvirtd
systemctl enable libvirtd

virsh net-destroy default
virsh net-undefine default

grep -c vmx /proc/cpuinfo
