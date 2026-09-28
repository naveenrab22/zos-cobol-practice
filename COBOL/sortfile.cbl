       IDENTIFICATION DIVISION.
       PROGRAM-ID. SORTFILE.
       AUTHOR. Z50996.
      *
      *    PURPOSE : READ INPUT FILE A, SORT BY FIRST 8 CHARS (KEY),
      *              WRITE SORTED RECORDS TO OUTPUT FILE B
      *    INPUT   : Z50996.AI.KIRO.INPUTA  (LRECL=80)
      *    OUTPUT  : Z50996.AI.KIRO.OUTPUTB (LRECL=80)
      *    SORT KEY: POSITIONS 1-8 (ASCENDING)
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-ZOS.
       OBJECT-COMPUTER. IBM-ZOS.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE
               ASSIGN TO INPFILE
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS WS-INFILE-STATUS.

           SELECT OUTPUT-FILE
               ASSIGN TO OUTFILE
               ORGANIZATION IS SEQUENTIAL
               ACCESS MODE  IS SEQUENTIAL
               FILE STATUS  IS WS-OUTFILE-STATUS.

           SELECT SORT-FILE
               ASSIGN TO SORTWORK.

       DATA DIVISION.
       FILE SECTION.

       FD  INPUT-FILE
           RECORDING MODE IS F
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 80 CHARACTERS.
       01  INPUT-RECORD             PIC X(80).

       FD  OUTPUT-FILE
           RECORDING MODE IS F
           LABEL RECORDS ARE STANDARD
           RECORD CONTAINS 80 CHARACTERS.
       01  OUTPUT-RECORD            PIC X(80).

       SD  SORT-FILE
           RECORD CONTAINS 80 CHARACTERS.
       01  SORT-RECORD.
           05  SORT-KEY             PIC X(08).
           05  SORT-REST            PIC X(72).

       WORKING-STORAGE SECTION.
       01  WS-INFILE-STATUS         PIC X(02) VALUE SPACES.
       01  WS-OUTFILE-STATUS        PIC X(02) VALUE SPACES.
       01  WS-OUTPUT-COUNT          PIC 9(05) VALUE ZEROS.
       01  WS-SORT-RETURN           PIC S9(04) VALUE ZEROS.
       01  WS-EOF-FLAG              PIC X(01) VALUE 'N'.
           88  EOF                  VALUE 'Y'.
       01  WS-READ-REC              PIC X(80) VALUE SPACES.

       PROCEDURE DIVISION.
       0000-MAIN.
           DISPLAY '============================================'
           DISPLAY ' SORTFILE - SORT PROGRAM STARTED           '
           DISPLAY '============================================'

           SORT SORT-FILE
               ON ASCENDING KEY SORT-KEY
               USING  INPUT-FILE
               GIVING OUTPUT-FILE

           MOVE RETURN-CODE TO WS-SORT-RETURN

           IF WS-SORT-RETURN = 0
               DISPLAY ' '
               DISPLAY ' SORT COMPLETED SUCCESSFULLY'
               DISPLAY ' RETURN CODE : ' WS-SORT-RETURN
           ELSE
               DISPLAY ' '
               DISPLAY ' SORT FAILED!'
               DISPLAY ' RETURN CODE : ' WS-SORT-RETURN
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           DISPLAY ' '
           DISPLAY ' SORTED OUTPUT RECORDS:'
           DISPLAY '============================================'

           OPEN INPUT OUTPUT-FILE
           MOVE 'N' TO WS-EOF-FLAG

           PERFORM UNTIL EOF
               READ OUTPUT-FILE INTO WS-READ-REC
                   AT END
                       MOVE 'Y' TO WS-EOF-FLAG
                   NOT AT END
                       ADD 1 TO WS-OUTPUT-COUNT
                       DISPLAY ' REC ' WS-OUTPUT-COUNT
                               ' : ' WS-READ-REC(1:30)
               END-READ
           END-PERFORM

           CLOSE OUTPUT-FILE

           DISPLAY '============================================'
           DISPLAY ' TOTAL RECORDS SORTED  : ' WS-OUTPUT-COUNT
           DISPLAY '============================================'

           STOP RUN.
