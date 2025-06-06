@echo off


REM Script para compilar e executar o projeto Compilador Front-end

REM Define o diretorio do script como diretorio de trabalho
cd /d %~dp0

REM --- Limpeza ---
echo Limpando arquivos gerados anteriormente...
IF EXIST Scanner.java DEL Scanner.java
IF EXIST parser.java DEL parser.java
IF EXIST sym.java DEL sym.java
IF EXIST compilador\*.class DEL /Q compilador\*.class
IF EXIST compilador\Scanner.java DEL compilador\Scanner.java
IF EXIST compilador\parser.java DEL compilador\parser.java
IF EXIST compilador\sym.java DEL compilador\sym.java
echo Limpeza concluida.
echo.

REM --- Geracao ---
echo Gerando Analisador Lexico (Scanner.java)...
java -jar lib/jflex-full-1.9.1.jar analisador_lexico.flex
IF %ERRORLEVEL% NEQ 0 (
    echo Erro ao gerar o Scanner!
    goto :eof
)
echo Scanner gerado.
echo.

echo Gerando Analisador Sintatico (parser.java, sym.java)...
java -jar lib/java-cup-11b.jar -parser parser -symbols sym analisador_sintatico.cup
IF %ERRORLEVEL% NEQ 0 (
    echo Erro ao gerar o Parser!
    goto :eof
)
echo Parser gerado.
echo.

REM --- Organizacao ---
echo Movendo arquivos gerados para a pasta 'compilador'...
move Scanner.java compilador\
move parser.java compilador\
move sym.java compilador\
echo Arquivos movidos.
echo.

REM --- Compilacao Java ---
echo Compilando codigo Java...
javac -cp ".;lib\java-cup-11b-runtime.jar" compilador\*.java
IF %ERRORLEVEL% NEQ 0 (
    echo Erro ao compilar o codigo Java!
    goto :eof
)
echo Compilacao Java concluida.
echo.

REM --- Execucao dos Testes ---
echo Executando Teste do Analisador Lexico...
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorLexico exemplo_lexico.txt
echo Teste Lexico concluido.
echo.

echo Executando Teste do Analisador Sintatico (Integracao)...
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorSintatico exemplo_lexico.txt
echo Teste Sintatico concluido.
echo.

REM --- Execucao da Solucao Integrada ---
echo Executando Solucao Integrada (Compilador)...
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.Compilador input.txt
echo Execucao Integrada concluida.
echo.

echo Processo completo!
pause

