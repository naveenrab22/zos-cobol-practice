       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       AUTHOR. Z50996.
      *
      *    SIMPLE COBOL PROGRAM TO DISPLAY MESSAGES
      *    DATASET : Z50996.AI.KIRO.COBOL(HELLO)
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-ZOS.
       OBJECT-COMPUTER. IBM-ZOS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DATE               PIC X(08) VALUE SPACES.
       01 WS-TIME               PIC X(08) VALUE SPACES.
       01 WS-FORMATTED-DATE.
          05 WS-YEAR            PIC X(04).
          05 FILLER             PIC X(01) VALUE '/'.
          05 WS-MONTH           PIC X(02).
          05 FILLER             PIC X(01) VALUE '/'.
          05 WS-DAY             PIC X(02).
       01 WS-FORMATTED-TIME.
          05 WS-HOUR            PIC X(02).
          05 FILLER             PIC X(01) VALUE ':'.
          05 WS-MIN             PIC X(02).
          05 FILLER             PIC X(01) VALUE ':'.
          05 WS-SEC             PIC X(02).

       PROCEDURE DIVISION.
       0000-MAIN.
           MOVE FUNCTION CURRENT-DATE(1:8)  TO WS-DATE
           MOVE FUNCTION CURRENT-DATE(9:6)  TO WS-TIME

           MOVE WS-DATE(1:4) TO WS-YEAR
           MOVE WS-DATE(5:2) TO WS-MONTH
           MOVE WS-DATE(7:2) TO WS-DAY

           MOVE WS-TIME(1:2) TO WS-HOUR
           MOVE WS-TIME(3:2) TO WS-MIN
           MOVE WS-TIME(5:2) TO WS-SEC

           DISPLAY '============================================'
           DISPLAY '*                                          *'
           DISPLAY '*   HELLO FROM Z/OS MAINFRAME !           *'
           DISPLAY '*   COBOL PROGRAM : HELLO                 *'
           DISPLAY '*   AUTHOR        : Z50996                *'
           DISPLAY '*                                          *'
           DISPLAY '============================================'
           DISPLAY ' '
           DISPLAY '  DATE : ' WS-FORMATTED-DATE
           DISPLAY '  TIME : ' WS-FORMATTED-TIME
           DISPLAY ' '
           DISPLAY '  MY FIRST COBOL PROGRAM RUNS SUCCESSFULLY!'
           DISPLAY ' '
           DISPLAY '============================================'

           STOP RUN.
