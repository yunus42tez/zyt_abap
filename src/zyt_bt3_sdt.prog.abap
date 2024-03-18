*&---------------------------------------------------------------------*
*&  Include           ZYT_BT3_SDT
*&---------------------------------------------------------------------*

 TYPES: BEGIN OF gty_sdttur_type,
          gid_yer TYPE  z_dt_gyer,
          rate    TYPE  /cem/rate,
        END OF gty_sdttur_type.

 DATA: gt_sdttur TYPE TABLE OF gty_sdttur_type,
       gs_sdttur TYPE gty_sdttur_type.


 TYPES: BEGIN OF gty_sdt_type,
          check(1)       TYPE c,
          gid_yer        TYPE z_dt_gyer,
          ilk_s          TYPE /cem/rate,
          iki_s          TYPE /cem/rate,
          uc_s           TYPE /cem/rate,
          dort_s         TYPE /cem/rate,
          bes_s          TYPE /cem/rate,
          alti_s         TYPE /cem/rate,
          yedi_s         TYPE /cem/rate,
          line_color_sdt TYPE char4,
*          cell_color_sdt TYPE slis_t_specialcol_alv,
        END OF gty_sdt_type.

* DATA: gs_cell_color_sdt TYPE slis_specialcol_alv.

 DATA: gt_sdt         TYPE TABLE OF gty_sdt_type,
       gs_sdt         TYPE gty_sdt_type,
       gt_sdt_collect TYPE gty_sdt_type OCCURS 0 WITH HEADER LINE,
       gs_sdt_collect TYPE gty_sdt_type.

 DATA: gv_null TYPE /cem/rate.
 gv_null = 0.
***************************ADANA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '1'
    AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null  dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '2'
    AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null  dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '3'
    AND gid_yer = 'ADANA'.
***************************ADANA
 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '4'
    AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '5'
   AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '6'
   AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************ADANA
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '7'
   AND gid_yer = 'ADANA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
 ENDLOOP.
***************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '1'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
***************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '2'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '3'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '4'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '5'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '6'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************BURSA
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '7'
    AND gid_yer = 'BURSA'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '1'
    AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '2'
    AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '3'
   AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '4'
   AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '5'
   AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '6'
   AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************İSTANBUL
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '7'
   AND gid_yer = 'İSTANBUL'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
    FROM zyt_per_tours
    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
  WHERE saat = '1'
    AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '2'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '3'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '4'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '5'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '6'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT
 SELECT *
   FROM zyt_per_tours
   INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
 WHERE saat = '7'
   AND gid_yer = 'YOZGAT'.

 CLEAR: gs_sdttur.
 LOOP AT gt_sdttur INTO gs_sdttur.
   APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
 ENDLOOP.
****************************YOZGAT


 LOOP AT gt_sdt INTO gs_sdt.
   gs_sdt_collect = gs_sdt.
   COLLECT gs_sdt_collect INTO gt_sdt_collect.
 ENDLOOP.

 ls_layout-zebra             = abap_true.
 ls_layout-colwidth_optimize = abap_true.
 ls_layout-info_fieldname    = 'LINE_COLOR_SDT'.
* ls_layout-coltab_fieldname  = 'CELL_COLOR'.

**Line renklendirme alanı.
 LOOP AT gt_sdt_collect INTO gs_sdt_collect.
   gs_sdt_collect-line_color_sdt = 'C310'.
   IF gs_sdt_collect-ilk_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-iki_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-uc_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-dort_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-bes_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-alti_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   IF gs_sdt_collect-yedi_s > '700'.
     gs_sdt_collect-line_color_sdt = 'C610'.
   ENDIF.
   MODIFY gt_sdt_collect FROM gs_sdt_collect.
 ENDLOOP.

***Cell renklendirme alanı.
* LOOP AT gt_sdt_collect INTO gs_sdt_collect.
*   if gs_sdt_collect-yedi_s > 500.
*   CLEAR: gs_cell_color.
*   gs_cell_color-fieldname  = '16:00-18:00'.
*   gs_cell_color-color-col  = 7.
*   gs_cell_color-color-int  = 1.
*   gs_cell_color-color-inv  = 0.
*   APPEND gs_cell_color to gs_sdt_collect-cell_color.
*   ENDIF.
*   MODIFY gt_sdt_collect FROM gs_sdt_collect.
* ENDLOOP.

* cl_demo_output=>write_data( gt_sdt ).
* cl_demo_output=>write_data( gt_sdt_collect ).
* cl_demo_output=>display( ).


 REFRESH: gt_fieldcat.
 CLEAR: gs_fieldcat.

 CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
   EXPORTING
     i_program_name         = sy-cprog
     i_structure_name       = 'ZYT_SDT_STRUCTURE'
   CHANGING
     ct_fieldcat            = gt_fieldcat
   EXCEPTIONS
     inconsistent_interface = 1
     program_error          = 2
     OTHERS                 = 3.


 DATA: ls_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE.
* Set field properties
 LOOP AT gt_fieldcat INTO ls_fieldcat .
   CASE ls_fieldcat-fieldname .
      WHEN 'CHECK'.
        ls_fieldcat-seltext_l    = 'Print'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 1.
        ls_fieldcat-input        = 'X'.     "checkbox
        ls_fieldcat-edit         = 'X'.     "checkbox
        ls_fieldcat-checkbox     = 'X'.     "checkbox
        ls_fieldcat-key          = ' '.
     WHEN 'GID_YER'.
       ls_fieldcat-seltext_l    = 'Gideceği Yer'.
       ls_fieldcat-outputlen    = 4.
       ls_fieldcat-col_pos      = 1.
     WHEN 'ILK_S'.
       ls_fieldcat-seltext_l    = '09:00-11:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 2.
     WHEN 'IKI_S'.
       ls_fieldcat-seltext_l    = '11:00-12:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 3.
     WHEN 'UC_S'.
       ls_fieldcat-seltext_l    = '12:00-13:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 4.
     WHEN 'DORT_S'.
       ls_fieldcat-seltext_l    = '13:00-14:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 5.
     WHEN 'BES_S'.
       ls_fieldcat-seltext_l    = '14:00-15:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 6.
     WHEN 'ALTI_S'.
       ls_fieldcat-seltext_l    = '15:00-16:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 7.
     WHEN 'YEDI_S'.
       ls_fieldcat-seltext_l    = '16:00-18:00'.
       ls_fieldcat-outputlen    = 20.
       ls_fieldcat-col_pos      = 8.

     WHEN OTHERS.
       ls_fieldcat-no_out       = 'X'.
   ENDCASE.
   CLEAR ls_fieldcat-key.
   ls_fieldcat-seltext_m    = ls_fieldcat-seltext_l.
   ls_fieldcat-seltext_s    = ls_fieldcat-seltext_l.
   ls_fieldcat-reptext_ddic = ls_fieldcat-seltext_l.
   MODIFY gt_fieldcat FROM ls_fieldcat .
 ENDLOOP.

 CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
     i_callback_program       = sy-repid
     i_callback_pf_status_set = 'PF_STATUS_SET'
     i_callback_user_command  = 'USER_COMMAND'
     is_layout                = ls_layout
     it_fieldcat              = gt_fieldcat[]
   TABLES
     t_outtab                 = gt_sdt_collect[]
   EXCEPTIONS
     program_error            = 1
     OTHERS                   = 2.
 IF sy-subrc = 0.
   "do nothing
 ENDIF.
