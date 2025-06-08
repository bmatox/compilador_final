# Compilador Básico Front-end (JFlex + JCup)

Este projeto implementa um front-end básico de compilador, incluindo um analisador léxico (Scanner) com JFlex e um analisador sintático (Parser) com JCup, integrados para processar um código-fonte de exemplo.

## Estrutura do Projeto

```
/compilador_project
├── analisador_lexico.flex    # Especificação do Scanner JFlex
├── analisador_sintatico.cup  # Especificação do Parser JCup
├── compilador/               # Diretório com código-fonte Java
│   ├── Scanner.java          # Classe Scanner gerada pelo JFlex
│   ├── parser.java           # Classe Parser gerada pelo JCup
│   ├── sym.java              # Classe de Símbolos gerada pelo JCup
│   ├── TesteAnalisadorLexico.java # Script para testar o Scanner
│   ├── TesteAnalisadorSintatico.java # Script para testar o Parser (e integração)
│   └── Compilador.java       # Programa principal para demonstrar a integração
├── lib/                      # Bibliotecas JFlex e JCup
│   ├── java-cup-11b-runtime.jar
│   ├── java-cup-11b.jar
│   └── jflex-full-1.9.1.jar
├── exemplo_lexico.txt        # Arquivo de exemplo para teste léxico
├── input.txt                 # Arquivo de exemplo para teste de integração
├── erro_lexico.txt           # Arquivo de exemplo para teste de erro léxico
├── erro_sintatico.txt        # Arquivo de exemplo para teste de erro sintático
├── run_compilador.bat        # Script para automatizar compilação e execução no Windows
├── run_erro.bat              # Script para automatizar execução de testes de erro no Windows
└── README.md                 # Este arquivo
```

## Pré-requisitos

- Java Development Kit (JDK) instalado (versão 11 ou superior recomendada).

## Execução Automatizada (Windows)

O projeto inclui um arquivo batch `run_compilador.bat` que automatiza todo o processo de compilação e execução no Windows. Este script realiza as seguintes operações:

1. Limpa arquivos gerados anteriormente
2. Gera o analisador léxico (Scanner) com JFlex
3. Gera o analisador sintático (Parser) com JCup
4. Move os arquivos gerados para o diretório correto
5. Compila todos os arquivos Java
6. Executa o teste do analisador léxico
7. Executa o teste do analisador sintático
8. Executa a solução integrada (Compilador)

### Como executar o script no Windows:

1. Abra o Visual Studio Code (VS Code)
2. Abra o diretório do projeto
3. Abra um terminal PowerShell no VS Code (Terminal > New Terminal)
4. Execute o comando:
   ```
   .\run_compilador.bat
   ```

O script exibirá mensagens detalhadas sobre cada etapa do processo e pausará ao final para que você possa revisar os resultados.

## Compilação e Execução Manual

Se preferir executar os comandos manualmente ou estiver em um ambiente Linux/Mac, siga as instruções abaixo. Todos os comandos devem ser executados a partir do diretório raiz do projeto.

### 1. Limpeza (Opcional)

Remova arquivos gerados anteriormente:

```bash
# Linux/Mac
rm -f Scanner.java parser.java sym.java
rm -f compilador/*.class compilador/Scanner.java compilador/parser.java compilador/sym.java

# Windows (PowerShell)
if (Test-Path Scanner.java) { Remove-Item Scanner.java }
if (Test-Path parser.java) { Remove-Item parser.java }
if (Test-Path sym.java) { Remove-Item sym.java }
Remove-Item compilador/*.class -ErrorAction SilentlyContinue
Remove-Item compilador/Scanner.java -ErrorAction SilentlyContinue
Remove-Item compilador/parser.java -ErrorAction SilentlyContinue
Remove-Item compilador/sym.java -ErrorAction SilentlyContinue
```

### 2. Gerar Analisador Léxico (Scanner)

Este passo gera o arquivo `Scanner.java` a partir da especificação `analisador_lexico.flex`.

```bash
# Linux/Mac
java -jar lib/jflex-full-1.9.1.jar analisador_lexico.flex

# Windows
java -jar lib\jflex-full-1.9.1.jar analisador_lexico.flex
```

### 3. Gerar Analisador Sintático (Parser)

Este passo gera os arquivos `parser.java` e `sym.java` a partir da especificação `analisador_sintatico.cup`.

```bash
# Linux/Mac
java -jar lib/java-cup-11b.jar -parser parser -symbols sym analisador_sintatico.cup

# Windows
java -jar lib\java-cup-11b.jar -parser parser -symbols sym analisador_sintatico.cup
```

### 4. Organizar Arquivos Gerados

Mova os arquivos Java gerados para o diretório `compilador/`.

```bash
# Linux/Mac
mv Scanner.java parser.java sym.java compilador/

# Windows
move Scanner.java compilador\
move parser.java compilador\
move sym.java compilador\
```

### 5. Compilar todo o Código Java

Compile todas as classes Java (Scanner, Parser, Símbolos e Testes/Compilador).

```bash
# Linux/Mac
javac -cp ".:lib/java-cup-11b-runtime.jar" compilador/*.java

# Windows
javac -cp ".;lib\java-cup-11b-runtime.jar" compilador\*.java
```

### 6. Executar Teste do Analisador Léxico

Execute o teste léxico usando o arquivo `exemplo_lexico.txt`.

```bash
# Linux/Mac
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.TesteAnalisadorLexico exemplo_lexico.txt

# Windows
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorLexico exemplo_lexico.txt
```

Este teste mostrará todos os tokens identificados pelo analisador léxico no arquivo de entrada.

### 7. Executar Teste do Analisador Sintático (e Integração Scanner-Parser)

Execute o teste sintático, que implicitamente testa a integração, usando o arquivo `exemplo_lexico.txt`.

```bash
# Linux/Mac
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.TesteAnalisadorSintatico exemplo_lexico.txt

# Windows
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.TesteAnalisadorSintatico exemplo_lexico.txt
```

Este teste verifica se o código-fonte está sintaticamente correto e mostra mensagens de reconhecimento de regras gramaticais.

### 8. Executar a Solução Integrada (Demonstração)

Execute o programa principal `Compilador.java` que demonstra a análise léxica e sintática integrada usando o arquivo `input.txt`.

```bash
# Linux/Mac
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.Compilador input.txt

# Windows
java -cp ".;lib\java-cup-11b-runtime.jar" compilador.Compilador input.txt
```

Esta demonstração processa um programa completo, mostrando o processo de compilação front-end em ação.

## Saída Esperada

Durante a execução, você verá:

1. **No teste léxico**: Lista de todos os tokens identificados com seus tipos, valores (quando aplicável) e posições no código.
2. **No teste sintático**: Mensagens de reconhecimento de regras gramaticais (como declarações de variáveis, funções, etc.).
3. **Na solução integrada**: Mensagens detalhadas sobre o processo de compilação, incluindo análise léxica e sintática.

## Observações

- A árvore sintática não está sendo explicitamente construída ou impressa nesta versão do projeto, apenas mensagens de reconhecimento de regras e erros sintáticos.
- Os separadores de caminho e o separador de classpath variam entre sistemas operacionais:
  - Linux/Mac: `/` para caminhos e `:` para classpath
  - Windows: `\` para caminhos e `;` para classpath
  
## Teste de Casos de Erro (Léxico e Sintático)

Para demonstrar como o compilador lida com entradas inválidas, foram criados dois arquivos de exemplo com erros intencionais:

- `erro_lexico.txt`: Contém um caractere ilegal (`#`) que o analisador léxico não consegue reconhecer.
- `erro_sintatico.txt`: Contém um erro de sintaxe (ponto e vírgula ausente) que o analisador sintático deve identificar.

### Execução Automatizada dos Testes de Erro (Windows)

Um novo script batch, `run_erro.bat`, foi criado para automatizar a execução desses testes de erro no Windows. Este script executa:

1.  O `TesteAnalisadorLexico.java` com `erro_lexico.txt`.
2.  O `TesteAnalisadorSintatico.java` com `erro_sintatico.txt`.

### Como executar o script no Windows:

1. Abra o Visual Studio Code (VS Code)
2. Abra o diretório do projeto
3. Abra um terminal PowerShell no VS Code (Terminal > New Terminal)
4. Execute o comando:
   ```
   .\run_erro.bat
   ```

O script exibirá as mensagens de erro geradas pelo analisador léxico e sintático, demonstrando a capacidade do compilador de identificar e reportar problemas na entrada.

## Entregáveis desse projeto (trecho usável pelo professor Ronaldo da cadeira de ATC - Unifor)

- Arquivo de especificação JFlex (`analisador_lexico.flex`) e a classe `Scanner.java` gerada.
- Arquivo de especificação JCup (`analisador_sintatico.cup`) e as classes `parser.java` e `sym.java` geradas.
- Scripts de teste (`TesteAnalisadorLexico.java`, `TesteAnalisadorSintatico.java`) e demonstração de integração (`Compilador.java`).
- Código-fonte de entrada (`input.txt`, `exemplo_lexico.txt`).
- Script de automação para Windows (`run_compilador.bat`).
- Arquivos de exemplo com erros (`erro_lexico.txt`, `erro_sintatico.txt`).
- Script de automação para testes de erro (`run_erro.bat`).
- Este arquivo `README.md`.


