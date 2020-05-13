; docformat = 'rst'

function atomneb_list_aeff_sh95_references, Atom_RC_file, atom, ion
;+
;     This function returns a list for all references of recombination coefficients (Aeff)
;     for given element and ionic level from the FITS data file ('rc_SH95.fits').
;
; :Returns:
;    type=an array of strings. This function returns the references.
;
; :Params:
;     Atom_RC_file  : in, required, type=string
;                     the FITS data file name ('rc_SH95.fits')
;     atom          : in, required, type=string
;                     atom name e.g. 'h'
;     ion           : in, required, type=string
;                     ionic level e.g 'ii'
;
; :Examples:
;    For example::
;
;     IDL> base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     IDL> data_dir = ['atomic-data-rc']
;     IDL> Atom_RC_file= filepath('rc_SH95.fits', root_dir=base_dir, subdir=data_dir )
;     IDL> atom='h'
;     IDL> ion='ii' ; H I
;     IDL> list_hi_aeff_reference=atomneb_list_aeff_sh95_references(Atom_RC_file, atom, ion)
;     IDL> print,list_hi_aeff_reference
;
;
; :Categories:
;   Recombination Lines
;
; :Dirs:
;  ./
;      Main routines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.0.1
;
; :History:
;     15/01/2017, IDL code by A. Danehkar
;-

;+
; NAME:
;     atomneb_list_aeff_sh95_references
;
; PURPOSE:
;     This function returns a list for all references of recombination coefficients (Aeff)
;     for given element and ionic level from the FITS data file ('rc_SH95.fits').
;
; CALLING SEQUENCE:
;     reference_list=atomneb_list_aeff_sh95_references(Atom_RC_file, atom, ion)
;
; INPUTS:
;     Atom_RC_file  : in, required, type=string, the FITS data file name ('rc_SH95.fits')
;     Atom          : in, required, type=string, atom name e.g. 'h'
;     Ion           : in, required, type=string, ionic level e.g 'ii'
;
; OUTPUTS:  This function returns an array of strings as the references.
;
; PROCEDURE: This function calls ftab_ext from IDL Astronomy User's library (../externals/astron/pro).
;
; EXAMPLE:
;     base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     data_dir = ['atomic-data-rc']
;     Atom_RC_file= filepath('rc_SH95.fits', root_dir=base_dir, subdir=data_dir )
;     atom='h'
;     ion='ii' ; H I
;     list_hi_aeff_reference=atomneb_list_aeff_sh95_references(Atom_RC_file, atom, ion)
;     print,list_hi_aeff_reference
;     >
;
; MODIFICATION HISTORY:
;     15/01/2017, IDL code by A. Danehkar
;-
  element_data_list=atomneb_read_aeff_sh95_list(Atom_RC_file)
  atom_ion_name=strlowcase(atom)+'_'+strlowcase(ion)+'_aeff*'
  ii=where(strmatch(element_data_list.Aeff_Data, atom_ion_name));
  temp=size(ii,/DIMENSIONS)
  ii_length=temp[0]
  if ii_length eq 1 then begin
    if ii eq -1 then begin
      print, 'could not find the given element or ion'
      exit
    endif
  endif
  Select_Aeff_Data=element_data_list[ii].Aeff_Data
  ;temp=size(Select_Omij_Data,/DIMENSIONS)
  NLINES1=ii_length;temp[0]
  References = STRARR(NLINES1)
  for i=0, NLINES1-1 do begin 
    Select_Aeff_Data_str1=strsplit(Select_Aeff_Data[i],'_', /EXTRACT)
    temp=size(Select_Aeff_Data_str1,/DIMENSIONS)
    ref_num=temp[0]
    if ref_num gt 4 then References[i] = Select_Aeff_Data_str1[3] else References[i] =''
  endfor
  return, References
end