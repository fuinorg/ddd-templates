package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.LiteralExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a validation annotation.
 */
@SuppressWarnings("all")
public class SrcValidationAnnotation implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private Constraint constraint;
  
  private List<Variable> vars;
  
  private List<Literal> params;
  
  public SrcValidationAnnotation(final CodeSnippetContext ctx, final ConstraintCall cc) {
    this.ctx = ctx;
    Constraint _constraint = cc.getConstraint();
    this.constraint = _constraint;
    EList<Variable> _variables = this.constraint.getVariables();
    this.vars = _variables;
    EList<Literal> _params = cc.getParams();
    this.params = _params;
    String _uniqueName = AbstractElementExtensions.uniqueName(this.constraint);
    ctx.requiresReference(_uniqueName);
    boolean _notEquals = (!Objects.equal(this.vars, null));
    if (_notEquals) {
      for (final Variable v : this.vars) {
        Type _type = v.getType();
        String _uniqueName_1 = AbstractElementExtensions.uniqueName(_type);
        ctx.requiresReference(_uniqueName_1);
      }
    }
  }
  
  public String toString() {
    int _size = this.vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("@");
      String _name = this.constraint.getName();
      _builder.append(_name, "");
      return _builder.toString();
    } else {
      int _size_1 = this.vars.size();
      boolean _equals_1 = (_size_1 == 1);
      if (_equals_1) {
        StringConcatenation _builder_1 = new StringConcatenation();
        _builder_1.append("@");
        String _name_1 = this.constraint.getName();
        _builder_1.append(_name_1, "");
        _builder_1.append("(");
        Literal _last = IterableExtensions.<Literal>last(this.params);
        String _str = LiteralExtensions.str(_last);
        _builder_1.append(_str, "");
        _builder_1.append(")");
        return _builder_1.toString();
      } else {
        int _size_2 = this.vars.size();
        boolean _greaterThan = (_size_2 > 1);
        if (_greaterThan) {
          List<String> list = new ArrayList<String>();
          int i = 0;
          boolean _dowhile = false;
          do {
            {
              Variable _get = this.vars.get(i);
              String name = _get.getName();
              Literal _get_1 = this.params.get(i);
              String value = LiteralExtensions.str(_get_1);
              list.add(((name + " = ") + value));
              i = (i + 1);
            }
            int _size_3 = this.vars.size();
            boolean _lessThan = (i < _size_3);
            _dowhile = _lessThan;
          } while(_dowhile);
          StringConcatenation _builder_2 = new StringConcatenation();
          _builder_2.append("@");
          String _name_2 = this.constraint.getName();
          _builder_2.append(_name_2, "");
          _builder_2.append("(");
          {
            boolean _hasElements = false;
            for(final String str : list) {
              if (!_hasElements) {
                _hasElements = true;
              } else {
                _builder_2.appendImmediate(", ", "");
              }
              _builder_2.append(str, "");
            }
          }
          _builder_2.append(")");
          return _builder_2.toString();
        }
      }
    }
    return null;
  }
}
