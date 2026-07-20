gedit u-boot.cfg&
tkdiff u-boot.cfg ../../../../build_northwest_aurora/buildroot-2017.02/output/build/uboot-custom/u-boot.cfg &
gedit u-boot.cfg &
s
ls
cd build/
ls
cd linux-custom/
ls
cd fs
ls
s
ls
s
cd images/
ls
ll
ss
ls
s
ls
cd buildroot-2022.08.2
ls
s
ls
cd build_2022_northwest_aurora
ls
less README 
ls pd
ls
s
ls
cd build_2022_north_aurora
ls
ls pd
ls pd/kernel/
s
ls
cd buildroot
ls
less run_fred.sh 
less generateBuildroot_fred.sh 
ls
tkdiff generateBuildroot_fred.sh generateBuildroot.sh &
ls
ls pd/uboot/
tkdiff pd/uboot/uboot_config ../build_2022_northwest_aurora/pd/uboot/uboot_config 
tkdiff pd/uboot/uboot_config ../build_2022_north_aurora/pd/uboot/uboot_config 
s
ls
tkdiff build_2022_northwest_aurora/pd/uboot/uboot_config build_northwest_aurora/pd/uboot/uboot_config 
tkdiff build_2022_north_aurora/pd/uboot/uboot_config build_north_aurora/pd/uboot/uboot_config 
cd build_2022_northwest_aurora
ls
ls configs/
ls
cd boot/
ls
cd uboot/
ls
ll
less Config.in 
ls
s
ls
ll
s
ls
cd pd
ls
cd uboot/
ls
ll
less uboot_config 
ss
ls
s
ls
less buildroot-2022.08.2/pd/uboot/uboot_config 
ll
tkdiff buildroot-2022.08.2/pd/uboot/uboot_config buildroot/pd/uboot/uboot_config &
mkdir prodesign_buildroot
ls 
cd /media/demelo/toshiba/wizard/archive_arnstadt/buildroot/
ls
cd /media/demelo/toshiba/wizard/archive_arnstadt/
ls
cd buildroot/
ls
tar -xvzf buildroot.tar.gz ./prodesign_buildroot
cp buildroot.tar.gz ./prodesign_buildroot/
cd prodesign_buildroot/
ls
tar -xvzf buildroot.tar.gz .
gunzip -c buildroot.tar.gz .tar.gz | tar -xvf -
ls
cd buildroot/
ls
tkdiff pd/uboot/uboot_config ../../build_2022_northwest_aurora/pd/uboot/uboot_config &
ss
ls
cd buildroot-2022.08.2/
ls
cd pd
ls
cd uboot/
ls
cd u-boot-xlnx-master/
ls
cd configs/
ls
ss
s
ls
cd build_2022_northwest_aurora
ls
s
ls
gedit buildroot/generateBuildroot_fred.sh &
cd build_2022_northwest_aurora
sl
ls
cd configs/
ls
less pd_zynq_defconfig 
s
ls
cd pd/
ls
cd kernel/
ls
s
ls
less xilinx_zynq_defconfig 
ls
tkdiff xilinx_zynq_defconfig ~/Téléchargements/linux-xlnx-master/arch/arm/configs/xilinx_zynq_defconfig &
s
cd /media/demelo/toshiba/wizard/archive_arnstadt/buildroot/
ls
cd build_2022_northwest_aurora
ls
cd pd
ls
gedit xilinx_zynq_defconfig &
ls configs/
ss
cd buildroot-2022.08.2/pd/kernel/
ls
sudo minicom -s
sudo minicom -s
sudo minicom -s
sudo minicom usb2
teamviewer &
ls
less helloworld
less minicom.log 
exit
i=5
i='expr $i + 1'
echo $i
cd
cd Téléchargements/
ls
gedit chat.pgm &
gedit chat_ascii.pgm &
gedit baboon.ascii.pgm &
ls
cd vivado_prjs/testbench_eads/vhdl/tst/ImageTests/
ls
less baboon.imv 
ll
gedit baboon.imv &
gedit pgm2imv_512_512.sh &
./pgm2imv_512_512.sh baboon.pgm 
gedit baboon.imv &
gedit baboon.pgm &
./pgm2imv_512_512.sh baboon.pgm 
gimp baboon.pgm &
cd
cd Téléchargements/
ll *.pgm
less lena.pgm 
rm -f *.pgm
ll *.pgm
less lena.pgm 
rm -f *.pgm
less surf.pgm 
less lena.512.pgm 
rm -f *.pgm
ls
cd vivado_prjs/testbench_eads/vhdl/tst/ImageTests/
ls
gedit imv2pgm_256_233.sh
bg
ls
gedit pgm2imv_512_512.sh &
gedit baboon.pgm &
./pgm2imv_512_512.sh baboon.pgm 
gedit robert &
gedit baboon.imv &
./pgm2imv_512_512.sh baboon.pgm 
less baboon.imv 
gedit pgm2imv_512_512.sh &
gedit baboon.imv &
gedit pgm2imv_512_512.sh &
./pgm2imv_512_512.sh baboon.pgm 
gedit baboon.imv &
./pgm2imv_512_512.sh baboon.pgm 
cd
gedit .bash_perso
cd
cd ComfyUI/workflows/
ls
gedit 'Wan 2.1 Image to Video 14B 720p.json' &
du
df -H
ls
cd ComfyUI/
ls
less requirements.txt 
vivado &
git clone https://github.com/comfyanonymous/ComfyUI.git
ls
cd ComfyUI/
ls
cd models/
ls
cd checkpoints/
ls
lspci | grep VGA
sudo lshw -C video
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
cd
soucre .bashrc
source .bashrc 
env
env | grep ".local"
cd ComfyUI/
ls
sudo lshw -C video
ls
cd models/
ls
s
ls
s
ls
cd ComfyUI/
mkdir workflows
pip install -r requirements.txt
ls
python main.py
sudo ubuntu-drivers list
sudo ubuntu-drivers install --gpgpu
python main.py 
cat /proc/driver/nvidia/version
lspci | grep nvidia
lspci 
lspci | grep NVIDIA
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121
pip install -r requirements.txt
python main.py 
python
pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu124
ls ~/.local/lib/
ls ~/.local/lib/python3.10/
ls ~/.local/lib/python3.10/site-packages/
apt install linux-headers-$(uname -r)
sudo apt install linux-headers-$(uname -r)
$ wget https://developer.download.nvidia.com/compute/nvidia-driver/$version/local_installers/nvidia-driver-local-repo-$distro-$version_$arch_ext.deb
wget https://developer.download.nvidia.com/compute/nvidia-driver/$version/local_installers/nvidia-driver-local-repo-$distro-$version_$arch_ext.deb
sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
sudo apt update && apt upgrade
sudo apt update
sudo apt upgrade
sudo ubuntu-drivers autoinstall
sudo apt search nvidia-driver
sudo apt reinstall nvidia-driver-570
sudo apt reinstall nvidia-driver-535
sudo reboot
cd ComfyUI/output/
pwd
ls
pwd
exit
ls
cd ComfyUI/
ls
cd output/
ls
ll
sudo adduser hannoun
cd /
ls
cd usr/
ls
cd /
ls
cd home/
ls
cd demelo/
ls
cd Xilinx_2023/
ls
exit
sudo gedit /etc/sudoers 
less /etc/sudoers 
sudo less /etc/sudoers 
su root
cd /home/hannoun/
sudo cd /home/hannoun/
less /etc/sudoers 
sudo less /etc/sudoers 
sudo more /etc/sudoers
cd /etc
ls
cd sudoers.d/
ls
less README 
sudo less README 
cd
sudo adduser zuckerman
#Defaults:%sudo env_keep += "SSH_AGENT_PID SSH_AUTH_SOCK"
# Ditto for GPG agent
#Defaults:%sudo env_keep += "GPG_AGENT_INFO"
# Host alias specification
# User alias specification
# Cmnd alias specification
# User privilege specification
root    ALL=(ALL:ALL) ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
# See sudoers(5) for more information on "@include" dir
usermod -aG sudo hannoun
sudo usermod -aG sudo hannoun
sudo usermod -aG sudo zuckerman
su -demelo
sudo su
sudo ls
compgen -g
sudo adduser hannoun adm
sudo adduser zuckerman adm
ls /media/demelo/toshiba/
ls
cd vivado_prjs/
ls
ls NA
cd testbench_eads/
ls
cd test_grad_imv/
ls
s
ls
cd vhdl/
ls
cd tst/
ls
cd ImageTests/
ls
ll
gedit pgm2imv_512_512.sh &
gimp &
less baboon.pgm 
less baboon.imv 
s
ls
ls divers/
s
ls
s
ls
cd test_grad_imv/
ls
gedit test_grad_imv.xpr &
ls
cd test_grad_imv.sim
ls
cd sim_1/
ls
cd behav/
ls
cd xsim
s
cd xsim
ls
gedit elaborate.log &
vivado &
s
ls
s
ls
cd /media/demelo/toshiba/
ls
cd wizard/
ls
cd archive_arnstadt/
ls
cd buildroot/
ls
cd build_2022_north_aurora/
ls
less README 
cd output/
ls
cd images/
ls
ll
s
lq
ls
cd 2023_buildroot/
ls
s
cd 2023_buildroot/
ll
s
cd buildroot-2022.08.2/
ls
s
ls
ll
cd buildroot
ll
gedit generateBuildroot_fred.sh&
s
ls
cd buildroot/
ls
cd buildroot-2022.08.2/
ll
cd output/
cd images/
ll
ss
s
ls
cd 2023_buildroot/
ls
gedit generateBuildroot.sh &
ll
s
ls
cd build_2022_northwest_aurora
ls
cd output/images/
ll
ss
s
cd build_2022_north_aurora
cd output/images/
ll
ss
ls
s
ls
cd buildroot-2022.08.2
ls
cd output/images/
ll
s
ls
cd build_2022_north_aurora
ls
less build.log 
env
cd
gedit .bash_perso &
vivado &
bg
ping lic-srv.ensea.fr
source .bashrc 
ls Xilinx_2023/
vivado &
source .bashrc 
env
env | grep LICENSE
vivado &
ls
cd vivado_prjs/
ls
cd testbench_eads/
ls
cd test_grad_imv/
ls
s
ls
cd vhdl/
ls
cd tst
ls
cd ImageTests/
ls
gedit cube.imv &
gedit cube.pgm &
gedit baboon.pgm &
gedit imv*.sh &
pwd
ls
gedit baboon_gf_py.imv &
gedit cube_gf_py.imv &
gedit baboon.imv &
ll
ls -lart
ls -lart *.imv
less cube_gf_py.imv
less cube_grad_py.imv 
less cube_grad_py.pgm 
ls
less cube_grad_py.pgm 
./imv2pgm.sh baboon_gf_py.imv
./imv2pgm_256_233.sh baboon_gf_py.imv
gedit baboon_gf_py.pgm &
gimp cube_grad_py.pgm &
gedit cube_grad_py.imv &
ls -lart
gedit /home/demelo/vivado_prjs/testbench_eads/test_grad_imv/test_grad_imv.sim/sim_1/behav/xsim/elaborate.log &
ls
gedit pgm2imv_512_512.sh &
./pgm2imv_512_512.sh baboon.pgm
cp baboon.pgm baboon.imv 
sed -i '1,3d' baboon.imv 
./pgm2imv_512_512.sh baboon.pgm 
ls
less test.sh 
less toto.sh 
ls *.sh
echo "this    is     fo      testing" | tr -s '[:space:]'
echo "this is for testing" | tr -s '[:space:]'
echo "this  is  for  testing" | tr -s '[:space:]'
echo "this  is  for  testing" | tr \\t " " |tr -s '[:space:]'
echo "this  is  for  testing" | tr \\t " " |tr -s [:space:]
echo "this is for testing" | tr \\t " " |tr -s [:space:]
echo "this is for testing" | tr \\t "" |tr -s [:space:]
echo "this is for testing" | tr \\t " " |tr -s [:space:]
man tr
echo "this  is  for  testing" | tr -s '[:blank:]'
man tr
echo "this is for testing" | tr -s '[:blank:]'
tr ' ' ',' <"baboon.pgm" >"baboon.imv"
tr ' ' '' <"baboon.pgm" >"baboon.imv"
tr -d '[:space:]' <"baboon.pgm" >"baboon.imv"
tr ' ' ',' <"baboon.pgm" >"baboon.imv"
tr -s '[:space:]' <"baboon.pgm" >"baboon.imv"
man tr
tr -d '[:space:]' <"baboon.pgm" >"baboon.imv"
tr -s '[:space:]' <"baboon.pgm" >"baboon.imv"
tr -s '[:space:]' <"baboon.imv" >"baboon2.imv"
gedit baboon2.imv &
sed -i -e "s/\ //g" baboon2.imv 
gedit baboon2.imv &
awk '{printf "%02X", substr($0,1,1)}' > baboon2.imv
./pgm2imv_512_512.sh baboon.pgm
gedit pgm2imv_512_512.sh &
./pgm2imv_512_512.sh baboon.pgm
gedit baboon.imv &
./pgm2imv_512_512.sh baboon.pgm

./pgm2imv_512_512.sh baboon.pgm
gedit baboon.imv2 &
./pgm2imv_512_512.sh baboon.pgm
gedit baboon.pgm &
gedit pgm2imv_512_512.sh &
cp baboon.ascii.pgm baboon.pgm
gedit baboon.pgm &
./pgm2imv_512_512.sh baboon.pgm
gedit baboon.imv&
./pgm2imv_512_512.sh baboon.pgm
gedit baboon.imv&
./pgm2imv_512_512.sh baboon.pgm
gedit baboon.imv2 &
./pgm2imv_512_512.sh baboon.pgm
echo "160" | awk '{printf "%02X\n", $1}'
./pgm2imv_512_512.sh baboon.pgm
touch pgm2imv.sh
ll
sudo chmod 777 pgm2imv.sh 
gedit pgm2imv.sh &
./pgm2imv.sh baboon.pgm
less allfer.pgm 
./pgm2imv.sh allfer.pgm 
gedit allfer.imv&
gedit imv2pgm.sh &
ls
./imv2pgm.sh baboon.imv 512 512
./pgm2imv.sh baboon.pgm
./imv2pgm.sh baboon_grad.imv 512 512
gimp baboon_grad.imv &
gedit baboon_grad.pgm &
gimp baboon_grad.pgm &
gedit cube.pgm &
ls
.imv2pgm.sh cube_grad_tarek.imv 256 256
./imv2pgm.sh cube_grad_tarek.imv 256 256
gedit cube.imv &
./imv2pgm.sh cube_grad_tarek.imv 256 256
dmesg
sudo dmesg
ls
./imv2pgm.sh baboon_grad_tarek.imv 512 512
ls
gimp baboon_grad_tarek.pgm &
gimp baboon.pgm &
cd
cd Téléchargements/
ls
less baboon.pgm 
rm -rf baboon.pgm 
less bridge.pgm 
less barbara.pgm 
rm -rf bridge.pgm 
rm -rf barbara.pgm 
less baboon.ascii.pgm 
mv baboon.ascii.pgm ~/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/
ls
cd ComfyUI/
ls
python main.py 
pip install -r requirements.txt
python main.py 
ifconfig
ls
ls /media/demelo/toshiba/wizard/
ls
ls vivado_prjs/
cd vivado_prjs/
ls
cp -r /media/demelo/toshiba/wizard/aurora_axi4_stream .
cd
cp -r /media/demelo/toshiba/wizard/archive_arnstadt .
ls
cd archive_arnstadt/buildroot/
ls
cd build_2022_north_aurora/
ls
s
gedit ./buildroot/generateBuildroot_fred.sh &
echo $DISPLAY
xauth list
sudo gedit ./buildroot/generateBuildroot_fred.sh 
vivado &
cd
less .Xauthority 
less .bash_perso 
less .bashrc
echo $XAUTHORITY
export XAUTHORITY=$HOME/.Xauthority
echo $XAUTHORITY
cd archive_arnstadt/buildroot/
cd buidroot
cd buildroot
ls
gedit generateBuildroot_fred.sh &
xhost
ls -l ~/.Xauthority 
grep -i X11Forwarding /etc/ssh/sshd_config
cd
less /etc/ssh/ssh_config
sudo vi /etc/ssh/ssh_config
exit
ls
gedit upgrade_project_migration_report.log &
exit
ls
gedit upgrade_project_migration_report.log &
exit
ls
cd archive_arnstadt/
ls
cd buildroot/
ls
ls
cd archive_arnstadt/buildroot/
ls
cd buildroot-2022.08.2/
ls
s
ls
cd buildroot
ls
env | grep -i magic
file /home/demelo/Xilinx_2024/sysroots/x86_64-petalinux-linux/usr/bin/python3
pushd .
cd
cd Xilinx_2024/
ls
cd petalinux/
ls
cd 2024.2/
ls
cd sysroots/x86_64-petalinux-linux/
ls
cd usr/bin/
ls
ll -il py*
cd ../
ls
cd ../
ls
cd ..
ls
cd scripts/bash/
ls
gedit petalinux-env-check &
cd ../
ls -a
grep 'x86_64-' *
grep -r 'x86_64-' *
cd ../
cd sysroots/
ls -l
cd x86_64-petalinux-linux/
ll
cd usr/bin/
ll
ll pyth*
rm python
pwd
ln -s python /home/demelo/Xilinx_2024/petalinux/2024.2/sysroots/x86_64-petalinux-linux/usr/bin/python3
ln -s  python3 /home/demelo/Xilinx_2024/petalinux/2024.2/sysroots/x86_64-petalinux-linux/usr/bin/python
ll
ll py*
ls *config
cd ../../
cd ../
ls
cd ../
mv 2024.2 2024.2.bad
mkdir 2024.2
minicom -D /dev/ttyUSB1
sudo minicom -D /dev/ttyUSB1
ls
cd /media/demelo/toshiba/wizard/
ls
gedit wizard_CMDs &
minicom 
minicom -D /dev/ttyUSB0
minicom -D /dev/ttyUSB2
sudo minicom -D /dev/ttyUSB0
ls
gedit minicom.log &
exit
sudo minicom -P /dev/ttyUSB1 
sudo minicom -D /dev/ttyUSB1 
sudo minicom -D /dev/ttyUSB2
minicom -D /dev/ttyUSB0
cd /media/demelo/toshiba/wizard/
ls
gedit wizard_CMDs&
ls
cd
cd Téléchargements/
ls
tar xzf e2fsprogs-1.47.0.tar.gz
cd e2fsprogs-1.47.0
./configure
make
sudo make install
cd
ls /media/demelo/rootfs/mnt/
ls /media/demelo/rootfs/etc
cd /media/demelo/rootfs/
ls
cd etc
ls
less environment 
less fstab 
cd network/
ls
less interfaces 
s
ls
cd ssh/
ls
less sshd_config
cp sshd_config sshd_config.old
sudo cp sshd_config sshd_config.old
ls
s
cd init.d/
ls
s
ls
cd init.d/
ls
s
cd
cd /media/demelo/boot/
ls
sudo gedit boot.scr
sudo cp boot.scr boot.scr.old
sudo gedit boot.scr
bg
gedit uEnv.txt &
cd
ls
cd sd_north_backup/
ls
cd rootfs/
ls
cd sbin/
ls
s
ls
cd rootfs/mnt/
ls
less start 
s
ls
cd bin/
ls
s
ls
cd etc/
ls
ls mmi64/
ls
cd mmi64/
ls
s
ls
ls lighttpd/
ls modules/
ls
ls modules/
ls services 
s
ls
ls client/
ls client/client_qt/
less client/client_qt/main.cpp 
ls
ls dev
cd lib
ls
cd bash/
ls
s
ls
cd modules/
ls
cd 4.6.0-xilinx/
ls
cd kernel/
ls
cd drivers/
ls
ls remoteproc/
ls rpmsg/
ls usb/
ls usb/gadget/
ls usb/gadget/function/
s
ls
s
ls
ls pkgconfig/
s
ls
cd libexec/
ls
s
cd opt/
ls
s
cd proc/
ls
s
cd profpga_update/
ls
s
cd root/
ls
s
cd run/
ls
s
cd sbin/
ls
s
ls
cd sys/
ls
s
cd tmp/
ls
s
cd usr/
ls
cd bin/
ls
s
ls
cd lib
ls
s
ls
cd sbin/
ls
pwd
s
ls
s
cd etc/network/
ls
less interfaces 
cd
ls
cd /media/demelo/
ls
ls boot
ls boot1
ls rootfs/
cd 6c537d69-1842-443b-900d-9c4c40fc65b5/
ls
cd mnt/
touch toto
sudo touch toto
sudo mount | grep /dev/sdc2
cd
sudo umount /dev/sdc2
sudo df
sudo fsck /dev/sdc2
sudo df
sudo mount /dev/sdc2 /media/demelo/rootfs
ls rootfs
ls /media/demelo/rootfs/
sudo umount /dev/sdc2
sudo fsck /dev/sdc2
sudo mount /dev/sdc2 /media/demelo/rootfs
ls /media/demelo/rootfs
ls /media/demelo/rootfs/mnt
ls /media/demelo/rootfs/mnt/
ls /media/demelo/rootfs/
ls /media/demelo/6c537d69-1842-443b-900d-9c4c40fc65b5/
sudo umount /dev/sdc2
ls /dev/sdc*
sudo mount /dev/sdc2 /media/demelo/rootfs/
cd /media/demelo/rootfs/
ls
sudo tar xfv rootfs.tar.gz 
ls
sudo rm rootfs.tar.gz 
cd -
popd
cd /media/demelo/rootfs/
ls
cd etc/
ls
less hostname 
less hosts
less passwd
cd network/
ls
sudo cp interfaces interfaces.old
s
ls
cd ssh
ls
s
ls
cd init.d/
ls
less networking 
s
cd -
cd 
sudo umount /media/demelo/rootfs 
ls /media/demelo/boot/
ls /media/demelo/rootfs/
sudo mount /dev/sdc1 /media/demelo/boot/
sudo umount /media/demelo/boot 
cd /media/demelo/721af0b3-10fc-4c3f-857e-7c4e05a55bf8/
ls
cd etc
ls
sudo gedit shadow group 
cd
cd -
ls
sudo gedit sudoers
sudo gedit group
cd
vivado &
cd /media/demelo/rootfs
ls
s
ls
cd rootfs1/
ls
cd mnt/
ls
s
sudo umount /media/demelo/rootfs1 
ls
ls BOOT/
s
sudo umount /media/demelo/BOOT
ls
cd demelo/
ls
ls rootfs1/mnt/
ls BOOT/
sudo umount /media/demelo/rootfs1 
sudo umount /media/demelo/BOOT
ls BOOT/
ls rootfs1/mnt/
sudo umount /media/demelo/BOOT
sudo umount /media/demelo/rootfs1 
sudo gparted 
sudo mount /dev/sdc1 /media/demelo/boot
sudo mount /dev/sdc2 /media/demelo/rootfs/
cd /media/demelo/boot/
ls
rm -rf *
sudo rm -rf *
s
ls
cd rootfs/
ls
ls mnt
sudo rm -rf *
ls
sudo tar xvf rootfs.tar.gz 
ls
sudo rm -f rootfs.tar.gz 
s
sudo umount /media/demelo/boot 
sudo umount /media/demelo/rootfs 
sudo dmesg
cd /media/demelo/toshiba/wizard/
ls
gedit wizard_IPs &
gedit wizard_MACs&
enable_powersupply_for_devices nr=all  value=0
minicom -D /dev/ttyUSB1 
cd 
cd peta_prjs/
ls
cd peta_wizard/
ls
s
cd peta_prjs/
ls
gedit README &
ls
petalinux-create -n peta_wizard_02 --template zynq
petalinux-create project -n peta_wizard_02 --template zynq
cd peta_wizard_02/
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa 
gedit ../README &
petalinux-config -c kernel
petalinux-config -c u-boot
petalinux-config -c rootfs
petalinux-build
petalinux-package --boot --u-boot
ls
cd images/
ls
cd linux/
ls
sudo umount /media/demelo/d2524e4d-50c0-40a2-92f6-87fa3f3cac3a 
sudo mkfs.ext4 -L root /dev/sdc2
sudo dd if=rootfs.ext4 of=/dev/sdc2
sudo mount /dev/sdc2 /media/demelo/root
ls /media/demelo/6f2f0b77-9f9c-486d-9b34-8de5c46ff7cf/
ls /media/demelo/6f2f0b77-9f9c-486d-9b34-8de5c46ff7cf/etc/init.d/
less /media/demelo/6f2f0b77-9f9c-486d-9b34-8de5c46ff7cf/etc/network/interfaces 
ss
s
ls
petalinux-create project -n peta_wizard_03
cd peta_wizard_03/
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa 
ls
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa
source ~/.bashrc
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa
df
s
rm -rf peta_wizard_03/
petalinux-create project -n peta_wizard_03 --template zynq
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa
cd peta_wizard_03/
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa
petalinux-config -c rootfs
petalinux-config -c kernel
ls
cd components/
ls
cd plnx_workspace/
ls
s
cd yocto/
ls
cd workspace/
l
ls
s
ls
s
ls
s
ls
cd project-spec/
ls
cd hw-description/
ls
s
ls
cd configs/
ls
s
ls
cd meta-user/
ls
s
ls
s
ls
cd build/
ls
cd tmp/
ls
s
ls
cd peta_wizard
ls
cd images/
ls
cd linux/
ls
s
ls
cd components/
ls
cd plnx_workspace/
ls
cd device-tree/
ls
cd device-tree/
ls
ss
s
ls
cd peta_wizard_03/
ls
ls components/
ls components/plnx_workspace/
petalinux-config -c u-boot
cd project-spec/meta-user/
ls
cd recipes-bsp/
ls
cd device-tree/
ls
cd files/
ls
gedit system-user.dtsi &
ss
s
petalinux-build -c device-tree
ls
cd components/
ls
ls plnx_workspace/
cd plnx_workspace/device-tree/
ls
cd device-tree/
ls
ls include/
ls include/dt-bindings/
gedit system-top.dts &
less pcw.dtsi 
gedit pcw.dtsi &
gedit zynq-7000.dtsi &
cp system-top.dts system-top.dts.old
ss
petalinux-build
ss
petalinux-build
sudo umount /media/demelo/6f2f0b77-9f9c-486d-9b34-8de5c46ff7cf 
ls /dev/sd*
sudo mkfs.ext4 /dev/sdc2
ls
petalinux-package --boot --u-boot
ls
cd images/linux/
ls
sudo dd if=./rootfs.ext4 of=/dev/sdc2
ls /dev/sdc*
sudo mount /dev/sdc2 /media/demelo/rootfs
mkdir /media/demelo/rootfs
sudo mkdir /media/demelo/rootfs
sudo mount /dev/sdc2 /media/demelo/rootfs
gparted &
sudo mkfs.ext4 -L rootfs /dev/sdc2
ls
sudo dd if=rootfs.ext4 of=/dev/sdc2
sudo mount /dev/sdc2 /media/demelo/rootfs/
ss
ls
sudo cp interfaces /media/demelo/rootfs/etc/network/
cd images/
ls
cd linux/
ls
sudo dd if=rootfs.ext4 of=/dev/sdc2
sudo mount -L rootfs /media/demelo/
ls /media/demelo/rootfs/
sudo mount /dev/sdc2 /media/demelo/rootfs/
ls /media/demelo/rootfs/
sudo mount /dev/sdc2 /media/demelo/rootfs/
df
sudo umount /media/demelo/rootfs 
sudo dd if=rootfs.ext4 of=/dev/sdc2
sudo mount /dev/sdc2 /media/demelo/rootfs/
df
ls
ll
df
sudo umount /media/demelo/rootfs 
sudo e2fsck -f /dev/sdc2
ls _lh rootfs.ext4 
ls -lh rootfs.ext4 
sudo dmesg | grep sdc
sudo fsck.ext4 /dev/sdc2
sudo e2fsck -f /dev/sdc2
sudo add-apt-repository ppa:costamagnagianfranco/e2fsprogs
sudo apt update
sudo apt install e2fsprogs
sudo e2fsck -f /dev/sdc2
sudo add-apt-repository ppa:costamagnagianfranco/e2fsprogs
sudo apt update
sudo apt install -y build-essential uuid-dev libblkid-dev e2fslibs-dev
wget https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.47.0/e2fsprogs-1.47.0.tar.gz
ls
mv e2fsprogs-1.47.0.tar.gz ~/Téléchargements/
sudo e2fsck -f /dev/sdc2
sudo resize2fs /dev/sdc2
df
df -h | grep sdc2
sudo mount /dev/sdc2 /media/demelo/rootfs/
df -h | grep sdc2
ss
s
petalinux-create project -n peta_wizard_04 --template zynq 
cd peta_wizard_04/
ls
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/north/aurora_tx_streaming_2023/design_1_wrapper.xsa 
ls
ls components/plnx_workspace/
petalinux-config -c kernel
petalinux-config -c u-boot
ls 
ls components/plnx_workspace/
ls components/plnx_workspace/device-tree/
ls components/plnx_workspace/device-tree/device-tree/
ll
ll components/plnx_workspace/device-tree/device-tree/
ls ../peta_wizard_03/components/plnx_workspace/
ls ../peta_wizard_03/components/plnx_workspace/device-tree/device-tree/
cd components/plnx_workspace/device-tree/device-tree/
ls
cp system-top.dts system-top.dts.old
cp ../../../../../peta_wizard_03/components/plnx_workspace/device-tree/device-tree/system-top.dts .
petalinux-config -c u-boot
petalinux-config -c rootfs
petalinux-config -c kernel
ll
less system-top.dts
ss
s
petalinux-build -c device-tree
cd components/plnx_workspace/device-tree/device-tree/
ll
cd include/
ls
cd dt-bindings/
lq
ls
s
petalinux-build
petalinux-package --boot --u-boot
sudo df
sudo unmount /dev/sdc2
sudo umount /dev/sdc2
sudo umount /dev/sdc1
sudo df
sudo fdisk /dev/sdc
sudo df
sudo unmount /dev/sdc2
sudo umount /dev/sdc2
sudo umount /dev/sdc1
mkfs.vfat -F 32 -n boot /dev/sdc1
sudo mkfs.vfat -F 32 -n boot /dev/sdc1
sudo mkfs.ext4 -L root /dev/sdc2
sudo df
cd images/
ls
cd linux/
ls
dd if=rootfs.ext4 of=/dev/sdc2
sudo dd if=rootfs.ext4 of=/dev/sdc2
sudo df
sudo mkdir -p /media/demelo/boot
sudo mount /dev/sdc1 /media/demelo/boot/
sudo df
sudo mount /dev/sdc2 /media/demelo/rootfs
ls
sudo cp BOOT.BIN boot.scr image.ub uImage system.dtb u-boot.bin u-boot.elf /media/demelo/boot/
ls
sudo cp rootfs.tar.gz /media/demelo/rootfs/
ls
gedit boot.scr &
cd pxelinux.cfg/
ls
less default 
LS
ls
s
ls
sudo cp BOOT.BIN boot.scr uImage system.dtb /media/demelo/boot/
s
ls
cd project-spec/
ls
cd configs/
ls
less config
less rootfs_config
ls
cd configs
ls
s
ls
cd rootfsconfigs/
ls
less user-rootfsconfig 
ss
s
ls
gedit README &
petalinux-create project -n peta_wizard_nw --template zynq
cd peta_wizard_nw/
ls
ls project-spec/
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/northwest/aurora_rx_streaming_2023/design_1_wrapper.xsa 
ls
ls components/plnx_workspace/
ls
ls components/plnx_workspace/
ls components
ls
cd project-spec/
ls
s
petalinux-config -c kernel
ls
ls project-spec/
ls project-spec/configs/
cd project-spec/configs/
ll
s
cd components/
ls
cd plnx_workspace/
ls
s
ls
s
ls
cd project-spec/
ls
cd configs/
ls
gedit config &
tkdiff config ~/peta_prjs/peta_wizard_04/project-spec/configs/config &
ss
ls
petalinux-config -c kernel
petalinux-config --get-hw-description ~/vivado_prjs/aurora_axi4_stream/northwest/aurora_rx_streaming_2023/design_1_wrapper.xsa 
cd project-spec/configs/
tkdiff config ~/peta_prjs/peta_wizard_04/project-spec/configs/config &
s
ls
ls components/
ls components/plnx_workspace/
petalinux-config -c kernel
ls
cd project-spec/
ll
cd configs/
ls
ll
cd configs/
ll
s
cd components/
cd plnx_workspace/
ls
ss
ls
petalinux-config -c u-boot
gedit /home/demelo/peta_prjs/peta_wizard_nw/project-spec/meta-user/recipes-bsp/u-boot/files/user_2025-05-28-12-55-00.cfg&
ls
cd project-spec/
ls
cd configs/
ll
cd configs/
ll
s
ls
cd systemd-conf/
ll
s
ls
ll
s
ls
cd hw-description/
ll
s
ls
cd meta-user/
ls
ls conf
cd conf/
ls
ll
less user-rootfsconfig 
less petalinuxbsp.conf 
s
ls
s
ls
s
ls
cd components/
ls
cd plnx_workspace/
ls
cd device-tree/
ls
cd device-tree/
ls
ll
cp system-top.dts system-top.dts.old
ss
ls
s
ls
cd yocto/
ls
cd conf/
ls
ll
s
ls
s
ls
cd build/
ls
ll
ls -a
s
ls
cd project-spec/configs/
ls
ll
ss
petalinux-config -c rootfs
cd project-spec/configs/
ll
less config
s
petalinux-config -c rootfs
ls
cd project-spec/
ll
cd configs/
ll
cd rootfsconfigs/
ll
gedit Kconfig &
ls
gedit user-rootfsconfig &
s
cd build/
ls
less config.log
ls
cd cache/
ls
s
ls
cd tmp/
ls
s
ls
cd conf/
ls
ll
less bblayers.conf 
less plnxtool.conf 
ss
petalinux-config -c rootfs
petalinux-build
gedit /home/demelo/peta_prjs/peta_wizard_nw/build/tmp/work/zynq_generic_7z045-xilinx-linux-gnueabi/petalinux-image-minimal/1.0/temp/log.do_rootfs.3667874 &
petalinux-config -c rootfs
petalinux-build
petalinux-package --boot --u-boot
ls
cd images/
ls
cd linux/
ls
sudo cp rootfs.tar.gz /media/demelo/rootfs/
sudo cp BOOT.BIN boot.scr system.dtb uImage /media/demelo/boot/
ls
cd sd_northwest_backup/
ls
cd rootfs/
ls
cd /mnt
ls
cd
cd sd_northwest_backup/rootfs/mnt/
ls
sudo cp * /media/demelo/rootfs1/mnt/
sudo cp -r aurora_dma/ /media/demelo/rootfs1/mnt/
cd /media/
ls
cd
ls
cd /media/demelo/
ls
cd /media/demelo/toshiba/
ls
cd wizard/
ls
gedit wizard_CMDs &
ls
cd aurora_axi4_stream
ls
cd northwest/
ls
cd aurora_rx_streaming
ls
cd aurora_rx.runs/
ls
cd impl_1/
ls
ll *.bit
cp *.bit ~/peta_prjs/peta_wizard_nw/images/bitstreams/
sudo minicom -D /dev/ttyUSB1
./petalinux-v2024.2-11062026-installer.run
exit
./petalinux-v2024.2-11062026-installer.run
ls
cd
ls
mkdir SDK_temp
pwd
cd SDK_temp/
pwd
ls
cd
ls
cd SDK_temp/
ls
ls -ld components/yocto/arm 
ls -ld components/yocto/aarch64 
cd components/yocto/
./arm
cd
cd Xilinx_2024/petalinux/2024.2/
ls
cd components/
ls
cd yocto/
ls
./arm
cd
cd petalinux_arm_sdk_2024/
ls
s
ls
find ~/Xilinx_2024/petalinux/2024.2/ -name "bitbake" -type f 2>/dev/null
find ~/SDK_temp -name "bitbake" -type f 2>/dev/null
cd
cd Xilinx_2024/petalinux/2024.2/
ls
cd components/yocto/
ls
./aarch64 
ls
s
ls
cd xsct/
ls
cd scripts/
ls
s
ls
cd yocto/
ls
s
ls
s
ls
cd scripts/
ls
cd bash/
ls
./petalinux-env-check 
s
ls
lsb_release -a
sudo apt update
udo apt install -y build-essential libncurses5-dev libncursesw5-dev zlib1g:i386 zlib1g-dev:i386 libstdc++6:i386
sudo apt install -y build-essential libncurses5-dev libncursesw5-dev zlib1g:i386 zlib1g-dev:i386 libstdc++6:i386
sudo cp /etc/os-release /etc/os-release.bak
sudo gedit /etc/os-release
s
ls
cp -r 2024.2 2024.2.bof
rm -rf 2024.2
mkdir 2024.2
pwd
cd 
ls
./petalinux-v2024.2-11062026-installer.run
sudo gedit /etc/os-release
ls /etc/os-release*
less /etc/os-release.bak 
sudo rm -f /etc/os-release
sudo mv /etc/os-release.bak /etc/os-release
./petalinux-v2024.2-11062026-installer.run
lsb_release -a
hostnamectl
sudo apt purge build-essential libncurses5-dev libncursesw5-dev zlib1g:i386 zlib1g-dev:i386 libstdc++6:i386
sudo apt autoremove
sudo apt clean
ls
./petalinux-v2024.2-11062026-installer.run
sudo apt update
sudo apt install build-essential libncurses5-dev libncursesw5-dev
./petalinux-v2024.2-11062026-installer.run
./petalinux-v2024.2-11062026-installer.run > install.log
./petalinux-v2024.2-11062026-installer.run > output.log 2> error.log
cat error.log
./petalinux-v2024.2-11062026-installer.run
script -t 2> timing.txt session_capture.txt
cat session_capture.txt | grep -A 10 "ERROR"
gedit session_capture.txt &
file --version
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install apt-transport-https
sudo apt update
sudo apt install code # ou code-insiders
code
ifconfig
ping 10.10.4.121
ll
ls -ltrh | grep "$(date +%Y-%m-%d)"
find . -maxdepth 1 -ctime 0
ls
cd
cd peta_prjs/
ls
ll
cd northwest_aurora/
ls
cd project-spec/configs/
ls
less config
gedit config &
ls
cd configs/
ls
s
ls
s
ls
s
ls
cd components/
ls
cd plnx_workspace/
ls
s
ls
cd yocto/
ls
cd conf/
ls
s
cd workspace/
ls
cd conf/
ls
s
ls
s
ls
cd build/
ls
cd conf/
ls
s
ls
cd tmp/
ls
cd work
ls
s
cd work-shared/
ls
s
ls
cd project-spec/
ls
cd meta-user/
ls
cd conf/
ls
s
cd recipes-bsp/
ls
cd u-boot/
ls
cd files/
ls
less user_2025-11-20-12-09-00.cfg 
less bsp.cfg 
s
ls
cd configs/
ls
gedit rootfs_config &
ls
s
ls
cd meta-user/
ls
cd recipes-bsp/
ls
cd u-boot/
ls
cd files/
ls
gedit bsp.cfg &
gedit user_2025-11-20-12-09-00.cfg &
s
cd recipes-kernel/linux/linux-xlnx/
ls
gedit bsp.cfg &
gedit user_2025-11-20-11-51-00.cfg &
ss
ls
cd configs/
ls
gedit config &
cd
ls
cd /media/demelo/toshiba/wizard/
ls
gedit wizard_MACs &
cd
sudo dmesg
ll /dev/sd*
sudo mkdir -p /media/demelo/fame
sudo mount -r /dev/sdc1 /media/demelo/fame/
sudo wipefs -n /dev/sdc1
sudo apt install testdisk
sudo testdisk /dev/sdc
ls /dev/sd*
sudo mount /dev/sdc1 /media/demelo/fame
ls /media/demelo/fame/
sudo dmesg
ll /dev/sd*
ls /media/demelo/
ls /media/demelo/fame/
sudo mount /dev/sdc /media/demelo/fame
lsblk
ls /media/demelo/BOOT1/
sudo umount /dev/sdc*
sudo fdisk /dev/sdc
sudo hdparm -r0 /dev/sdc
sudo fdisk /dev/sdc
lsblk
sudo wipefs -a /dev/sdc
sudo umount /dev/sdc*
sudo wipefs -a /dev/sdc
lsblk
sudo dmesg
ls /media/demelo/BOOT
ls /media/demelo/rootfs
lsblk
ls /media/demelo/BOOT1/
mkdir BAckup_MicroSDProdesign
sudo cp -r /media/demelo/BOOT1/ BAckup_MicroSDProdesign/
sudo cp -r /media/demelo/rootfs1/ BAckup_MicroSDProdesign/
sudo umount /dev/sdc*
lsblk
sudo wipefs -a /dev/sdc
sudo fdisk /dev/sdc
sudo mkfs.vfat -F 32 -s 64 -n "FAME" /dev/sdc1
cd
cd vivado_prjs/aurora_axi4_stream/northwest/aurora_rx_streaming_2023/
ls
gedit aurora_rx.xpr &
gedit mon_bd_config.tcl &
s
ls
s
ls
s
ls
gedit test_script.xpr &
gedit zynq_prodesign.tcl &
ls
ll
find . -maxdepth 1 -mindepth 1 -newermt "2025-12-09" ! -newermt "2025-12-10"
find . -maxdepth 1 -mindepth 1 -newermt "2025-12-09" -exec rm -rf {} +
ll
vivado &
ls
cd
ls
cd peta_prjs/
ls
s
cd test_auto_petalinux/
ls
gedit wizard_petalinux.sh &
./wizard_petalinux.sh 
ls
rm -rf test_vivado/
./wizard_petalinux.sh 
ls
rm -rf test_vivado/
ls
./wizard_petalinux.sh 
ls
rm -rf test_vivado/
ls
./wizard_petalinux.sh 
ls
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizard_petalinux.sh 
less automation_log.txt 
ls
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizard_petalinux.sh 
ls
cd test_vivado/test.srcs/
ls
cd sources_1/
ls
cd bd/
ls
s
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizard_petalinux.sh 
rm -rf test_vivado/
./wizardtop
lsblk -o NAME,SIZE,VENDOR,MODEL,SERIAL
ls
cd /media/demelo/toshiba/
ls
cd wizard/
ls
cd
cd Téléchargements/
ll
mv 5.2.10.tiff bridge.tiff
gimp bridge.tiff &
cd
ls
cd vivado_prjs/testbench_eads/test_grad_imv/
ls
ll
cd test_grad_imv.sim/
ls
cd sim_1/
ls
cd behav/
ls
ss
cd test_grad_imv/
ls
cd test_grad_imv.srcs/
ls
cd sources_1/
ls
ls imports/
ls imports/work/
s
ls
s
ls
cd pyramid_prj/
ls
cd pyramid.srcs/
ls
cd sources_1/
ls
cd imports/
ls
cd work/
ls
s
ls
cd test_grad_imv/
ls
s
ls
cd vhdl/
ls
s
pwd
git add .
git init
git add .
git commit -m "Premier envoi"
git config --global user.email "fredericdemelo@gmail.com"
git config --global user.name "Goetmals"
git commit -m "Premier envoi"
git branch -M main
git remote add origin https://github.com/Goetmals/Pyramid_debug.git
git push -u origin main
ps -ef
top
kill 5473
top
ss
s
git init
git add .
git commit -m "Premier envoi"
git branch -M main
git remote add origin https://github.com/Goetmals/Pyramid_debug.git
git remote set-url origin https://github.com/Goetmals/Pyramid_debug.git
git push -u origin main
cd test_grad_imv/
ls
less test_grad_imv.xpr
s
ls
cd vhdl/
ls
cd tst/
ls
cd ImageTests/
ls
sudo apt-get install snapd snapd-xdg-open
sudo apt update && sudo apt install git-cola gitg -y
ss
s
ls
cd test_grad_imv/
ls
git-cola &
sudo apt install tk -y
sudo apt install git-gui python3-tk -y
git-cola &
git push
git commit -m "modification pour afficher DOG"
git push
sudo adduser cody
sudo groupadd stage_cody
sudo usermod -aG stage_cody demelo
sudo usermod -aG stage_cody cody
gnome-control-center 
gnome-control-center display
cd
cd vivado_prjs/
ll
exit
cd 
cd vivado_prjs/
ll
exit
