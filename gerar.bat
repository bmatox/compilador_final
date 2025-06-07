@echo off
setlocal

REM === Definir diretório do script como diretório de trabalho ===
cd /d %~dp0

REM === Definir classpath com todas as bibliotecas necessárias ===
set LIB_DIR=lib
set CLASSPATH=.;%LIB_DIR%\java-cup-11b.jar;%LIB_DIR%\java-cup-11b-runtime.jar

REM === Limpeza ===
echo Limpando arquivos gerados anteriormente...
IF EXIST Scanner.java DEL Scanner.java
IF EXIST parser.java DEL parser.java
IF EXIST sym.java DEL sym.java
IF EXIST compilador\*.class DEL /Q compilador\*.class
IF EXIST compilador\Scanner.java DEL compilador\Scanner.java
IF EXIST compilador\parser.java DEL compilador\parser.java
IF EXIST compilador\sym.java DEL compilador\sym.java
echo Limpeza concluída.
echo.

REM === Geração do Analisador Léxico com JFlex ===
echo Gerando Analisador Léxico (Scanner.java)...
java -jar %LIB_DIR%\jflex-full-1.9.1.jar analisador_lexico.flex
IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao gerar Scanner com JFlex.
    goto :erro
)
echo Scanner gerado com sucesso.
echo.

REM === Geração do Analisador Sintático com JCup ===
echo Gerando Analisador Sintático (parser.java, sym.java)...
java -jar %LIB_DIR%\java-cup-11b.jar -parser parser -symbols sym analisador_sintatico.cup
IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha ao gerar Parser com JCup.
    goto :erro
)
echo Parser gerado com sucesso.
echo.

REM === Organização dos arquivos gerados ===
echo Movendo arquivos gerados para a pasta 'compilador'...
IF EXIST Scanner.java move /Y Scanner.java compilador\
IF EXIST parser.java move /Y parser.java compilador\
IF EXIST sym.java move /Y sym.java compilador\
echo Arquivos movidos.
echo.

REM === Compilação dos arquivos Java ===
echo Compilando código Java...
javac -cp "%CLASSPATH%" compilador\*.java compilador\ast\*.java
IF %ERRORLEVEL% NEQ 0 (
    echo [ERRO] Falha na compilação do código Java.
    goto :erro
)
echo Compilação concluída com sucesso.
echo.

REM === Execução dos Testes ===
echo Executando Teste do Analisador Léxico...
java -cp "%CLASSPATH%" compilador.TesteAnalisadorLexico exemplo_lexico.txt
echo Teste Léxico concluído.
echo.

echo Executando Teste do Analisador Sintático (Integração)...
java -cp "%CLASSPATH%" compilador.TesteAnalisadorSintatico exemplo_lexico.txt
echo Teste Sintático concluído.
echo.

REM === Execução Final da Solução Integrada ===
echo Executando Solução Integrada (Compilador)...
java -cp "%CLASSPATH%" compilador.Compilador input.txt
echo Execução Integrada concluída.
echo.

echo ✅ Processo completo com sucesso!
pause
exit /b

:erro
echo.
echo ❌ O processo foi interrompido devido a um erro.
pause
exit /b
@echo off
