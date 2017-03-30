function atomneb_search_aeff_he_i_pfsd12, Atom_RC_file, atom, ion
;+
; NAME:
;     atomneb_search_aeff_he_i_pfsd12
; PURPOSE:
;     Search effective recombination coefficients (Aeff) for given element
;     and ionic levels
; EXPLANATION:
;
; CALLING SEQUENCE:
;     atom='he'
;     ion='ii'
;     list_hei_aeff_data=atomneb_search_aeff_he_i_pfsd12(Atom_RC_file, atom, ion)
;     print,list_hei_aeff_data
;
; INPUTS:
;     fits_file - the MGFIT line data (./rec_he_ii_PFSD12.fits)
;     atom - atom name e.g. 'he'
;     ion - ionic level e.g 'ii'
; RETURN:  Aeff_Data: Array of Strings
;
; REQUIRED EXTERNAL LIBRARY:
;     ftab_ext from IDL Astronomy User's library (../externals/astron/pro)
;
; REVISION HISTORY:
;     IDL code by A. Danehkar, 15/01/2017
;- 
  element_data_list=atomneb_read_aeff_he_i_pfsd12_list(Atom_RC_file)
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
  
  return, Select_Aeff_Data
end