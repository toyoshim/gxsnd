#!/bin/sh

GCC_PREFIX=arm-none-eabi
SOURCE=gxsnd

${GCC_PREFIX}-gcc -mbig-endian -c ${SOURCE}.S -o ${SOURCE}.o
${GCC_PREFIX}-objcopy -O binary ${SOURCE}.o ${SOURCE}.bin
TOTAL=`${GCC_PREFIX}-size ${SOURCE}.o | tail -n 1 | awk -F ' ' '{ print $1 }'`
START_HEX=`${GCC_PREFIX}-objdump -t ${SOURCE}.o | grep HEAD | awk -F ' ' '{print $1 }'`
START=`printf %d 0x${START_HEX}`
SIZE=`expr ${TOTAL} - ${START}`
SIZE_HEX=`printf %x ${SIZE}`

tail -c ${SIZE} ${SOURCE}.bin > ${SOURCE}.dat

${GCC_PREFIX}-objdump -t ${SOURCE}.o | grep CH_ | awk -F ' ' '{print $5 " $" $1 }'
