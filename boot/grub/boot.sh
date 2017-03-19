# Grub2-FileManager
# Copyright (C) 2017  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.
for dev in (*); do
        test -e ${dev};
        if test "$?" = "1"; then
                continue;
        fi;
        regexp --set=device '\((.*)\)' $dev;
        if regexp 'efi' $grub_platform; then
	        if test -f ($device)/efi/microsoft/boot/bootmgfw.efi; then
        	        menuentry "启动位于${device}的 Windows 操作系统 " $device --class wim{
        	                set root=$2
        	                chainloader ($root)/efi/microsoft/boot/bootmgfw.efi;
        	        }
        	fi;
        	if test -f ($device)/efi/boot/bootx64.efi; then
        	        menuentry "加载位于${device}的启动管理器 " $device --class uefi{
        	                set root=$2
        	                chainloader ($root)/efi/boot/bootx64.efi;
        	        }
        	fi;
        	if test -f ($device)/System/Library/CoreServices/boot.efi; then
        	        menuentry "启动位于${device}的 macOS " $device --class macOS{
        	                set root=$2
        	                chainloader ($root)/System/Library/CoreServices/boot.efi;
        	        }
        	fi;
        else
        	menuentry "启动${device}" $device --class img{
        		set root=$2
        		chainloader +1;
        	}
        fi
done;
menuentry "重启计算机" --class reboot{
	reboot;
}
menuentry "关闭计算机" --class halt{
	halt;
}
menuentry "返回" --class go-previous{
	configfile $prefix/main.sh;
}