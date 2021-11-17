      ******************************************************************
      * Author:Santos Lima
      * Date:17/11/2021
      * Purpose:Ler Contatos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MODULO-LEITURA.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT CONTATOS ASSIGN TO
               'D:\Codigos Cobol\bin\Modulo\bin\contatos.dat'
               ORGANISATION IS INDEXED
               ACCESS MODE IS SEQUENTIAL
               RECORD KEY IS ID-CONTATO
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
      *NÃO COPIE O TITULO COM O FD
       FD CONTATOS.
          COPY FD-CONTT.
       WORKING-STORAGE SECTION.
       01 WS-REGISTRO              PIC X(22) VALUE SPACES.
      *O FILLER REDEFINES preenche os espaços vazios
       01 FILLER REDEFINES WS-REGISTRO.
          03 WS-ID-CONTATO         PIC 9(02).
          03 WS-NM-CONTATO         PIC X(20).
       77 WS-FS                    PIC 99.
          88 FS-OK                 VALUE 0.
       77 WS-EOF                   PIC X.
          88 EOF-OK                VALUE 'S' FALSE 'N'.
       77 WS-EXIT                  PIC X.
          88 EXIT-OK               VALUE 'f' FALSE 'N'.
       77 WS-CONT                  PIC 9(0003) VALUE ZEROS.

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM           PIC X(20).

       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN-PROCEDURE.
            DISPLAY '***LISTAGEM DE CONTATOS***'
            SET EXIT-OK            TO FALSE
            PERFORM P3OO-LISTAR THRU P300-FIM
            PERFORM P900-FIM
           .
       P3OO-LISTAR.
           SET EOF-OK              TO FALSE
           SET FS-OK               TO TRUE
           SET WS-CONT             TO 0.

           OPEN INPUT CONTATOS

           IF FS-OK THEN
                   PERFORM UNTIL EOF-OK
                   READ CONTATOS INTO WS-REGISTRO
                       AT END
                           SET EOF-OK TO TRUE
                       NOT AT END
                           ADD 1      TO WS-CONT
                           DISPLAY 'REGISTRO:'
                                   WS-CONT
                                   ': '
                                   WS-ID-CONTATO
                                   ' - '
                                   WS-NM-CONTATO
                   END-READ
               END-PERFORM
           ELSE
              DISPLAY 'ERRO AO ABRIR ARQUIVO DE CONTATOS'
              DISPLAY 'FILE STATUS: ' WS-FS
           END-IF


           CLOSE CONTATOS

           .
       P300-FIM.
       P900-FIM .
            GOBACK.
       END PROGRAM MODULO-LEITURA.
