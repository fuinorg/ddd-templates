package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamAssignment;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for assigning parameters to instance variables.
 */
@SuppressWarnings("all")
public class SrcParamsAssignment implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<Variable> vars;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param vars Variables.
   */
  public SrcParamsAssignment(final CodeSnippetContext ctx, final List<Variable> vars) {
    this.ctx = ctx;
    this.vars = vars;
    boolean _and = false;
    boolean _notEquals = (!Objects.equal(vars, null));
    if (!_notEquals) {
      _and = false;
    } else {
      boolean _atLeastOneVarIsNotNullable = SrcParamsAssignment.atLeastOneVarIsNotNullable(vars);
      _and = _atLeastOneVarIsNotNullable;
    }
    if (_and) {
      ctx.requiresImport("org.fuin.objects4j.common.Contract");
    }
  }
  
  private static boolean atLeastOneVarIsNotNullable(final List<Variable> vars) {
    for (final Variable v : vars) {
      String _nullable = v.getNullable();
      boolean _equals = Objects.equal(_nullable, null);
      if (_equals) {
        return true;
      }
    }
    return false;
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.vars, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = this.vars.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final Variable v : this.vars) {
          {
            String _nullable = v.getNullable();
            boolean _equals_2 = Objects.equal(_nullable, null);
            if (_equals_2) {
              _builder.append("Contract.requireArgNotNull(\"");
              String _name = v.getName();
              _builder.append(_name, "");
              _builder.append("\", ");
              String _name_1 = v.getName();
              _builder.append(_name_1, "");
              _builder.append(");");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
      _builder.newLine();
      {
        for(final Variable v_1 : this.vars) {
          SrcParamAssignment _srcParamAssignment = new SrcParamAssignment(this.ctx, v_1);
          _builder.append(_srcParamAssignment, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
