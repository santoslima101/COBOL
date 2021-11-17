      ******************************************************************
      * Author:Santos Lima
      * Date:16/11/2021
      * Purpose:Cadastrar Contatos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MODULO-CADASTRAL.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT CONTATOS ASSIGN TO
               'D:\Codigos Cobol\bin\Modulo\bin\contatos.dat'
               ORGANISATION IS INDEXED
               ACCESS MODE IS RANDOM
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

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM           PIC X(20).

       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN-PROCEDURE.
            DISPLAY '***CADASTRO DE CONTATOS***'
            SET EXIT-OK            TO FALSE
            PERFORM P3OO-CADASTRA THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
           .
       P3OO-CADASTRA.
           SET EOF-OK              TO FALSE
           SET FS-OK               TO TRUE

           DISPLAY 'PARA REGISTRAR UM CONTATO,INFORME:'
           DISPLAY 'Um numero para a identificacao: '
           ACCEPT WS-ID-CONTATO
           DISPLAY 'Um nome para o contato:'
           ACCEPT WS-NM-CONTATO

           OPEN I-O CONTATOS
      *serve para detalhar falhas quando o arquivo de leitura não existe
           IF WS-FS EQUAL 35 THEN
               OPEN OUTPUT CONTATOS
           END-IF

           IF FS-OK THEN
               MOVE WS-ID-CONTATO          TO ID-CONTATO
               MOVE WS-NM-CONTATO          TO NM-CONTATO

               WRITE REG-CONTATOS
                       INVALID KEY
                          DISPLAY 'CONTATO JA CADASTRADO!'
                       NOT INVALID KEY
                          DISPLAY 'Contato gravado com sucesso!'
               END-WRITE
           ELSE
               DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS!'
               DISPLAY 'FILE STATUS:' WS-FS
           END-IF

           CLOSE CONTATOS

           DISPLAY
                 'TECLE:'
                 '<QUALQUER TECLA>para continuar,ou <f> para finalizar.'
           ACCEPT  WS-EXIT
           .
       P300-FIM.
       P900-FIM .
            GOBACK.
       END PROGRAM MODULO-CADASTRAL.
