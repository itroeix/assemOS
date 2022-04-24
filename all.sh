./delete.sh
./build.sh
mkisofs -quiet -V 'assemOS' -input-charset iso8859-1 -o assemOS.iso -b assemOS.flp ./ 
qemu-system-x86_64 -cdrom assemOS.iso
