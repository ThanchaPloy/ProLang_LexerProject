public class Token {
    public final TokenType type;
    public final String lexeme;
    public final boolean isNewIdentifier;
    public final int line;
    public final int column;

    public Token(TokenType type, String lexeme, boolean isNewIdentifier, int line, int column) {
        this.type = type;
        this.lexeme = lexeme;
        this.isNewIdentifier = isNewIdentifier;
        this.line = line;
        this.column = column;
    }
}
