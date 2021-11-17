      ******************************************************************
      * Author:Santos
      * Date:17/11/2021
      * Purpose:Fazer um menu chamador de módulos
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENU-CHAMADOR.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 WS-COM-AREA.
          03 WS-MENSAGEM             PIC X(20).
       77 WS-OPCAO                   PIC X.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

            DISPLAY '1-Para cadastrar'
            DISPLAY '2-Para mostrar os dados do Arquivo'
            DISPLAY '3-Consultar cadastro'
            DISPLAY '4-Alterar cadastro'
            DISPLAY '5-Exclusao de cadastro'

            MOVE SPACES            TO WS-OPCAO
            DISPLAY 'Informe uma opcao: '
            ACCEPT WS-OPCAO

            EVALUATE WS-OPCAO
               WHEN 1
                 CALL 'D:\Codigos Cobol\bin\Modulo\bin\MODULO-CADASTRAL'
                                                     USING WS-COM-AREA

               WHEN 2
                 CALL 'D:\Codigos Cobol\bin\Modulo\bin\MODULO-LEITURA'
                                                     USING WS-COM-AREA

               WHEN 3
                 CALL 'D:\Codigos Cobol\bin\Modulo\bin\MODULO-CONSULTAR'
                                                     USING WS-COM-AREA

               WHEN 4
                 CALL 'D:\Codigos Cobol\bin\Modulo\bin\MODULO-ALT-CAD'
                                                     USING WS-COM-AREA

               WHEN 5
                 CALL 'D:\Codigos Cobol\bin\Modulo\bin\MODULO-EXCLUIR'
                                                     USING WS-COM-AREA
               WHEN OTHER
                   DISPLAY 'OPCAO INVALIDA!'
            END-EVALUATE
            .
            STOP RUN.
       END PROGRAM MENU-CHAMADOR.
