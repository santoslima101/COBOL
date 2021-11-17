      ******************************************************************
      * Author:Santos Lima
      * Date:16/11/2021
      * Purpose:Excluir Contatos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MODULO-EXCLUIR.

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
       77 WS-CONFIRM               PIC X VALUE SPACES.

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM           PIC X(20).

       PROCEDURE DIVISION USING LK-COM-AREA.

       MAIN-PROCEDURE.
            DISPLAY '***EXCLUIR DE CONTATOS***'
            SET EXIT-OK            TO FALSE
            PERFORM P3OO-EXCLUIR THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
           .
       P3OO-EXCLUIR.
           SET EOF-OK              TO FALSE
           SET FS-OK               TO TRUE

           MOVE SPACES             TO WS-CONFIRM

           OPEN I-O CONTATOS

           IF FS-OK THEN
               DISPLAY 'Informe o numero de identificacao do contato:'
               ACCEPT ID-CONTATO

               READ CONTATOS INTO WS-REGISTRO
                       KEY IS ID-CONTATO
                       INVALID KEY
                          DISPLAY 'CONTATO NAO CADASTRADO!'
                       NOT INVALID KEY
                          DISPLAY  'Nome Atual: ' WS-NM-CONTATO
                          DISPLAY 'Tem certeza que deseja excluir?'
                                  'Tecle <S> para prosseguir.'
                                 'Tecle qualquer tecla para nao excluir'
                          ACCEPT WS-CONFIRM
                          IF WS-CONFIRM EQUAL 'S' THEN
                               DELETE CONTATOS RECORD
                               DISPLAY 'Contato excluido com sucesso!'
                          ELSE
                              DISPLAY 'Exclusao negada.'
                          END-IF

               END-READ
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
       END PROGRAM MODULO-EXCLUIR.
