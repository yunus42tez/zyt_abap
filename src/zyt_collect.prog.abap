*&---------------------------------------------------------------------*
*& Report  ZYT_COLLECT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zyt_collect.

TYPES: BEGIN OF gty_sdt_type,
         carrid TYPE s_carr_id,
*           CURRENCY type S_CURRCODE,
*           PLANETYPE type S_PLANETYE,
         price  TYPE s_price,
*            SEATSMAX_B type S_SMAX_B,
*            SEATSMAX type S_SEATSMAX,

       END OF gty_sdt_type.


DATA: gt_sdt            TYPE TABLE OF gty_sdt_type,
      gs_sdt            TYPE gty_sdt_type,
      gt_tables_collect TYPE TABLE OF gty_sdt_type,
      gs_tables_collect TYPE gty_sdt_type.

SELECT *
  FROM sflight
  INTO CORRESPONDING FIELDS OF TABLE gt_sdt.


CLEAR: gs_sdt.
*LOOP AT gt_sdt INTO gs_sdt.
*  MOVE-CORRESPONDING gs_sdt TO gs_tables_collect.
*  COLLECT gs_tables_collect INTO  gt_tables_collect.
*ENDLOOP.

LOOP AT gt_sdt INTO gs_sdt.
  gs_tables_collect = gs_sdt.
  COLLECT gs_tables_collect INTO  gt_tables_collect.
ENDLOOP.



cl_demo_output=>write_data( gt_sdt ).
cl_demo_output=>write_data( gt_tables_collect ).
cl_demo_output=>display( ).
