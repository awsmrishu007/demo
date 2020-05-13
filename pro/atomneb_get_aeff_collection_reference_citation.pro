; docformat = 'rst'

function atomneb_get_aeff_collection_reference_citation, Atom_RC_file, atom, ion, br=br, reference=reference
;+
;     This function returns the reference citation for a recombination coefficient (Aeff)
;     from the 2nd binary table extension of the FITS data file ('rc_collection.fits').
;
; :Returns:
;    type=string. This function returns the Citation.
;
; :Params:
;     Atom_RC_file  : in, required, type=string
;                     the FITS data file name ('rc_collection.fits')
;     atom          : in, required, type=string
;                     atom name e.g. 'c'
;     ion           : in, required, type=string
;                     ionic level e.g 'iii'
;
; :Keywords:
;     br            : in, type=boolean
;                     set for the branching ratios (Br), may not necessary
;     reference     : in, type=string
;                     set for the reference, not necessary
;
; :Examples:
;    For example::
;
;     IDL> base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     IDL> data_rc_dir = ['atomic-data-rc']
;     IDL> Atom_RC_file= filepath('rc_collection.fits', root_dir=base_dir, subdir=data_rc_dir )
;     IDL> atom='c'
;     IDL> ion='iii' ; C III
;     IDL> citation=atomneb_get_aeff_collection_reference_citation(Atom_RC_file, atom, ion)
;     IDL> print, citation
;        Davey, A. R., Storey, P. J. and Kisielius, R., Astron.Astrophys.Suppl., 142, 85, 2000
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
;     atomneb_get_aeff_collection_reference_citation
;     
; PURPOSE:
;     This function returns the reference citation for a recombination coefficient (Aeff)
;     from the 2nd binary table extension of the FITS data file ('rc_collection.fits').
;
; CALLING SEQUENCE:
;     citation=atomneb_get_aeff_collection_reference_citation(Atom_RC_file, atom, ion, br=br, reference=reference)
; 
; INPUTS:
;     Atom_RC_file  : in, required, type=string, the FITS data file name ('rc_collection.fits')
;     Atom          : in, required, type=string, atom name e.g. 'c'
;     Ion           : in, required, type=string, ionic level e.g 'iii'
;     
; KEYWORD PARAMETERS:
;     BR            : in, type=boolean, set for the branching ratios (Br), may not necessary
;     REFERENCE     : in, type=string, set for the reference, not necessary
;     
; OUTPUTS:  This function returns a string as the Citation.
; 
; PROCEDURE: This function calls atomneb_read_aeff_collection_references and 
;            ftab_ext from IDL Astronomy User's library (../externals/astron/pro).
; 
; EXAMPLE:
;     base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     data_rc_dir = ['atomic-data-rc']
;     Atom_RC_file= filepath('rc_collection.fits', root_dir=base_dir, subdir=data_rc_dir )
;     atom='c'
;     ion='iii' ; C III
;     citation=atomneb_get_aeff_collection_reference_citation(Atom_RC_file, atom, ion)
;     print, citation
;     > Davey, A. R., Storey, P. J. and Kisielius, R., Astron.Astrophys.Suppl., 142, 85, 2000
;
; MODIFICATION HISTORY:
;     15/01/2017, IDL code by A. Danehkar
;-  
  reference_template={Reference:'', Citation: ''}
  
  element_data_reference=atomneb_read_aeff_collection_references(Atom_RC_file)
  if keyword_set(br) eq 1 then prefix='_br' else prefix='_aeff'
  if keyword_set(reference) eq 1 then begin
    atom_ion_name=strlowcase(atom)+'_'+strlowcase(ion)+prefix+'_'+strupcase(reference)
  endif else begin
    atom_ion_name=strlowcase(atom)+'_'+strlowcase(ion)+prefix
  endelse
  
  ii=where(element_data_reference.Reference eq atom_ion_name);
  if ii eq -1 then begin
    print, 'could not find the given reference'
    exit
  endif
  Citation=element_data_reference[ii].Citation
  
  return, Citation
end