import java.io.*;

public class Main {
    public static void main(String[] args) {
        String inputPath = (args.length > 0) ? args[0] : "input_4.txt";
        try (Reader r = new BufferedReader(new FileReader(inputPath))) {
            SymbolTable symtab = new SymbolTable();
            Lexer lexer = new Lexer(r, symtab);

            while (true) {
                Token t = lexer.yylex();
                if (t == null) break;

                switch (t.type) {
                    case OPERATOR:
                        System.out.println("operator: " + t.lexeme);
                        break;
                    case BRACKET:
                        System.out.println("bracket: " + t.lexeme);
                        break;
                    case SEMICOLON:
                        System.out.println("semicolon: " + t.lexeme);
                        break;
                    case KEYWORD:
                        System.out.println("keyword: " + t.lexeme);
                        break;
                    case INTEGER:
                        System.out.println("integer: " + t.lexeme);
                        break;
                    case STRING:
                        System.out.println("string:" + t.lexeme);
                        break;
                    case IDENTIFIER:
                        if (t.isNewIdentifier) System.out.println("new identifier: " + t.lexeme);
                        else System.out.println("identifier \"" + t.lexeme + "\" already in symbol table");
                        break;
                    case ERROR:
                        System.out.println("error: " + t.lexeme + " at " + t.line + ":" + t.column);
                        return;
                }
            }
        } catch (FileNotFoundException e) {
            System.out.println("error: input file not found -> " + inputPath);
        } catch (IOException e) {
            System.out.println("error: I/O failure -> " + e.getMessage());
        }
    }
}
