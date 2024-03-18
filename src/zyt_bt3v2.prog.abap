*&---------------------------------------------------------------------*
*& Report  ZYT_BT3V2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_bt3v2.

TYPE-POOLS : slis.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      ls_layout   TYPE slis_layout_alv.

TABLES: zyt_per_infosv2,
        zyt_per_toursv2.


TYPES: BEGIN OF gty_tables,
         kisi_id    TYPE  z_dt_id,
         kalem_id   TYPE  z_dt_kal,
         saat       TYPE  z_dt_ysaat,
         gid_yer    TYPE  z_dt_gyer,
         rate       TYPE  /cem/rate,
         isim       TYPE  z_dt_isim,
         soyad      TYPE  z_dt_sad,
         yas        TYPE  z_dt_yas,
         k_adet     TYPE  int4,
         line_color TYPE  char4,
         cell_color TYPE slis_t_specialcol_alv,
       END OF gty_tables.

DATA: gs_cell_color TYPE slis_specialcol_alv.

DATA: gt_tables         TYPE gty_tables OCCURS 0 WITH HEADER LINE,
      gs_tables         TYPE gty_tables,
      gt_tables_collect TYPE gty_tables OCCURS 0 WITH HEADER LINE,
      gs_tables_collect TYPE gty_tables.

DATA: gt_tour      TYPE zyt_per_toursv2 OCCURS 0 WITH HEADER LINE,
      gs_tour      TYPE zyt_per_toursv2,
      gt_tour_copy TYPE zyt_per_toursv2 OCCURS 0 WITH HEADER LINE,
      gs_tour_copy TYPE zyt_per_toursv2.

DATA: gt_tour_tto      TYPE TABLE OF zyt_per_toursv2.

DATA: gt_info TYPE zyt_per_infosv2 OCCURS 0 WITH HEADER LINE,
      gs_info TYPE zyt_per_infosv2.

DATA: gt_tables_struc_r TYPE TABLE OF zyt_tables_struc,
      gs_tables_struc_r TYPE zyt_tables_struc.


*&---------------------------------------------------------------------*
*&  Include           lot's of types
*&---------------------------------------------------------------------*

TYPES: BEGIN OF gty_sdttur_type,
         gid_yer TYPE  z_dt_gyer,
         saat    TYPE  z_dt_ysaat,
         rate    TYPE  /cem/rate,
       END OF gty_sdttur_type.

DATA: gt_sdttur      TYPE TABLE OF gty_sdttur_type,
      gs_sdttur      TYPE gty_sdttur_type,
      gt_sdttur_copy TYPE TABLE OF gty_sdttur_type,
      gs_sdttur_copy TYPE  gty_sdttur_type.

TYPES: BEGIN OF gty_st_type, """ şehir - tutar
         gid_yer TYPE  z_dt_gyer,
         rate    TYPE  /cem/rate,
       END OF gty_st_type.
DATA: gt_st_collect TYPE gty_st_type OCCURS 0 WITH HEADER LINE,
      gs_st_collect TYPE gty_st_type.

TYPES: BEGIN OF gty_kst_type, """ kişi - şehir - tutar
         kisi_id TYPE  z_dt_id,
         isim    TYPE  z_dt_isim,
         soyad   TYPE  z_dt_sad,
         gid_yer TYPE  z_dt_gyer,
         rate    TYPE  /cem/rate,
       END OF gty_kst_type.
DATA: gt_kst_collect TYPE gty_kst_type OCCURS 0 WITH HEADER LINE,
      gs_kst_collect TYPE gty_kst_type.

TYPES: BEGIN OF gty_kt_type, """ kişi - tutar
         kisi_id TYPE  z_dt_id,
         isim    TYPE  z_dt_isim,
         soyad   TYPE  z_dt_sad,
         rate    TYPE  /cem/rate,
       END OF gty_kt_type.
DATA: gt_kt_collect TYPE gty_kt_type OCCURS 0 WITH HEADER LINE,
      gs_kt_collect TYPE gty_kt_type.

TYPES: BEGIN OF gty_ksk_type, """ kişi - şehir - kalem
         kisi_id TYPE  z_dt_id,
         isim    TYPE  z_dt_isim,
         soyad   TYPE  z_dt_sad,
         gid_yer TYPE  z_dt_gyer,
         rate    TYPE  /cem/rate,
         k_adet  TYPE  int4,
       END OF gty_ksk_type.
DATA: gt_ksk_collect TYPE gty_ksk_type OCCURS 0 WITH HEADER LINE,
      gs_ksk_collect TYPE gty_ksk_type.

TYPES: BEGIN OF gty_sdt_type, """ şehir - dilim - tutar
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
*        cell_color_sdt TYPE slis_t_specialcol_alv,
       END OF gty_sdt_type.

DATA: gs_cell_color_sdt TYPE slis_specialcol_alv.

DATA: gt_sdt         TYPE gty_sdt_type OCCURS 0 WITH HEADER LINE,
      gs_sdt         TYPE gty_sdt_type,
      gt_sdt_collect TYPE gty_sdt_type OCCURS 0 WITH HEADER LINE,
      gs_sdt_collect TYPE gty_sdt_type.

DATA: gv_count TYPE i.
DATA: gv_null TYPE /cem/rate.
gv_null = 0.

START-OF-SELECTION.

  LOOP AT gt_tables INTO gs_tables.
    SELECTION-SCREEN BEGIN OF BLOCK blockid1 WITH FRAME TITLE text-001.
    SELECT-OPTIONS: so_kid  FOR  gs_tables-kisi_id.
    PARAMETERS:     p_sehir TYPE z_dt_gyer.
    SELECTION-SCREEN END OF BLOCK blockid1.
  ENDLOOP.
  SELECTION-SCREEN BEGIN OF BLOCK blockid2 WITH FRAME TITLE text-002.
  PARAMETERS: p_tumk RADIOBUTTON GROUP rad1,
              p_kt   RADIOBUTTON GROUP rad1,
              p_kst  RADIOBUTTON GROUP rad1,
              p_ksk  RADIOBUTTON GROUP rad1,
              p_sdt  RADIOBUTTON GROUP rad1,
              p_st   RADIOBUTTON GROUP rad1.
  SELECTION-SCREEN END OF BLOCK blockid2.

  SELECTION-SCREEN BEGIN OF BLOCK blockid3 WITH FRAME TITLE text-003.
  PARAMETERS: p_satrr RADIOBUTTON GROUP rad2,
              p_hucrr RADIOBUTTON GROUP rad2.
  SELECTION-SCREEN END OF BLOCK blockid3.


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

    PERFORM get_kt_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_kt.

    PERFORM call_alv_grid.

  ELSEIF p_kst = 'X'.

    PERFORM get_kst_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_kst.

    PERFORM call_alv_grid.

  ELSEIF p_ksk = 'X'.

    PERFORM get_ksk_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_ksk.

    PERFORM call_alv_grid.

  ELSEIF p_sdt = 'X'.

    PERFORM sehir_dilim_tutar.

  ELSEIF p_st = 'X'.

    PERFORM get_st_data.

    PERFORM set_layout.

    IF p_satrr = abap_true.
      PERFORM set_line_color.
    ELSEIF p_hucrr = abap_true.
      PERFORM set_cell_color.
    ENDIF.

    PERFORM prepare_fieldcat_alv_st.

    PERFORM call_alv_grid.

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

  DATA: lv_lines      TYPE i,
        lv_slines(10) TYPE c,
        lv_title      TYPE lvc_title.
*** Total records
  DESCRIBE TABLE gt_tables LINES lv_lines.
  lv_slines = lv_lines.
  CONDENSE lv_slines.
  CONCATENATE 'Toplam' lv_slines 'kayıt mevcut'
         INTO lv_title SEPARATED BY space.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      i_grid_title             = lv_title
      is_layout                = ls_layout
      it_fieldcat              = gt_fieldcat[]
      i_default                = 'X'
    TABLES
      t_outtab                 = gt_tables[] "gt_tour
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.

ENDFORM.

FORM sfkst.

  DATA: lv_fm_name TYPE rs38l_fnam.

  SELECT *
FROM zyt_per_infosv2
INTO TABLE gt_info.

  IF sy-subrc EQ 0.
    SELECT *
    FROM zyt_per_toursv2
    INTO TABLE gt_tour
    FOR ALL ENTRIES IN gt_info
    WHERE kisi_id EQ gt_info-kisi_id
    AND zyt_per_toursv2~kisi_id IN so_kid.
  ENDIF.


  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname = 'ZYT_BT3V2_SFV2'
    IMPORTING
      fm_name  = lv_fm_name.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  CALL FUNCTION lv_fm_name
    TABLES
      gt_info_sf       = gt_info
      gt_tour_sf       = gt_tour
    EXCEPTIONS
      formatting_error = 1
      internal_error   = 2
      send_error       = 3
      user_canceled    = 4
      OTHERS           = 5.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.

FORM sfkst1.

  DATA: lv_fm_name TYPE rs38l_fnam.

  SELECT *
 FROM zyt_per_infosv2
 INTO TABLE gt_info.


  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname = 'ZYT_BT3_2_SFV1'
    IMPORTING
      fm_name  = lv_fm_name.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL FUNCTION lv_fm_name
    TABLES
      gt_info_sf       = gt_info
    EXCEPTIONS
      formatting_error = 1
      internal_error   = 2
      send_error       = 3
      user_canceled    = 4
      OTHERS           = 5.
  IF sy-subrc <> 0.
* Implement suitable error handling here
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

  CASE p_ucomm.

    WHEN '&SUMM'.
      IF p_sdt = abap_true.
*** eski koda göre yazılan!!!
*        DATA: ref1 TYPE REF TO cl_gui_alv_grid.
*** alvde seçilen checkboxları internal tabloya yansıtır "checkbox
*        CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
*          IMPORTING
*            e_grid = ref1.
*        CALL METHOD ref1->check_changed_data.
*
*        LOOP AT gt_sdt_collect WHERE check = 'X'.
*
*          DATA: gv_msgsehr(100) TYPE c,
*                gv_sehrtop      TYPE /cem/rate,
*                gv_text(100)    TYPE c.
*          gv_msgsehr = gt_sdt_collect-gid_yer.
*          gv_sehrtop = gt_sdt_collect-ilk_s + gt_sdt_collect-iki_s + gt_sdt_collect-uc_s + gt_sdt_collect-dort_s + gt_sdt_collect-bes_s + gt_sdt_collect-alti_s + gt_sdt_collect-yedi_s.
*
*          CALL FUNCTION 'POPUP_TO_INFORM'
*            EXPORTING
*              titel = 'TUR BİLGİSİ'
*              txt1  = gv_msgsehr
*              txt2  = gv_sehrtop.
*        ENDLOOP.


        DATA: ref1 TYPE REF TO cl_gui_alv_grid.
*** alvde seçilen checkboxları internal tabloya yansıtır "checkbox

        CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
          IMPORTING
            e_grid = ref1.
        CALL METHOD ref1->check_changed_data.

        LOOP AT gt_sdt WHERE check = 'X'.

          DATA: gv_msgsehr(100) TYPE c,
                gv_sehrtop      TYPE /cem/rate,
                gv_text(100)    TYPE c.
          gv_msgsehr = gt_sdt-gid_yer.
          gv_sehrtop = gt_sdt-ilk_s + gt_sdt-iki_s + gt_sdt-uc_s + gt_sdt-dort_s + gt_sdt-bes_s + gt_sdt-alti_s + gt_sdt-yedi_s.

          CALL FUNCTION 'POPUP_TO_INFORM'
            EXPORTING
              titel = 'TUR BİLGİSİ'
              txt1  = gv_msgsehr
              txt2  = gv_sehrtop.
        ENDLOOP.
      ENDIF.

    WHEN '&SFKST'.

      PERFORM sfkst.

    WHEN '&SFKST1'.

      PERFORM sfkst1.

  ENDCASE.

ENDFORM.

FORM get_all_data.

  SELECT *
    FROM     zyt_per_toursv2   AS a
    INNER JOIN zyt_per_infosv2 AS b ON a~kisi_id = b~kisi_id
    INTO CORRESPONDING FIELDS OF TABLE gt_tables
    WHERE a~kisi_id IN so_kid.


ENDFORM.

FORM get_ksk_data.

  SELECT *
FROM zyt_per_infosv2
INTO TABLE gt_info.

  IF sy-subrc EQ 0.
    SELECT *
      FROM zyt_per_toursv2
      INTO TABLE gt_tour
      FOR ALL ENTRIES IN gt_info
      WHERE kisi_id EQ gt_info-kisi_id
      AND zyt_per_toursv2~kisi_id IN so_kid.
  ENDIF.

  DATA: lv_k_adet TYPE int4.
  lv_k_adet = 0.

*** kişi-şehir tablosunun kopyasını al
  gt_tour_copy[] = gt_tour[].

*** kişi-şehir kayıtlarını tekilleştir (Özellikle kapalı hangi satır hangi kaleme denk geliyor!)
*  SORT gt_tour_copy BY kisi_id gid_yer.
*  DELETE ADJACENT DUPLICATES FROM gt_tour_copy COMPARING kisi_id gid_yer.

*** Kişi-şehir bazında döngü
  LOOP AT gt_tour_copy.
    CLEAR: lv_k_adet.
*** Her bir kişi ve şehire gidiş için kalem toplamlarını hesapla
    LOOP AT gt_tour WHERE kisi_id = gt_tour_copy-kisi_id
                      AND gid_yer = gt_tour_copy-gid_yer.
      lv_k_adet = lv_k_adet + 1.
    ENDLOOP.

    gt_tables-kalem_id = gt_tour_copy-kalem_id.
*** ALV tablosunu hazırla
    gt_tables-kisi_id  = gt_tour-kisi_id.
    gt_tables-gid_yer  = gt_tour-gid_yer.

    gt_tables-k_adet   = lv_k_adet.

*** Kişi ad soyad'ını al
    READ TABLE gt_info WITH KEY kisi_id = gt_tour-kisi_id.
    IF sy-subrc EQ 0.
      gt_tables-isim  = gt_info-isim.
      gt_tables-soyad = gt_info-soyad.
    ENDIF.

    APPEND gt_tables. CLEAR gt_tables.
  ENDLOOP.

ENDFORM.

FORM get_kt_data.

  DATA: lv_rate  TYPE zyt_per_toursv2-rate.

  SELECT *
FROM zyt_per_infosv2
INTO TABLE gt_info.

  SELECT *
    FROM zyt_per_toursv2
    INTO TABLE gt_tour
    FOR ALL ENTRIES IN gt_info
    WHERE kisi_id EQ gt_info-kisi_id
    AND zyt_per_toursv2~kisi_id IN so_kid.

*** kişi-tutar tablosunun kopyasını al
  gt_tour_copy[] = gt_tour[].

*** kişi-tutar kayıtlarını tekilleştir
  SORT gt_tour_copy BY kisi_id.
  DELETE ADJACENT DUPLICATES FROM gt_tour_copy COMPARING kisi_id.

*** Kişi-tutar bazında döngü
  LOOP AT gt_tour_copy.
    CLEAR: lv_rate.
* Her bir kişi ve şehir için rate toplamlarını hesapla
    LOOP AT gt_tour WHERE kisi_id = gt_tour_copy-kisi_id.
      lv_rate = lv_rate + gt_tour-rate.
    ENDLOOP.

* ALV tablosunu hazırla
    gt_tables-kisi_id = gt_tour-kisi_id.
    gt_tables-rate    = lv_rate.

* Kişi ad soyad'ını al
    READ TABLE gt_info WITH KEY kisi_id = gt_tour-kisi_id.
    IF sy-subrc EQ 0.
      gt_tables-isim  = gt_info-isim.
      gt_tables-soyad = gt_info-soyad.
    ENDIF.

    APPEND gt_tables. CLEAR gt_tables.
  ENDLOOP.

*** Alternatif hintli yunus kodu :(
*  LOOP AT gt_info INTO gs_info.
*    CLEAR: gs_tour.
*    LOOP AT gt_tour INTO gs_tour WHERE kisi_id = gs_info-kisi_id.
*      gs_tables-kisi_id      = gs_info-kisi_id.
*      gs_kt_collect-isim     = gs_info-isim.
*      gs_kt_collect-soyad    = gs_info-soyad.
*      gs_kt_collect-rate     = gs_tour-rate.
*      COLLECT gs_kt_collect INTO gt_kt_collect.
*    ENDLOOP.
*  ENDLOOP.
*
*  CLEAR: gs_info.
*  LOOP AT gt_info INTO gs_info.
*    CLEAR: gs_kt_collect.
*    LOOP AT gt_kt_collect INTO gs_kt_collect WHERE isim = gs_info-isim AND soyad = gs_info-soyad.
*      gs_tables-kisi_id  = gs_info-kisi_id.
*      gs_tables-rate     = gs_kt_collect-rate.
*      gs_tables-isim     = gs_kt_collect-isim.
*      gs_tables-soyad    = gs_kt_collect-soyad.
*      APPEND gs_tables TO gt_tables.
*    ENDLOOP.
*  ENDLOOP.

ENDFORM.

FORM get_kst_data.

  DATA: lv_rate  TYPE zyt_per_toursv2-rate.

  SELECT *
 FROM zyt_per_infosv2
 INTO TABLE gt_info.

  IF sy-subrc EQ 0.
    SELECT *
    FROM zyt_per_toursv2
    INTO TABLE gt_tour
    FOR ALL ENTRIES IN gt_info
    WHERE kisi_id EQ gt_info-kisi_id
    AND zyt_per_toursv2~kisi_id IN so_kid.
  ENDIF.

*** kişi-şehir tablosunun kopyasını al
  gt_tour_copy[] = gt_tour[].

*** kişi-şehir kayıtlarını tekilleştir
  SORT gt_tour_copy BY kisi_id gid_yer.
  DELETE ADJACENT DUPLICATES FROM gt_tour_copy COMPARING kisi_id gid_yer.

*** Kişi-şehir bazında döngü
  LOOP AT gt_tour_copy INTO gs_tour_copy.
    CLEAR: lv_rate.
* Her bir kişi ve şehir için rate toplamlarını hesapla
    LOOP AT gt_tour INTO gs_tour WHERE kisi_id = gs_tour_copy-kisi_id
                      AND gid_yer = gs_tour_copy-gid_yer.
      lv_rate = lv_rate + gs_tour-rate.
    ENDLOOP.

* ALV tablosunu hazırla
    gs_tables-kisi_id = gs_tour-kisi_id.
    gs_tables-gid_yer = gs_tour-gid_yer.
    gs_tables-rate    = lv_rate.

* Kişi ad soyad'ını al
    READ TABLE gt_info INTO gs_info WITH KEY kisi_id = gs_tour-kisi_id.
    IF sy-subrc EQ 0.
      gs_tables-isim  = gs_info-isim.
      gs_tables-soyad = gs_info-soyad.
    ENDIF.

    APPEND gs_tables TO gt_tables. CLEAR gs_tables.
  ENDLOOP.

ENDFORM.

FORM get_st_data.

  DATA: lv_rate  TYPE zyt_per_toursv2-rate.

  SELECT *
 FROM zyt_per_infosv2
 INTO TABLE gt_info.

  SELECT *
  FROM zyt_per_toursv2
  INTO TABLE gt_tour
  FOR ALL ENTRIES IN gt_info
  WHERE kisi_id EQ gt_info-kisi_id
  AND zyt_per_toursv2~kisi_id IN so_kid.

*** şehir tablosunun kopyasını al
  gt_tour_copy[] = gt_tour[].

*** şehir kayıtlarını tekilleştir
  SORT gt_tour_copy BY gid_yer.
  DELETE ADJACENT DUPLICATES FROM gt_tour_copy COMPARING gid_yer.

*** şehir bazında döngü
  LOOP AT gt_tour_copy.
    CLEAR: lv_rate.
* Her bir kişi ve şehir için rate toplamlarını hesapla
    LOOP AT gt_tour WHERE gid_yer = gt_tour_copy-gid_yer.
      lv_rate = lv_rate + gt_tour-rate.
    ENDLOOP.

* ALV tablosunu hazırla
    gt_tables-gid_yer = gt_tour-gid_yer.
    gt_tables-rate    = lv_rate.

    APPEND gt_tables. CLEAR gt_tables.
  ENDLOOP.

*** Alternatif hintli yunus kodu :(
*  LOOP AT gt_info INTO gs_info.
*    CLEAR: gs_tour.
*    LOOP AT gt_tour INTO gs_tour WHERE kisi_id = gs_info-kisi_id.
*      gs_st_collect-gid_yer  = gs_tour-gid_yer.
*      gs_st_collect-rate     = gs_tour-rate.
*      COLLECT gs_st_collect INTO gt_st_collect.
*    ENDLOOP.
*  ENDLOOP.
*
*  LOOP AT gt_st_collect INTO gs_st_collect.
*    gs_tables-gid_yer = gs_st_collect-gid_yer.
*    gs_tables-rate    = gs_st_collect-rate.
*    APPEND gs_tables TO gt_tables.
*  ENDLOOP.
*
*
*  SORT gt_tables BY gid_yer.
*  DELETE ADJACENT DUPLICATES FROM gt_tables
*         COMPARING gid_yer.

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
  DATA: gv_bir TYPE i.
  gv_bir = 12.

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
      i_structure_name       = 'ZYT_KSK_STRUCTURE'
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
      WHEN 'K_ADET'.
        ls_fieldcat-seltext_l    = 'KAÇ ADET KALEM VAR'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 6.
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

FORM prepare_fieldcat_alv_st.

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

  LOOP AT gt_fieldcat INTO ls_fieldcat .
    CASE ls_fieldcat-fieldname .
      WHEN 'GID_YER'.
        ls_fieldcat-seltext_l    = 'GİDECEĞİ YER'.
        ls_fieldcat-outputlen    = 20.
        ls_fieldcat-col_pos      = 1.
      WHEN 'RATE'.
        ls_fieldcat-seltext_l    = 'TUTAR'.
        ls_fieldcat-outputlen    = 4.
        ls_fieldcat-col_pos      = 2.
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


FORM sehir_dilim_tutar.

  DATA: lv_rate  TYPE zyt_per_toursv2-rate.


  SELECT *
  FROM zyt_per_toursv2
  INTO CORRESPONDING FIELDS OF TABLE gt_sdttur.


*** kişi-şehir tablosunun kopyasını al
  gt_sdttur_copy[] = gt_sdttur[].


** şehir-saat kayıtlarını tekilleştir
  SORT gt_sdttur_copy BY gid_yer saat.
  DELETE ADJACENT DUPLICATES FROM gt_sdttur_copy COMPARING gid_yer saat.

*** Kişi-şehir bazında döngü
  LOOP AT gt_sdttur_copy INTO gs_sdttur_copy.
    CLEAR: lv_rate.
* Her bir kişi ve şehir için rate toplamlarını hesapla
    LOOP AT gt_sdttur INTO gs_sdttur WHERE saat = gs_sdttur_copy-saat
                                     AND  gid_yer = gs_sdttur_copy-gid_yer.
      lv_rate = lv_rate + gs_sdttur-rate.

    ENDLOOP.

    CASE gs_sdttur_copy-saat.
      WHEN '1'.
        gs_sdt-ilk_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '2'.
        gs_sdt-iki_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '3'.
        gs_sdt-uc_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '4'.
        gs_sdt-dort_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '5'.
        gs_sdt-bes_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '6'.
        gs_sdt-alti_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
      WHEN '7'.
        gs_sdt-yedi_s   = lv_rate.
        gs_sdt-gid_yer = gs_sdttur-gid_yer.
        COLLECT gs_sdt INTO gt_sdt. CLEAR gs_sdt.
    ENDCASE.
  ENDLOOP.




****************************ADANA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '1'
*     AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null  dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '2'
*     AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null  dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '3'
*     AND gid_yer = 'ADANA'.
****************************ADANA
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '4'
*     AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '5'
*    AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '6'
*    AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************ADANA
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '7'
*    AND gid_yer = 'ADANA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
*  ENDLOOP.
****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '1'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '2'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '3'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '4'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '5'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '6'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************BURSA
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '7'
*     AND gid_yer = 'BURSA'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '1'
*     AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '2'
*     AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '3'
*    AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '4'
*    AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '5'
*    AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '6'
*    AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************İSTANBUL
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '7'
*    AND gid_yer = 'İSTANBUL'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*     FROM zyt_per_toursv2
*     INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*   WHERE saat = '1'
*     AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gs_sdttur-rate iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '2'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gs_sdttur-rate uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '3'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gs_sdttur-rate dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '4'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gs_sdttur-rate bes_s = gv_null alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '5'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gs_sdttur-rate alti_s = gv_null yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '6'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gs_sdttur-rate yedi_s = gv_null ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*  SELECT *
*    FROM zyt_per_toursv2
*    INTO CORRESPONDING FIELDS OF TABLE gt_sdttur
*  WHERE saat = '7'
*    AND gid_yer = 'YOZGAT'.
*
*  CLEAR: gs_sdttur.
*  LOOP AT gt_sdttur INTO gs_sdttur.
*    APPEND VALUE #( gid_yer = gs_sdttur-gid_yer ilk_s = gv_null iki_s = gv_null uc_s = gv_null dort_s = gv_null bes_s = gv_null alti_s = gv_null yedi_s = gs_sdttur-rate ) TO gt_sdt.
*  ENDLOOP.
*****************************YOZGAT
*
*
*  LOOP AT gt_sdt INTO gs_sdt.
*    gs_sdt_collect = gs_sdt.
*    COLLECT gs_sdt_collect INTO gt_sdt_collect.
*  ENDLOOP.

  ls_layout-zebra             = abap_true.
  ls_layout-colwidth_optimize = abap_true.
  ls_layout-info_fieldname    = 'LINE_COLOR_SDT'.
*  ls_layout-coltab_fieldname  = 'CELL_COLOR'.

**Line renklendirme alanı.
  LOOP AT gt_sdt INTO gs_sdt.
    gs_sdt-line_color_sdt = 'C310'.
    IF gs_sdt-ilk_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-iki_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-uc_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-dort_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-bes_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-alti_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    IF gs_sdt-yedi_s > '450'.
      gs_sdt-line_color_sdt = 'C610'.
    ENDIF.
    MODIFY gt_sdt FROM gs_sdt.
  ENDLOOP.

***Cell renklendirme alanı.
* LOOP AT gt_sdt INTO gs_sdt.
*   if gs_sdt-yedi_s > 500.
*   CLEAR: gs_cell_color.
*   gs_cell_color-fieldname  = '16:00-18:00'.
*   gs_cell_color-color-col  = 7.
*   gs_cell_color-color-int  = 1.
*   gs_cell_color-color-inv  = 0.
*   APPEND gs_cell_color to gs_sdt-cell_color.
*   ENDIF.
*   MODIFY gt_sdt FROM gs_sdt.
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
      t_outtab                 = gt_sdt[]
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc = 0.
    "do nothing
  ENDIF.
ENDFORM.


***************************************************************************************FIELDCAT-AREA-END*************
