*&---------------------------------------------------------------------*
*& Report  ZYT_NESTEDLOOP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_nestedloop.

TABLES: zyt_per_infos,
        zyt_per_tours.

DATA: gt_zyt_per_infos TYPE zyt_per_infos OCCURS 0 WITH HEADER LINE,
      gs_zyt_per_infos TYPE zyt_per_infos,
      gt_zyt_per_tours TYPE zyt_per_tours OCCURS 0 WITH HEADER LINE,
      gs_zyt_per_tours TYPE zyt_per_tours.

DATA: gv_tekrar TYPE i.
**** NESTED LOOP

SELECT * FROM zyt_per_infos INTO TABLE gt_zyt_per_infos.

IF gt_zyt_per_infos[] IS NOT INITIAL.

  SELECT * FROM zyt_per_tours INTO TABLE gt_zyt_per_tours FOR ALL ENTRIES IN gt_zyt_per_infos
    WHERE kisi_id = gt_zyt_per_infos-kisi_id.

ENDIF.

SORT gt_zyt_per_infos.
SORT gt_zyt_per_tours.

CLEAR: gs_zyt_per_infos.
LOOP AT gt_zyt_per_infos INTO gs_zyt_per_infos.

  CLEAR: gs_zyt_per_tours.
  LOOP AT gt_zyt_per_tours INTO gs_zyt_per_tours WHERE kisi_id = gs_zyt_per_infos-kisi_id.
    WRITE: / 'Kisi id:', gs_zyt_per_infos-kisi_id ,30 'Gideceği yer:', gs_zyt_per_tours-gid_yer.
    gv_tekrar = gv_tekrar + 1.
  ENDLOOP.
  WRITE:/, 60 'Kaç adet id gidiş var:', gv_tekrar. clear gv_tekrar.
  ULINE.

ENDLOOP.

************************************************************************************ LOOP + READ TABLE

WRITE: /,/,/, 'LOOP + READ TABLE'.
ULINE.

LOOP AT gt_zyt_per_tours. "INTO gs_zyt_per_tours.

  READ TABLE gt_zyt_per_infos WITH KEY kisi_id = gt_zyt_per_tours-kisi_id.

  IF sy-subrc EQ 0.

    WRITE: / 'Kisi id:', gt_zyt_per_infos-kisi_id ,30 'Gideceği yer:', gt_zyt_per_tours-gid_yer.

  ENDIF.
  ULINE.

ENDLOOP.
