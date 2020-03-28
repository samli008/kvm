# install kvm 
yum -y install qemu-kvm qemu-kvm-tools libvirt virt-install bridge-utils virt-manager libguestfs-tools createrepo lrzsz net-tools

systemctl start libvirtd
systemctl enable libvirtd

virsh net-destroy default
virsh net-undefine default

grep -c vmx /proc/cpuinfo

# view NVIDIA card id for vm
lspci -nn |grep -i nvidia
[root@GG33D33-172-31-1-5 ~]# lspci -n |grep 10de
18:00.0 0302: 10de:1eb8 (rev a1)
3b:00.0 0302: 10de:1eb8 (rev a1)
5e:00.0 0302: 10de:1eb8 (rev a1)
5f:00.0 0302: 10de:1eb8 (rev a1)
86:00.0 0302: 10de:1eb8 (rev a1)
87:00.0 0302: 10de:1eb8 (rev a1)
af:00.0 0302: 10de:1eb8 (rev a1)

# Edit GRUB entries include intel_iommu=on
vi /etc/default/grub 
GRUB_CMDLINE_LINUX="crashkernel=auto intel_iommu=on iommu=pt pci=realloc pci=nocrsrd blacklist=nouveau nouveau.modeset=0 pci-stub.ids=10de:1eb8 rhgb quiet"

# IOMMU config in grub to take effect need reboot.
grub2-mkconfig -o /boot/grub2/grub.cfg

# blacklist
cat > /etc/modprobe.d/blacklist.conf << EOF
blacklist nouveau
options nouveau modeset=0
EOF

# check nouveau disable
lsmod |grep nouveau

# Add your kernel module for VFIO-PCI
cat > /etc/modprobe.d/vfio.conf << EOF
options vfio-pci ids=10de:1eb8
EOF

# Add an entry to automatically load the module
cat > /etc/modules-load.d/vfio-pci.conf << EOF
vfio-pci
EOF

# Confirm IOMMU is functioning
dmesg | grep 'IOMMU enabled'

# Confirm VIFO is functioning
dmesg | grep -i vfio
