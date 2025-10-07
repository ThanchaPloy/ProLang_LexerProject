import java.util.*;

public class SymbolTable {
    private final Set<String> symbols = new LinkedHashSet<>();

    /** @return true if identifier was NEWLY added; false if already existed */
    public boolean add(String id) {
        return symbols.add(id);
    }

    public boolean contains(String id) {
        return symbols.contains(id);
    }

    public List<String> all() {
        return new ArrayList<>(symbols);
    }
}
