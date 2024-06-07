sudo pacman -S virt-manager qemu-full dnsmasq

sudo usermod -aG libvirt $USER

sudo systemctl enable libvirtd

sudo systemctl start libvirtd

sudo virsh net-start default