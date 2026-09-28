//Z50996R  JOB (ACCT),'RUN S0C7DEMO',
//             CLASS=A,MSGCLASS=X,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*=============================================================
//* JOB     : S0C7DEMO (RUN JCL)
//* PROGRAM : S0C7DEMO
//* DESC    : DEMONSTRATES S0C7 DATA EXCEPTION ABEND
//*=============================================================
//RUN      EXEC PGM=S0C7DEMO
//STEPLIB  DD DSN=Z50996.AI.KIRO.LOAD,DISP=SHR
//SYSOUT   DD SYSOUT=*,OUTLIM=15000
//CEEDUMP  DD SYSOUT=*
//SYSUDUMP DD SYSOUT=*
