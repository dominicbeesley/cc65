#ifndef fileswitch_H
#define fileswitch_H

/* C header file for FileSwitch
 * written by DefMod (May  4 2004) on Tue May  4 13:25:17 2004
 * Jonathan Coxhead, jonathan@doves.demon.co.uk, 21 Aug 1995
 */

/* cc65 version Dominic Beesley 2005 */

/*OSLib---efficient, type-safe, transparent, extensible,
   register-safe A P I coverage of RISC O S*/
/*Copyright  1994 Jonathan Coxhead*/

/*
      OSLib is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 1, or (at your option)
   any later version.

      OSLib is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

      You should have received a copy of the GNU General Public License
   along with this programme; if not, write to the Free Software
   Foundation, Inc, 675 Mass Ave, Cambridge, MA 02139, U S A.
*/

#ifndef types_H
#include "oslib/types.h"
#endif

#ifndef os_H
#include "oslib/os.h"
#endif

#if defined NAMESPACE_OSLIB
  namespace OSLib {
#endif

/********************
 * Type definitions *
 ********************/
typedef byte fileswitch_fs_no;

typedef bits32 fileswitch_attr;

typedef byte fileswitch_object_type;


#define fileswitch_FS_NUMBER_NONE               ((fileswitch_fs_no) 0x0u)
#define fileswitch_FS_NUMBER_ROMFS              ((fileswitch_fs_no) 0x3u)
#define fileswitch_FS_NUMBER_NETFS              ((fileswitch_fs_no) 0x5u)
#define fileswitch_FS_NUMBER_ADFS               ((fileswitch_fs_no) 0x8u)
#define fileswitch_FS_NUMBER_NETPRINT           ((fileswitch_fs_no) 0xCu)
#define fileswitch_FS_NUMBER_NULL               ((fileswitch_fs_no) 0xDu)
#define fileswitch_FS_NUMBER_PRINTER            ((fileswitch_fs_no) 0xEu)
#define fileswitch_FS_NUMBER_SERIAL             ((fileswitch_fs_no) 0xFu)
#define fileswitch_FS_NUMBER_VDU                ((fileswitch_fs_no) 0x11u)
#define fileswitch_FS_NUMBER_RAWVDU             ((fileswitch_fs_no) 0x12u)
#define fileswitch_FS_NUMBER_KBD                ((fileswitch_fs_no) 0x13u)
#define fileswitch_FS_NUMBER_RAWKBD             ((fileswitch_fs_no) 0x14u)
#define fileswitch_FS_NUMBER_DESKFS             ((fileswitch_fs_no) 0x15u)
#define fileswitch_FS_NUMBER_RAMFS              ((fileswitch_fs_no) 0x17u)
#define fileswitch_FS_NUMBER_RISCIXFS           ((fileswitch_fs_no) 0x18u)
#define fileswitch_FS_NUMBER_STREAMER           ((fileswitch_fs_no) 0x19u)
#define fileswitch_FS_NUMBER_SCSIFS             ((fileswitch_fs_no) 0x1Au)
#define fileswitch_FS_NUMBER_DIGITISER          ((fileswitch_fs_no) 0x1Bu)
#define fileswitch_FS_NUMBER_SCANNER            ((fileswitch_fs_no) 0x1Cu)
#define fileswitch_FS_NUMBER_MULTIFS            ((fileswitch_fs_no) 0x1Du)
#define fileswitch_FS_NUMBER_NFS                ((fileswitch_fs_no) 0x21u)
#define fileswitch_FS_NUMBER_CDFS               ((fileswitch_fs_no) 0x25u)
#define fileswitch_FS_NUMBER_DOSFS              ((fileswitch_fs_no) 0x2Bu)
#define fileswitch_FS_NUMBER_RESOURCEFS         ((fileswitch_fs_no) 0x2Eu)
#define fileswitch_FS_NUMBER_PIPEFS             ((fileswitch_fs_no) 0x2Fu)
#define fileswitch_FS_NUMBER_DEVICEFS           ((fileswitch_fs_no) 0x35u)
#define fileswitch_FS_NUMBER_PARALLEL           ((fileswitch_fs_no) 0x36u)
#define fileswitch_FS_NUMBER_SPARKFS            ((fileswitch_fs_no) 0x42u)
#define fileswitch_FS_NUMBER_PCCARDFS           ((fileswitch_fs_no) 0x59u)
#define fileswitch_FS_NUMBER_MEMFS              ((fileswitch_fs_no) 0x5Bu)
#define fileswitch_FS_NUMBER_SHAREFS            ((fileswitch_fs_no) 0x63u)
#define fileswitch_FS_NUMBER_LANMAN             ((fileswitch_fs_no) 0x66u)
#define fileswitch_FS_NUMBER_OMNIPRINT          ((fileswitch_fs_no) 0x68u)
#define fileswitch_FS_NUMBER_RSDFS              ((fileswitch_fs_no) 0x6Cu)
#define fileswitch_FS_NUMBER                    ((fileswitch_fs_info) 0xFFu)

#define fileswitch_NOT_FOUND                    ((fileswitch_object_type) 0x0u)
#define fileswitch_IS_FILE                      ((fileswitch_object_type) 0x1u)
#define fileswitch_IS_DIR                       ((fileswitch_object_type) 0x2u)
#define fileswitch_IS_IMAGE                     ((fileswitch_object_type) 0x3u)

#define fileswitch_ATTR_OWNER_READ              ((fileswitch_attr) 0x1u)
#define fileswitch_ATTR_OWNER_WRITE             ((fileswitch_attr) 0x2u)
#define fileswitch_ATTR_OWNER_SPECIAL           ((fileswitch_attr) 0x4u)
#define fileswitch_ATTR_OWNER_LOCKED            ((fileswitch_attr) 0x8u)
#define fileswitch_ATTR_WORLD_READ              ((fileswitch_attr) 0x10u)
#define fileswitch_ATTR_WORLD_WRITE             ((fileswitch_attr) 0x20u)
#define fileswitch_ATTR_WORLD_SPECIAL           ((fileswitch_attr) 0x40u)
#define fileswitch_ATTR_WORLD_LOCKED            ((fileswitch_attr) 0x80u)


/*************************
 * Function declarations *
 *************************/

#ifdef __cplusplus
   extern "C" {
#endif

/* ------------------------------------------------------------------------
 * Function:      os_bget()
 *
 * Description:   Reads a byte from an open file - prefer OS_BGetW
 *
 * Input:         file - value of R1 on entry
 *
 * Output:        c - value of R0 on exit
 *                psr - processor status register on exit (X version only)
 *
 * Returns:       psr (non-X version only)
 *
 * Other notes:   Calls SWI 0xA.
 */

extern os_error *xos_bget (os_f file,
      char *c,
      bits *psr);
extern bits os_bget (os_f file,
      char *c);


/* ------------------------------------------------------------------------
 * Function:      os_bput()
 *
 * Description:   Writes a byte to an open file Prefer OS_BPutW
 *
 * Input:         c - value of R0 on entry
 *                file - value of R1 on entry
 *
 * Other notes:   Calls SWI 0xB.
 */

extern os_error *xos_bput (char c,
      os_f file);
extern void os_bput (char c,
      os_f file);


#ifdef __cplusplus
   }
#endif

#if defined NAMESPACE_OSLIB
  } 
#endif



#endif
