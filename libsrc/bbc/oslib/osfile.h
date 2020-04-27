#ifndef osfile_H
#define osfile_H

/* C header file for OSFile
 * written by DefMod (May  4 2004) on Tue May  4 13:25:17 2004
 * Jonathan Coxhead, jonathan@doves.demon.co.uk, 21 Aug 1995
 */

/*OSLib---efficient, type-safe, transparent, extensible,
   register-safe A P I coverage of RISC O S*/
/*Copyright  1994 Jonathan Coxhead*/

/* cc65 Version Dominic Beesley 2005 */

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
#include <oslib/types.h>
#endif

#ifndef os_H
#include <oslib/os.h>
#endif

#ifndef fileswitch_H
#include <oslib/fileswitch.h>
#endif

#if defined NAMESPACE_OSLIB
  namespace OSLib {
#endif


/************************
 * Constant definitions *
 ************************/
#define osfile_NOT_FOUND                        ((fileswitch_object_type) 0x0u)
#define osfile_IS_FILE                          ((fileswitch_object_type) 0x1u)
#define osfile_IS_DIR                           ((fileswitch_object_type) 0x2u)
#define osfile_IS_IMAGE                         ((fileswitch_object_type) 0x3u)

#define osfile_FILE_TYPE_SHIFT                  8


/*************************
 * Function declarations *
 *************************/

#ifdef __cplusplus
   extern "C" {
#endif

/* ------------------------------------------------------------------------
 * Function:      osfile_write()
 *
 * Description:   Calls OS_File 1 to write the load and execution addresses
 *                and attributes for an object
 *
 * Input:         file_name - value of R1 on entry
 *                load_addr - value of R2 on entry
 *                exec_addr - value of R3 on entry
 *                attr - value of R5 on entry
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x1.
 */

extern os_error *xosfile_write (char const *file_name,
      bits32 load_addr,
      bits32 exec_addr,
      fileswitch_attr attr);
extern void osfile_write (char const *file_name,
      bits32 load_addr,
      bits32 exec_addr,
      fileswitch_attr attr);

/* ------------------------------------------------------------------------
 * Function:      osfile_write_load()
 *
 * Description:   Calls OS_File 2 to write the load address for an object
 *
 * Input:         file_name - value of R1 on entry
 *                load_addr - value of R2 on entry
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x2.
 */

extern os_error *xosfile_write_load (char const *file_name,
      bits32 load_addr);
extern void osfile_write_load (char const *file_name,
      bits32 load_addr);

/* ------------------------------------------------------------------------
 * Function:      osfile_write_exec()
 *
 * Description:   Calls OS_File 3 to write the execution address for an
 *                object
 *
 * Input:         file_name - value of R1 on entry
 *                exec_addr - value of R3 on entry
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x3.
 */

extern os_error *xosfile_write_exec (char const *file_name,
      bits32 exec_addr);
extern void osfile_write_exec (char const *file_name,
      bits32 exec_addr);

/* ------------------------------------------------------------------------
 * Function:      osfile_write_attr()
 *
 * Description:   Calls OS_File 4 to write the attributes for an object
 *
 * Input:         file_name - value of R1 on entry
 *                attr - value of R5 on entry
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x4.
 */

extern os_error *xosfile_write_attr (char const *file_name,
      fileswitch_attr attr);
extern void osfile_write_attr (char const *file_name,
      fileswitch_attr attr);

/* ------------------------------------------------------------------------
 * Function:      osfile_delete()
 *
 * Description:   Calls OS_File 6 to delete an object
 *
 * Input:         file_name - value of R1 on entry
 *
 * Output:        obj_type - value of R0 on exit (X version only)
 *                load_addr - value of R2 on exit
 *                exec_addr - value of R3 on exit
 *                size - value of R4 on exit
 *                attr - value of R5 on exit
 *
 * Returns:       R0 (non-X version only)
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x6.
 */

extern os_error *xosfile_delete (char const *file_name,
      fileswitch_object_type *obj_type,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);
extern fileswitch_object_type osfile_delete (char const *file_name,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);

/* ------------------------------------------------------------------------
 * Function:      osfile_load()
 *
 * Description:   Calls OS_File 255 to load a file 
 *
 * Input:         file_name - value of R1 on entry
 *                addr - value of R2 on entry
 *
 * Output:        obj_type - value of R0 on exit (X version only)
 *                load_addr - value of R2 on exit
 *                exec_addr - value of R3 on exit
 *                size - value of R4 on exit
 *                attr - value of R5 on exit
 *
 * Returns:       R0 (non-X version only)
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0xFF, R3 = 0x0.
 */

//TODO: change to fastcall!
//TODO: doesn't set return valueS?!

extern os_error * __cdecl__ xosfile_load (char const *file_name,
      byte *addr,
      fileswitch_object_type *obj_type,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);
extern fileswitch_object_type __cdecl__ osfile_load (char const *file_name,
      byte *addr,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);


/* ------------------------------------------------------------------------
 * Function:      osfile_save()
 *
 * Description:   Calls OS_File 0 to save a block of memory as an untyped
 *                file - prefer OSFile_SaveStamped
 *
 * Input:         file_name - value of R1 on entry
 *                load_addr - value of R2 on entry
 *                exec_addr - value of R3 on entry
 *                data - value of R4 on entry
 *                end - value of R5 on entry
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x0.
 */

extern os_error *xosfile_save (char const *file_name,
      bits32 load_addr,
      bits32 exec_addr,
      byte const *data,
      byte const *end);
extern void osfile_save (char const *file_name,
      bits32 load_addr,
      bits32 exec_addr,
      byte const *data,
      byte const *end);

/* ------------------------------------------------------------------------
 * Function:      osfile_read()
 *
 * Description:   Calls OS_File 5 to read catalogue information for an
 *                object using the directory list in File$Path - prefer
 *                OSFile_ReadStamped
 *
 * Input:         file_name - value of R1 on entry
 *
 * Output:        obj_type - value of R0 on exit (X version only)
 *                load_addr - value of R2 on exit
 *                exec_addr - value of R3 on exit
 *                size - value of R4 on exit
 *                attr - value of R5 on exit
 *
 * Returns:       R0 (non-X version only)
 *
 * Other notes:   Calls SWI 0x8 with R0 = 0x5.
 */

extern os_error *xosfile_read (char const *file_name,
      fileswitch_object_type *obj_type,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);
extern fileswitch_object_type osfile_read (char const *file_name,
      bits32 *load_addr,
      bits32 *exec_addr,
      long *size,
      fileswitch_attr *attr);


#ifdef __cplusplus
   }
#endif

#if defined NAMESPACE_OSLIB
  } 
#endif

#endif
