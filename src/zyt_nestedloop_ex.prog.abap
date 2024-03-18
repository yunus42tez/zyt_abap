*&---------------------------------------------------------------------*
*& Report  ZYT_NESTEDLOOP_EX
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_nestedloop_ex.

TYPES: BEGIN OF gty_id,
         tablo_id TYPE i,
       END OF gty_id.

DATA: gt_id TYPE gty_id OCCURS 0 WITH HEADER LINE,
      gs_id TYPE gty_id.

TYPES: BEGIN OF gty_durak,
         tablo_id  TYPE  i,
         durak(15) TYPE c,
       END OF gty_durak.

DATA: gt_durak TYPE gty_durak OCCURS 0 WITH HEADER LINE,
      gs_durak TYPE gty_durak.
***
gs_id-tablo_id = 1.
APPEND gs_id TO gt_id. CLEAR gs_id.
gs_id-tablo_id = 2.
APPEND gs_id TO gt_id. CLEAR gs_id.
gs_id-tablo_id = 3.
APPEND gs_id TO gt_id. CLEAR gs_id.
gs_id-tablo_id = 4.
APPEND gs_id TO gt_id. CLEAR gs_id.
gs_id-tablo_id = 5.
APPEND gs_id TO gt_id. CLEAR gs_id.
***
***
***
gs_durak-tablo_id = 1.
gs_durak-durak    = 'BEYOĞLU'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 1.
gs_durak-durak    = 'ERENKÖY'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 2.
gs_durak-durak    = 'BOSTANCI'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 2.
gs_durak-durak    = 'TUZLA'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 3.
gs_durak-durak    = 'TAKSİM'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 4.
gs_durak-durak    = 'ESENTEPE'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 4.
gs_durak-durak    = 'HALKALI'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
gs_durak-tablo_id = 5.
gs_durak-durak    = 'ÜSKÜDAR'.
APPEND gs_durak TO gt_durak. CLEAR gs_durak.
*********************************************************************************** NESTED LOOP
WRITE: '1. Nested Loop'.
CLEAR: gs_id.
LOOP AT gt_id INTO gs_id.

  CLEAR: gs_durak.
  LOOP AT gt_durak INTO gs_durak WHERE tablo_id = gs_id-tablo_id.
    WRITE: / 'id:', gs_id-tablo_id ,30 'Durak:', gs_durak-durak.
  ENDLOOP.
  ULINE.

ENDLOOP.

************************************************************************************* LOOP + READ TABLE

WRITE: /,/,/, '2. LOOP + READ TABLE loop id read table durak'.
ULINE.

LOOP AT gt_id.

  READ TABLE gt_durak WITH KEY tablo_id = gt_id-tablo_id.

  IF sy-subrc EQ 0.

    WRITE: / 'ID:', gt_id-tablo_id ,30 'Durak:', gt_durak-durak.

  ENDIF.
  ULINE.

ENDLOOP.

WRITE: /,/,/, '3. LOOP + READ TABLE loop durak + read table id'.
ULINE.

LOOP AT gt_durak.

  READ TABLE gt_id WITH KEY tablo_id = gt_durak-tablo_id.

  IF sy-subrc EQ 0.

    WRITE: / 'ID:', gt_id-tablo_id ,30 'Durak:', gt_durak-durak.

  ENDIF.
  ULINE.

ENDLOOP.




*cl_demo_output=>write_data( gt_id ).
*cl_demo_output=>write_data( gt_durak ).
*cl_demo_output=>display( ).
