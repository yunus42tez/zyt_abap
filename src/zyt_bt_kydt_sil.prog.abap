*&---------------------------------------------------------------------*
*& Report  ZYT_BT_KYDT_SIL
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_bt_kydt_sil MESSAGE-ID zyt_msg01.

TABLES: zyt_per_infos,
        zyt_per_tours.

DATA:gv_kisi_id  TYPE z_dt_id,
     gv_kalem_id TYPE z_dt_kal,
     gv_saat     TYPE z_dt_ysaat,
     gv_gid_yer  TYPE z_dt_gyer,
     gv_rate     TYPE /cem/rate,
     gv_islem_id TYPE z_dt_islid,
     gv_isim     TYPE z_dt_isim,
     gv_soyad    TYPE z_dt_sad,
     gv_yas      TYPE z_dt_yas,

     gt_turkyt   LIKE zyt_per_tours OCCURS 0 WITH HEADER LINE,
     gs_turkyt   LIKE zyt_per_tours.

DATA: gv_kalnum TYPE z_dt_kal.

CONSTANTS: c_range_no     TYPE inri-nrrangenr VALUE '01',
           c_range_object TYPE inri-object VALUE 'ZYT01'.

DATA: lv_next_number(50) TYPE c.

CALL FUNCTION 'NUMBER_GET_NEXT'
  EXPORTING
    nr_range_nr = c_range_no
    object      = c_range_object
  IMPORTING
    number      = lv_next_number.



START-OF-SELECTION.

  SELECTION-SCREEN BEGIN OF BLOCK bid001 WITH FRAME TITLE text-001.
  PARAMETERS: p_kid  TYPE z_dt_id,
              p_saat TYPE z_dt_ysaat,
              p_gyer TYPE z_dt_gyer,
              p_ucrt TYPE /cem/rate.
  SELECTION-SCREEN END OF BLOCK bid001.

  SELECTION-SCREEN BEGIN OF BLOCK bid002 WITH FRAME TITLE text-002.
  PARAMETERS: p_skid TYPE z_dt_id,
              p_skal TYPE z_dt_kal.
  SELECTION-SCREEN END OF BLOCK bid002.

  SELECTION-SCREEN BEGIN OF BLOCK bid003 WITH FRAME.
  PARAMETERS: p_rad1 RADIOBUTTON GROUP rad1,
              p_rad2 RADIOBUTTON GROUP rad1,
              p_rad3 RADIOBUTTON GROUP rad1.
  SELECTION-SCREEN END OF BLOCK bid003.



  IF p_rad1 = 'X'.
****************************************************** değerleri sıralayıp eksik olan değeri doldurur.
 SELECT * FROM zyt_per_tours
      INTO TABLE gt_turkyt
      WHERE kisi_id = p_kid ORDER BY kalem_id.

    gv_kalnum = 0.

    IF sy-subrc EQ 0.
      LOOP AT gt_turkyt INTO gs_turkyt.
        gv_kalnum = gv_kalnum + 1.

        IF gv_kalnum NE gs_turkyt-kalem_id.

          gs_turkyt-islem_id = lv_next_number.
          gs_turkyt-kisi_id  = p_kid.
          gs_turkyt-kalem_id = gv_kalnum.
          gs_turkyt-saat     = p_saat.
          gs_turkyt-gid_yer  = p_gyer.
          gs_turkyt-rate     = p_ucrt.

          INSERT zyt_per_tours FROM gs_turkyt.
          CLEAR gv_kalnum. CLEAR gs_turkyt.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF gv_kalnum EQ gs_turkyt-kalem_id.

        gv_kalnum = gv_kalnum + 1.
        gs_turkyt-islem_id = lv_next_number.
        gs_turkyt-kisi_id  = p_kid.
        gs_turkyt-kalem_id = gv_kalnum.
        gs_turkyt-saat     = p_saat.
        gs_turkyt-gid_yer  = p_gyer.
        gs_turkyt-rate     = p_ucrt.

        INSERT zyt_per_tours FROM gs_turkyt.
        CLEAR gv_kalnum. CLEAR gs_turkyt.
      ENDIF.

      IF sy-subrc EQ 0.
        MESSAGE s000.
        EXIT.
      ENDIF.
    ENDIF.

    IF sy-subrc NE 0.

      gs_turkyt-islem_id = lv_next_number.
      gs_turkyt-kisi_id  = p_kid.
      gs_turkyt-kalem_id = 1.
      gs_turkyt-saat     = p_saat.
      gs_turkyt-gid_yer  = p_gyer.
      gs_turkyt-rate     = p_ucrt.

      INSERT zyt_per_tours FROM gs_turkyt.
      CLEAR gs_turkyt.

      IF sy-subrc EQ 0.
        MESSAGE s000.
        EXIT.
      ENDIF.
    ENDIF.


************************************ en yüksek değerin 1 fazlası olarak ekleme yapar.
*    SELECT * FROM zyt_per_tours
*    INTO TABLE gt_turkyt
*    WHERE kisi_id = p_kid.
*
*    IF sy-subrc EQ 0.
*
*      SELECT MAX( kalem_id )
*         FROM zyt_per_tours
*        INTO gv_kalnum
*        WHERE kisi_id = p_kid.
*
*      gv_kalnum = gv_kalnum + 1.
*
*      gs_turkyt-islem_id = lv_next_number.
*      gs_turkyt-kisi_id  = p_kid.
*      gs_turkyt-kalem_id = gv_kalnum .
*      gs_turkyt-saat     = p_saat.
*      gs_turkyt-gid_yer  = p_gyer.
*      gs_turkyt-rate     = p_ucrt.
*
*     "   INSERT zyt_per_tours FROM gs_turkyt.
*
*      IF sy-subrc EQ 0.
*        MESSAGE s000.
*        EXIT.
*      ENDIF.
*    ENDIF.
*
*    gs_turkyt-islem_id = lv_next_number.
*    gs_turkyt-kisi_id  = p_kid.
*    gs_turkyt-kalem_id = gv_kalnum.
*    gs_turkyt-saat     = p_saat.
*    gs_turkyt-gid_yer  = p_gyer.
*    gs_turkyt-rate     = p_ucrt.
*
*   " INSERT zyt_per_tours FROM gs_turkyt.
*    IF sy-subrc EQ 0.
*      MESSAGE s000.
*      EXIT.
*    ENDIF.

  ELSEIF p_rad2 = 'X'.

    SELECT * FROM zyt_per_tours
      INTO TABLE gt_turkyt
      WHERE kisi_id = p_skid
      AND kalem_id  = p_skal.

    IF sy-subrc NE 0.
      MESSAGE i001.
      EXIT.
    ENDIF.

    DELETE FROM zyt_per_tours WHERE kisi_id = p_skid AND kalem_id = p_skal.
    IF sy-subrc EQ 0.
      MESSAGE i002.
      EXIT.
    ENDIF.

  ELSEIF p_rad3 = 'X'.

    SELECT * FROM zyt_per_tours
      INTO TABLE gt_turkyt.

    WRITE: 'TÜM KAYITLAR!',17 'Kişi ID.', 29 'Kalem ID', 42 'Saat',48 'Gideceği yer', 83 'Ücret'.

    SKIP 1.

    ULINE.

    LOOP AT gt_turkyt.

      WRITE:/  gt_turkyt-islem_id,
              gt_turkyt-kisi_id,
              gt_turkyt-kalem_id,
              gt_turkyt-saat,
              gt_turkyt-gid_yer,
              gt_turkyt-rate.

    ENDLOOP.

  ENDIF.
