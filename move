virsh migrate --live $1 qemu+ssh://$2/system
virsh migrate --live $1 qemu+ssh://$2/system --persistent
