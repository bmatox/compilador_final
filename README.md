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
├── todo.md                   # Checklist de desenvolvimento (referência)
└── README.md                 # Este arquivo
```

## Pré-requisitos

- Java Development Kit (JDK) instalado (versão 11 ou superior recomendada).

## Como Compilar e Executar

Todos os comandos devem ser executados a partir do diretório raiz do projeto (`/home/ubuntu/compilador_project`).

### 1. Gerar Analisador Léxico (Scanner)

Este passo gera o arquivo `Scanner.java` a partir da especificação `analisador_lexico.flex`.

```bash
java -jar lib/jflex-full-1.9.1.jar analisador_lexico.flex
```

### 2. Gerar Analisador Sintático (Parser)

Este passo gera os arquivos `parser.java` e `sym.java` a partir da especificação `analisador_sintatico.cup`.

```bash
java -jar lib/java-cup-11b.jar -parser parser -symbols sym analisador_sintatico.cup
```

### 3. Organizar Arquivos Gerados

Mova os arquivos Java gerados para o diretório `compilador/`.

```bash
mv Scanner.java parser.java sym.java compilador/
```

### 4. Compilar todo o Código Java

Compile todas as classes Java (Scanner, Parser, Símbolos e Testes/Compilador).

```bash
javac -cp ".:lib/java-cup-11b-runtime.jar" compilador/*.java
```

### 5. Executar Teste do Analisador Léxico

Execute o teste léxico usando o arquivo `exemplo_lexico.txt`.

```bash
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.TesteAnalisadorLexico exemplo_lexico.txt
```

### 6. Executar Teste do Analisador Sintático (e Integração Scanner-Parser)

Execute o teste sintático, que implicitamente testa a integração, usando o arquivo `exemplo_lexico.txt` (ou `input.txt`).

```bash
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.TesteAnalisadorSintatico exemplo_lexico.txt
```

### 7. Executar a Solução Integrada (Demonstração)

Execute o programa principal `Compilador.java` que demonstra a análise léxica e sintática integrada usando o arquivo `input.txt`.

```bash
java -cp ".:lib/java-cup-11b-runtime.jar" compilador.Compilador input.txt
```

## Entregáveis

- Arquivo de especificação JFlex (`analisador_lexico.flex`) e a classe `Scanner.java` gerada.
- Arquivo de especificação JCup (`analisador_sintatico.cup`) e as classes `parser.java` e `sym.java` geradas.
- Scripts de teste (`TesteAnalisadorLexico.java`, `TesteAnalisadorSintatico.java`) e demonstração de integração (`Compilador.java`).
- Código-fonte de entrada (`input.txt`, `exemplo_lexico.txt`).
- Este arquivo `README.md`.

