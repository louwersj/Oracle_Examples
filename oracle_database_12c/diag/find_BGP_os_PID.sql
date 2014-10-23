/* NAME:
 * find_os_PID.sql
 *
 * DESC:
 * Locate all OS pid's associated with the background processes of the database. 
 * 
 * LOG:
 * VERSION---DATE--------NAME-------------COMMENT
 * 0.1       23OCT2014   Johan Louwers    Initial upload to github.com
 *
 * LICENSE:
 * Copyright (C) 2014  Johan Louwers
 * 
 * This code is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This code is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this code; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 * 
 */


SELECT b.paddr,
  b.PSERIAL#,
  b.NAME,
  b.ERROR,
  b.DESCRIPTION,
  b.CON_ID,
  p.SPID
FROM V$BGPROCESS b,
  V$PROCESS p
WHERE 
     b.PADDR = p.ADDR
