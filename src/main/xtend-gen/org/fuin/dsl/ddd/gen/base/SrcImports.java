package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;

/**
 * Creates the import statements source code.
 */
@SuppressWarnings("all")
public class SrcImports implements CodeSnippet {
  private final Set<String> imports;
  
  public SrcImports(final Set<String> imports) {
    this.imports = imports;
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.imports, null);
      if (_equals) {
        _or = true;
      } else {
        int _length = ((Object[])Conversions.unwrapArray(this.imports, Object.class)).length;
        boolean _equals_1 = (_length == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final String imp : this.imports) {
          _builder.append("import ");
          _builder.append(imp, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
