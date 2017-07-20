#
# makefile for CC65 runtime library
#

.SUFFIXES: .o .s .c

#--------------------------------------------------------------------------
# Programs and flags

SYS	= bbc

AS	= ../../../src/ca65/ca65
CC	= ../../../src/cc65/cc65
LD	= ../../../src/ld65/ld65
RHG=../rhg/bbcrhg65

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

OBJS =  clib.o \
		vectors.o \
		main.o \
		_heap.o \
		clibtest.o
ROMS =  clib.rom
TESTPROGS = test testnoclib
TESTDISCS = test.ssd

#--------------------------------------------------------------------------
# Drivers

EMDS = 

JOYS = 

MOUS = 

SERS = 

TGIS = 

#--------------------------------------------------------------------------
# Targets

.PHONY:	all clean zap

all::	$(TESTDISCS) $(TESTPROGS) $(ROMS) $(OBJS) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)

../runtime/zeropage.o:
	$(MAKE) -C $(dir $@) $(notdir $@)

clib.rom clib.map clib.lab : $(C_OBJS) $(S_OBJS) clib_rom.cfg
	@$(LD) $(LDFLAGS) -Ln clib.lab -C clib_rom.cfg -vm -m clib.map -o clib.rom -v $(C_OBJS) $(S_OBJS) ../../bbc.lib


clean:
	@$(RM) clib-stubs.s clib.s clib.h clib.inc $(OBJS) $(EMDS:.emd=.o) $(JOYS:.joy=.o) $(MOUS:.mou=.o) $(SERS:.ser=.o) $(TGIS:.tgi=.o)


zap:	clean
	@$(RM) $(TESTDISCS) $(TESTPROGS) $(ROMS) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)

vectors.s stubs.s: functions.lst makevecs
	./makevecs functions.lst vectors.s stubs.s 

clib-stubs.s: clib.lab
	./make-labels

clib.s clib.h clib.inc:	clib.rhg ../rhg/bbcrhg65
	$(RHG) clib.rhg
	
test: clibtest.o clib-stubs.o crt0.o
	@$(LD) $(LDFLAGS) -o test -C bbc.cfg -vm -m test.map crt0.o clib-stubs.o clibtest.o ../../bbc.lib

testnoclib: clibtest.o
	@$(LD) $(LDFLAGS) -o testnoclib -C bbc.cfg ../../bbc.o clibtest.o ../../bbc.lib

install: clib.rom crt0.o clib-stubs.o
	cp clib.rom /var/lib/beebem/romimg/clib
	cp clib.rom /usr/lib/cc65/lib/bbc-clib.rom
	cp crt0.o /usr/lib/cc65/lib/bbc-clib.o
	cp clib-stubs.o /usr/lib/cc65/lib/bbc-clib-stubs.o
	cp clib.rom /usr/local/share/beebem/roms

test.ssd: test testnoclib
	dfs form -80 test.ssd
	dfs add -l 1900 -e 1900 test.ssd test
	dfs add -l 1900 -e 1900 test.ssd testnoclib
	dfs add -l 8000 -e 8000 -f r.clib test.ssd clib.rom
	