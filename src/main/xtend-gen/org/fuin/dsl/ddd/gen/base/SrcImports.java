package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;

/**
 * Creates the import statements source code.
 */
@SuppressWarnings("all")
public class SrcImports implements CodeSnippet {
  private final List<String> imports;
  
  public SrcImports(final String currentPkg, final Set<String> importSet) {
    ArrayList<String> _arrayList = new ArrayList<String>();
    this.imports = _arrayList;
    for (final String imp : importSet) {
      boolean _and = false;
      boolean _and_1 = false;
      boolean _javaLang = this.javaLang(imp);
      boolean _not = (!_javaLang);
      if (!_not) {
        _and_1 = false;
      } else {
        String _trim = imp.trim();
        int _length = _trim.length();
        boolean _greaterThan = (_length > 0);
        _and_1 = _greaterThan;
      }
      if (!_and_1) {
        _and = false;
      } else {
        String _onlyPackage = StringExtensions.onlyPackage(imp);
        boolean _equals = currentPkg.equals(_onlyPackage);
        boolean _not_1 = (!_equals);
        _and = _not_1;
      }
      if (_and) {
        this.imports.add(imp);
      }
    }
    Collections.<String>sort(this.imports);
  }
  
  public boolean javaLang(final String imp) {
    boolean _startsWith = imp.startsWith("java.lang.");
    boolean _not = (!_startsWith);
    if (_not) {
      return false;
    }
    final int p = imp.indexOf(".", 10);
    if ((p == (-1))) {
      return true;
    }
    return false;
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
