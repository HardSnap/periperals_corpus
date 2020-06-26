#set builddir [lindex $argv 0]

#set top top

#set rundir ${builddir}/$top.runs/$run

#file mkdir $rundir/top.sdk

#file copy -force $rundir/top_wrapper.sysdef $rundir/top.sdk/top_wrapper.hdf

setws ./build/top.sdk/

createhw -name hw1 -hwspec ./build/top.sdk/top_wrapper.hdf

cd ./build/top.sdk
#openhw ./top_wrapper.hdf
#set bsp [hsi::create_sw_design bsp -proc ps7_cortexa9_0 -os standalone]
#hsi::add_library xilffs
#generate_bsp -sw $bsp -dir ../bsp -compile

createbsp -name bsp1 -hwproject hw1 -proc ps7_cortexa9_0 -os standalone

setlib -bsp bsp1 -lib xilffs
updatemss -mss bsp1/system.mss
regenbsp -bsp bsp1

createapp -name app -hwproject hw1 -bsp bsp1 -proc ps7_cortexa9_0 -os standalone -lang C -app {Hello World}

createapp -name fsbl -hwproject hw1 -bsp bsp1 -proc ps7_cortexa9_0 -os standalone -lang C -app {Zynq FSBL}

#projects –build
sdk projects -build

exec bootgen -arch zynq -image ../../fpga_scripts/app.bif -w -o BOOT.bin

exec program_flash -f ./BOOT.bin -fsbl ./fsbl/Debug/fsbl.elf -flash_type qspi-x1-single -blank_check -verify -cable type xilinx_tcf url TCP:nasm-Inspiron-7537:3121

