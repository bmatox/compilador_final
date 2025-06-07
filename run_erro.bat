@echo off

REM Script para executar exemplos com erros léxicos e sintáticos

REM Define o diretorio do script como diretorio de trabalho
cd /d %~dp0

REM --- Execucao dos Testes de Erro ---
echo Executando Teste do Analisador Lexico com erro_lexico.txt...
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorLexico erro_lexico.txt
echo Teste Lexico com erro concluido.
echo.

echo Executando Teste do Analisador Sintatico com erro_sintatico.txt...
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorSintatico erro_sintatico.txt
echo Teste Sintatico com erro concluido.
echo.

echo Processo de teste de erros completo!
pause


