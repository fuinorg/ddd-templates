package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamDecl;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for zero or more parameter declarations.
 */
@SuppressWarnings("all")
public class SrcParamsDecl implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<Variable> variables;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param variables Variables.
   */
  public SrcParamsDecl(final CodeSnippetContext ctx, final List<Variable> variables) {
    this.ctx = ctx;
    this.variables = variables;
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.variables, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = this.variables.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        boolean _hasElements = false;
        for(final Variable variable : this.variables) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", "");
          }
          SrcParamDecl _srcParamDecl = new SrcParamDecl(this.ctx, variable);
          _builder.append(_srcParamDecl, "");
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
