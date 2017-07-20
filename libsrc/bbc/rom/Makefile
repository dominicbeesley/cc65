#
# makefile for CC65 runtime library
#

.SUFFIXES: .o .s .c

#--------------------------------------------------------------------------
# Programs and flags

SYS	= bbc

RHG=../rhg/bbcrhg65
AS	= ../../../src/ca65/ca65
CC	= ../../../src/cc65/cc65
LD	= ../../../src/ld65/ld65

AFLAGS	= -t $(SYS) --forget-inc-paths -I../../../asminc
CFLAGS	= -Osir -g -T -t $(SYS) --forget-inc-paths -I . -I ../../../include

#--------------------------------------------------------------------------
# Rules

%.o:   	%.c
	@$(CC) $(CFLAGS) $<
	@$(AS) -o $@ $(AFLAGS) $(*).s

%.o:	%.s
	@$(AS) -g -o $@ $(AFLAGS) $<

%.emd:	%.o ../runtime/zeropage.o
	@$(LD) -t module -o $@ $^

%.joy:	%.o ../runtime/zeropage.o
	@$(LD) -t module -o $@ $^

%.mou:	%.o ../runtime/zeropage.o
	@$(LD) -t module -o $@ $^

%.ser:	%.o ../runtime/zeropage.o
	@$(LD) -t module -o $@ $^

%.tgi:	%.o ../runtime/zeropage.o
	@$(LD) -t module -o $@ $^

#--------------------------------------------------------------------------
# Object files

OBJS=	enterlang.o \
		main.o \
		clib.o \
		bits.o

#--------------------------------------------------------------------------
# Drivers

EMDS = 

JOYS = 

MOUS = 

SERS = 

TGIS = 

ROMS = clib.rom

#--------------------------------------------------------------------------
# Targets

.PHONY:	all clean zap

all:	$(ROMS) $(OBJS) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)

../runtime/zeropage.o:
	$(MAKE) -C $(dir $@) $(notdir $@)


clib.rom: $(C_OBJS) $(S_OBJS)
	@$(LD) $(LDFLAGS) -C bbc_rom.cfg -m clib.map -o clib.rom -v $(C_OBJS) $(S_OBJS) ../../bbc.lib

clean:
	@$(RM) $(OBJS) $(EMDS:.emd=.o) $(JOYS:.joy=.o) $(MOUS:.mou=.o) $(SERS:.ser=.o) $(TGIS:.tgi=.o)


zap:	clean
	@$(RM) $(ROMS) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)

clib.s clib.h clib.inc:	clib.rhg
	$(RHG) clib.rhg

