#
# cc65 makefile for the bbc specific modules
#

.SUFFIXES: .o .s .c

#--------------------------------------------------------------------------
# Programs and flags

SYS	= c128

AS	= ../../src/ca65/ca65
CC	= ../../src/cc65/cc65
LD	= ../../src/ld65/ld65

AFLAGS	= -t $(SYS) --forget-inc-paths -I../../asminc
CFLAGS	= -Osir -g -T -t $(SYS) --forget-inc-paths -I . -I ../../include

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

C_OBJS =	open.o	\
		lseek.o		\
		systime.o	\
		opendir.o	\
		readdir.o	\
		closedir.o

S_OBJS  =       crt0.o          \
                ctype.o		\
		write.o         \
		rwcommon.o	\
		close.o		\
		clock.o		\
		clrscr.o	\
		cputc.o		\
		gotox.o		\
		gotoxy.o	\
		gotoy.o		\
		wherex.o	\
		wherey.o	\
		read.o		\
		cgetc.o		\
		mainargs.o	\
		sysuname.o	\
		_scrsize.o	\
		cclear.o	\
		chline.o	\
		color.o		\
		revers.o	\
		cvline.o	\
		lseek_extra.o	\
		fdtable.o	\
		fd_getfree.o	\
		preservezp.o	\
		errors.o	\
		brkret.o	\
		printhex.o	\
		printstr.o	\
		print0.o	\
		readdir.o	\
		kbhit.o		\
		disable_cursor_edit.o	\
		init_stack.o	\
		brkvec.o
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

all:   	$(OBJS) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)

../runtime/zeropage.o:
	$(MAKE) -C $(dir $@) $(notdir $@)


clean:
	@$(RM) $(OBJS) $(EMDS:.emd=.o) $(JOYS:.joy=.o) $(MOUS:.mou=.o) $(SERS:.ser=.o) $(TGIS:.tgi=.o)
	@for i in clib oslib rom; do\
       	   $(MAKE) -C $$i clean;			      		   	\
	done

zap:	clean
	@for i in clib oslib rom; do\
	   $(MAKE) -C $$i zap;     	    	       	      	   		\
	done
	@$(RM) $(EMDS) $(JOYS) $(MOUS) $(SERS) $(TGIS)
	
	

