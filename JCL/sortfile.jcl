//Z50996R  JOB (ACCT),'RUN SORTFILE',
//             CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*=============================================================
//* JOB     : SORTFILE (RUN JCL)
//* PROGRAM : SORTFILE
//* DESC    : SORT EMPLOYEE RECORDS BY NAME (POSITIONS 1-8)
//* INPUT   : Z50996.AI.KIRO.SORTFILE.INPUTA
//* OUTPUT  : Z50996.AI.KIRO.SORTFILE.OUTPUTB
//*=============================================================
//*
//*-------------------------------------------------------------
//* STEP 1 : DELETE OUTPUT FILE FROM PREVIOUS RUN (IF EXISTS)
//*          IDCAMS DELETE WILL NOT FAIL IF DS DOES NOT EXIST
//*          BECAUSE OF THE SET MAXCC STATEMENT
//*-------------------------------------------------------------
//DELOUT   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE Z50996.AI.KIRO.SORTFILE.OUTPUTB
  SET MAXCC = 0
/*
//*-------------------------------------------------------------
//* STEP 2 : RECREATE OUTPUT FILE FRESH
//*-------------------------------------------------------------
//MKOUT    EXEC PGM=IEFBR14
//OUTPUTB  DD  DSN=Z50996.AI.KIRO.SORTFILE.OUTPUTB,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,
//             SPACE=(TRK,(5,2)),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=27920,DSORG=PS)
//*-------------------------------------------------------------
//* STEP 3 : RUN SORTFILE PROGRAM
//*-------------------------------------------------------------
//RUN      EXEC PGM=SORTFILE,COND=(8,LT)
//STEPLIB  DD DSN=Z50996.AI.KIRO.LOAD,DISP=SHR
//INPFILE  DD DSN=Z50996.AI.KIRO.SORTFILE.INPUTA,DISP=SHR
//OUTFILE  DD DSN=Z50996.AI.KIRO.SORTFILE.OUTPUTB,DISP=SHR
//SORTWORK DD UNIT=SYSDA,SPACE=(TRK,(30,10))
//SYSOUT   DD SYSOUT=*,OUTLIM=15000
//CEEDUMP  DD DUMMY
//SYSUDUMP DD DUMMY
