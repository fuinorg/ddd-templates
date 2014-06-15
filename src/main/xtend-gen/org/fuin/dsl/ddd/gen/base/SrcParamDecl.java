package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcValidationAnnotation;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single parameter declaration.
 */
@SuppressWarnings("all")
public class SrcParamDecl implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final Variable variable;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param variable Variable.
   */
  public SrcParamDecl(final CodeSnippetContext ctx, final Variable variable) {
    this.ctx = ctx;
    this.variable = variable;
    String _nullable = variable.getNullable();
    boolean _equals = Objects.equal(_nullable, null);
    if (_equals) {
      ctx.requiresImport("javax.validation.constraints.NotNull");
    }
    String _multiplicity = variable.getMultiplicity();
    boolean _notEquals = (!Objects.equal(_multiplicity, null));
    if (_notEquals) {
      ctx.requiresImport("java.util.List");
    }
    Type _type = variable.getType();
    String _uniqueName = AbstractElementExtensions.uniqueName(_type);
    ctx.requiresReference(_uniqueName);
  }
  
  public String toString() {
    String _xifexpression = null;
    boolean _and = false;
    Invariants _invariants = this.variable.getInvariants();
    boolean _notEquals = (!Objects.equal(_invariants, null));
    if (!_notEquals) {
      _and = false;
    } else {
      Invariants _invariants_1 = this.variable.getInvariants();
      EList<ConstraintCall> _calls = _invariants_1.getCalls();
      List<ConstraintCall> _nullSafe = CollectionExtensions.<ConstraintCall>nullSafe(_calls);
      int _size = _nullSafe.size();
      boolean _greaterThan = (_size > 0);
      _and = _greaterThan;
    }
    if (_and) {
      StringConcatenation _builder = new StringConcatenation();
      {
        Invariants _invariants_2 = this.variable.getInvariants();
        EList<ConstraintCall> _calls_1 = _invariants_2.getCalls();
        boolean _hasElements = false;
        for(final ConstraintCall cc : _calls_1) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(" ", "");
          }
          SrcValidationAnnotation _srcValidationAnnotation = new SrcValidationAnnotation(this.ctx, cc);
          _builder.append(_srcValidationAnnotation, "");
        }
      }
      _builder.append(" ");
      {
        String _nullable = this.variable.getNullable();
        boolean _equals = Objects.equal(_nullable, null);
        if (_equals) {
          _builder.append("@NotNull ");
        }
      }
      _builder.append("final ");
      String _type = VariableExtensions.type(this.variable, this.ctx);
      _builder.append(_type, "");
      _builder.append(" ");
      String _name = this.variable.getName();
      _builder.append(_name, "");
      _xifexpression = _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      {
        String _nullable_1 = this.variable.getNullable();
        boolean _equals_1 = Objects.equal(_nullable_1, null);
        if (_equals_1) {
          _builder_1.append("@NotNull ");
        }
      }
      _builder_1.append("final ");
      String _type_1 = VariableExtensions.type(this.variable, this.ctx);
      _builder_1.append(_type_1, "");
      _builder_1.append(" ");
      String _name_1 = this.variable.getName();
      _builder_1.append(_name_1, "");
      _xifexpression = _builder_1.toString();
    }
    return _xifexpression;
  }
}
