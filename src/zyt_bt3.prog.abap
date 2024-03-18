*&---------------------------------------------------------------------*
*& Report  ZYT_BT3
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_bt3.

*INCLUDE zyt_bt3_sdt.

TYPE-POOLS : slis.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      ls_layout   TYPE slis_layout_alv.

TABLES: zyt_per_infos,
        zyt_per_tours.


DATA: gt_fae_infos TYPE TABLE OF zyt_per_infos,
      gt_fae_tours TYPE TABLE OF zyt_per_tours.

TYPES: BEGIN OF gty_tables,
         islem_id   TYPE  z_dt_islid,
         kisi_id    TYPE  z_dt_id,
         kalem_id   TYPE  z_dt_kal,
         saat       TYPE  z_dt_ysaat,
         gid_yer    TYPE  z_dt_gyer,
         rate       TYPE  /cem/rate,
         isim       TYPE  z_dt_isim,
         soyad      TYPE  z_dt_sad,
         yas        TYPE  z_dt_yas,
         line_color TYPE char4,
         cell_color TYPE slis_t_specialcol_alv,
       END OF gty_tables.

DATA: gs_cell_color TYPE slis_specialcol_alv.

DATA: gt_tables TYPE gty_tables OCCURS 0 WITH HEADER LINE,
      gs_tables TYPE gty_tables.


START-OF-SELECTION.

  SELECTION-SCREEN BEGIN OF BLOCK blockid1 WITH FRAME TITLE text-001.
  SELECT-OPTIONS: so_kid  FOR  gt_tables-kisi_id.
  PARAMETERS:     p_sehir TYPE z_dt_gyer.
  SELECTION-SCREEN END OF BLOCK blockid1.

  SELECTION-SCREEN BEGIN OF BLOCK blockid2 WITH FRAME TITLE text-002.
  PARAMETERS: p_tumk RADIOBUTTON GROUP rad1,
              p_kt   RADIOBUTTON GROUP rad1,
              p_kst  RADIOBUTTON GROUP rad1,
              p_ksk  RADIOBUTTON GROUP rad1,
              p_sdt  RADIOBUTTON GROUP rad1.
  SELECTION-SCREEN END OF BLOCK blockid2.

  SELECTION-SCREEN BEGIN OF BLOCK blockid3 WITH FRAME TITLE text-003.
  PARAMETERS: p_satrr RADIOBUTTON GROUP rad2,
              p_hucrr RADIOBUTTON GROUP rad2.
  SELECTION-SCREEN END OF BLOCK blockid3.

START-OF-SELECTION.

****************************************************************DENEME ALANI!!!!!!!!!!


****************************************************************


  IF p_tumk = 'X'.

    PERFORM get_all_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM call_merge.

    PERFORM call_alv_grid.

  ELSEIF p_kt = 'X'.

    PERFORM get_all_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_kt.

    PERFORM call_alv_grid.

  ELSEIF p_kst = 'X'.

    PERFORM get_all_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_kst.

    PERFORM call_alv_grid.

  ELSEIF p_ksk = 'X'.

    PERFORM get_all_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_ksk.

    PERFORM call_alv_grid.

  ELSEIF p_sdt = 'X'.

    INCLUDE zyt_bt3_sdt.


  ENDIF.

END-OF-SELECTION.


******-----------------------------------FORMS---------------------------

FORM call_merge.

  REFRESH: gt_fieldcat.
  CLEAR: gs_fieldcat.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_TUR_KISI_STRUC'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

ENDFORM.

FORM call_alv_grid.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
    TABLES
      t_outtab                 = gt_tables[] "gt_fae_tours[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.


FORM set_layout.

  ls_layout-zebra    = abap_true.
  ls_layout-colwidth_optimize = abap_true.
  ls_layout-info_fieldname    = 'LINE_COLOR'.
  ls_layout-coltab_fieldname  = 'CELL_COLOR'.

ENDFORM.

***Line renklendirme alanı.
FORM set_line_color.
  LOOP AT gt_tables INTO gs_tables.
    gs_tables-line_color = 'C500'.
    IF gs_tables-rate > '150'.
      gs_tables-line_color = 'C310'.
    ENDIF.
    IF gs_tables-rate > '300'.
      gs_tables-line_color = 'C610'.
    ENDIF.
    MODIFY gt_tables FROM gs_tables.
  ENDLOOP.
ENDFORM.

***Cell renklendirme alanı ( RATE ).
FORM set_cell_color.
  LOOP AT gt_tables INTO gs_tables.
    IF gs_tables-rate > 200.
      CLEAR: gs_cell_color.
      gs_cell_color-fieldname  = 'RATE'.
      gs_cell_color-color-col  = 7.
      gs_cell_color-color-int  = 1.
      gs_cell_color-color-inv  = 0.
      APPEND gs_cell_color TO gs_tables-cell_color.
    ENDIF.
    MODIFY gt_tables FROM gs_tables.
  ENDLOOP.
ENDFORM.


FORM: pf_status_set USING extab TYPE slis_t_extab.

  SET PF-STATUS 'STANDARD'.

ENDFORM.

FORM user_command USING p_ucomm    TYPE sy-ucomm
                        p_selfield TYPE slis_selfield.
  IF p_sdt = abap_true.
    CASE p_ucomm.
      WHEN '&SUMM'.

        DATA: ref1 TYPE REF TO cl_gui_alv_grid.
** alvde seçilen checkboxları internal tabloya yansıtır "checkbox
        CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
          IMPORTING
            e_grid = ref1.
        CALL METHOD ref1->check_changed_data.

        LOOP AT gt_sdt_collect WHERE check = 'X'.

          DATA: gv_msgsehr(100) TYPE c,
                gv_sehrtop      TYPE /cem/rate,
                gv_text(100)    TYPE c.
          gv_msgsehr = gt_sdt_collect-gid_yer.
          gv_sehrtop = gt_sdt_collect-ilk_s + gt_sdt_collect-iki_s + gt_sdt_collect-uc_s + gt_sdt_collect-dort_s + gt_sdt_collect-bes_s + gt_sdt_collect-alti_s + gt_sdt_collect-yedi_s.

          CALL FUNCTION 'POPUP_TO_INFORM'
            EXPORTING
              titel = 'TUR BİLGİSİ'
              txt1  = gv_msgsehr
              txt2  = gv_sehrtop
            .
        ENDLOOP.
    ENDCASE.
  ENDIF.

ENDFORM.

FORM get_all_data.

*  SELECT *
*    FROM zyt_per_tours
*    INTO TABLE gt_fae_tours
*    FOR ALL ENTRIES IN gt_fae_infos
*    WHERE kisi_id EQ gt_fae_infos-kisi_id
*    AND zyt_per_tours~kisi_id IN so_kid.
*
  SELECT *
    FROM     zyt_per_tours   AS a
    INNER JOIN zyt_per_infos AS b ON a~kisi_id = b~kisi_id
    INTO CORRESPONDING FIELDS OF TABLE gt_tables
    WHERE a~kisi_id IN so_kid.

* LOOP AT gt_tables into gs_tables.
*   case gs_tables-saat.
*     when '1'.
*       gs_tables-saat = 'yüksek performans'.
*       append gs_tables to gt_tables.
*endcase.
* ENDLOOP.
************************************************************************************

ENDFORM.

***************************************************************************************FIELDCAT-AREA-BEGIN*************

FORM prepare_fieldcat_alv_kt. "KİŞİ - TUTAR


  DATA: ls_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE.

* Get field names of structure or internal table used in fieldcatalog
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_TUR_KISI_STRUC'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.


* Set field properties
  LOOP AT gt_fieldcat INTO ls_fieldcat .
    CASE ls_fieldcat-fieldname .
      WHEN 'KISI_ID'.
        ls_fieldcat-seltext_l    = 'ID'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 1.
      WHEN 'ISIM'.
        ls_fieldcat-seltext_l    = 'AD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 2.
      WHEN 'SOYAD'.
        ls_fieldcat-seltext_l    = 'SOYAD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 3.
      WHEN 'RATE'.
        ls_fieldcat-seltext_l    = 'ÜCRET'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 4.
      WHEN OTHERS.
        ls_fieldcat-no_out       = 'X'.
    ENDCASE.
    CLEAR ls_fieldcat-key.
    ls_fieldcat-seltext_m    = ls_fieldcat-seltext_l.
    ls_fieldcat-seltext_s    = ls_fieldcat-seltext_l.
    ls_fieldcat-reptext_ddic = ls_fieldcat-seltext_l.
    MODIFY gt_fieldcat FROM ls_fieldcat .
  ENDLOOP.



ENDFORM.

FORM prepare_fieldcat_alv_kst.  "KİŞİ - ŞEHİR - TUTAR
*
*  REFRESH: gt_fieldcat.
*  CLEAR: gs_fieldcat.

  DATA: ls_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE.

* Get field names of structure or internal table used in fieldcatalog
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_TUR_KISI_STRUC'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

* Set field properties
  LOOP AT gt_fieldcat INTO ls_fieldcat .
    CASE ls_fieldcat-fieldname .
      WHEN 'KISI_ID'.
        ls_fieldcat-seltext_l    = 'ID'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 1.
      WHEN 'ISIM'.
        ls_fieldcat-seltext_l    = 'AD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 2.
      WHEN 'SOYAD'.
        ls_fieldcat-seltext_l    = 'SOYAD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 3.
      WHEN 'GID_YER'.
        ls_fieldcat-seltext_l    = 'GİDECEĞİ YER'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 4.
      WHEN 'RATE'.
        ls_fieldcat-seltext_l    = 'ÜCRET'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 5.
      WHEN OTHERS.
        ls_fieldcat-no_out       = 'X'.
    ENDCASE.
    CLEAR ls_fieldcat-key.
    ls_fieldcat-seltext_m    = ls_fieldcat-seltext_l.
    ls_fieldcat-seltext_s    = ls_fieldcat-seltext_l.
    ls_fieldcat-reptext_ddic = ls_fieldcat-seltext_l.
    MODIFY gt_fieldcat FROM ls_fieldcat .
  ENDLOOP.



ENDFORM.   " prepare_fieldcat_alv

FORM prepare_fieldcat_alv_ksk.   "KİŞİ - ŞEHİR - KALEM

*  REFRESH: gt_fieldcat.
*  CLEAR: gs_fieldcat.

  DATA: ls_fieldcat TYPE slis_t_fieldcat_alv WITH HEADER LINE.

* Get field names of structure or internal table used in fieldcatalog
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = sy-cprog
      i_structure_name       = 'ZYT_TUR_KISI_STRUC'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.


* Set field properties
  LOOP AT gt_fieldcat INTO ls_fieldcat .
    CASE ls_fieldcat-fieldname .
      WHEN 'KISI_ID'.
        ls_fieldcat-seltext_l    = 'ID'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 1.
      WHEN 'ISIM'.
        ls_fieldcat-seltext_l    = 'AD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 2.
      WHEN 'SOYAD'.
        ls_fieldcat-seltext_l    = 'SOYAD'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 3.
      WHEN 'GID_YER'.
        ls_fieldcat-seltext_l    = 'GİDECEĞİ YER'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 4.
      WHEN 'KALEM_ID'.
        ls_fieldcat-seltext_l    = 'KALEM'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 5.
      WHEN OTHERS.
        ls_fieldcat-no_out       = 'X'.
    ENDCASE.
    CLEAR ls_fieldcat-key.
    ls_fieldcat-seltext_m    = ls_fieldcat-seltext_l.
    ls_fieldcat-seltext_s    = ls_fieldcat-seltext_l.
    ls_fieldcat-reptext_ddic = ls_fieldcat-seltext_l.
    MODIFY gt_fieldcat FROM ls_fieldcat .
  ENDLOOP.

ENDFORM.   " prepare_fieldcat_alv


***************************************************************************************FIELDCAT-AREA-END*************
