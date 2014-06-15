package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for "throws" clause.
 */
@SuppressWarnings("all")
public class SrcThrowsExceptions implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions;
  
  public SrcThrowsExceptions(final CodeSnippetContext ctx, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.ctx = ctx;
    this.exceptions = exceptions;
    boolean _notEquals = (!Objects.equal(exceptions, null));
    if (_notEquals) {
      for (final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception exception : exceptions) {
        String _uniqueName = AbstractElementExtensions.uniqueName(exception);
        ctx.requiresReference(_uniqueName);
      }
    }
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.exceptions, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = this.exceptions.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append(" ");
      _builder.append("throws ");
      {
        boolean _hasElements = false;
        for(final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception ex : this.exceptions) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", " ");
          }
          String _name = ex.getName();
          _builder.append(_name, " ");
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
