*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZYT_PER_INFOS...................................*
DATA:  BEGIN OF STATUS_ZYT_PER_INFOS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_PER_INFOS                 .
CONTROLS: TCTRL_ZYT_PER_INFOS
            TYPE TABLEVIEW USING SCREEN '0102'.
*...processing: ZYT_PER_INFOSV2.................................*
DATA:  BEGIN OF STATUS_ZYT_PER_INFOSV2               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_PER_INFOSV2               .
CONTROLS: TCTRL_ZYT_PER_INFOSV2
            TYPE TABLEVIEW USING SCREEN '0107'.
*...processing: ZYT_PER_TOURS...................................*
DATA:  BEGIN OF STATUS_ZYT_PER_TOURS                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_PER_TOURS                 .
CONTROLS: TCTRL_ZYT_PER_TOURS
            TYPE TABLEVIEW USING SCREEN '0101'.
*...processing: ZYT_PER_TOURS0..................................*
DATA:  BEGIN OF STATUS_ZYT_PER_TOURS0                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_PER_TOURS0                .
CONTROLS: TCTRL_ZYT_PER_TOURS0
            TYPE TABLEVIEW USING SCREEN '0106'.
*...processing: ZYT_PER_TOURSV2.................................*
DATA:  BEGIN OF STATUS_ZYT_PER_TOURSV2               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_PER_TOURSV2               .
CONTROLS: TCTRL_ZYT_PER_TOURSV2
            TYPE TABLEVIEW USING SCREEN '0108'.
*...processing: ZYT_SDT.........................................*
DATA:  BEGIN OF STATUS_ZYT_SDT                       .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_SDT                       .
*...processing: ZYT_SDT0........................................*
DATA:  BEGIN OF STATUS_ZYT_SDT0                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_SDT0                      .
CONTROLS: TCTRL_ZYT_SDT0
            TYPE TABLEVIEW USING SCREEN '0104'.
*...processing: ZYT_SDT1........................................*
DATA:  BEGIN OF STATUS_ZYT_SDT1                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZYT_SDT1                      .
CONTROLS: TCTRL_ZYT_SDT1
            TYPE TABLEVIEW USING SCREEN '0105'.
*.........table declarations:.................................*
TABLES: *ZYT_PER_INFOS                 .
TABLES: *ZYT_PER_INFOSV2               .
TABLES: *ZYT_PER_TOURS                 .
TABLES: *ZYT_PER_TOURS0                .
TABLES: *ZYT_PER_TOURSV2               .
TABLES: *ZYT_SDT                       .
TABLES: *ZYT_SDT0                      .
TABLES: *ZYT_SDT1                      .
TABLES: ZYT_PER_INFOS                  .
TABLES: ZYT_PER_INFOSV2                .
TABLES: ZYT_PER_TOURS                  .
TABLES: ZYT_PER_TOURS0                 .
TABLES: ZYT_PER_TOURSV2                .
TABLES: ZYT_SDT                        .
TABLES: ZYT_SDT0                       .
TABLES: ZYT_SDT1                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
