package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcValidationAnnotation;
import org.fuin.dsl.ddd.gen.base.SrcXmlAttributeOrElement;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single variable declaration.
 */
@SuppressWarnings("all")
public class SrcVarDecl implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final boolean xml;
  
  private final Variable variable;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param visibility Visibility for the variable.
   * @param xml Create XML annotation.
   * @param variable Variable.
   */
  public SrcVarDecl(final CodeSnippetContext ctx, final String visibility, final boolean xml, final Variable variable) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.xml = xml;
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
    Invariants _invariants = this.variable.getInvariants();
    boolean _notEquals = (!Objects.equal(_invariants, null));
    if (_notEquals) {
      StringConcatenation _builder = new StringConcatenation();
      {
        Invariants _invariants_1 = this.variable.getInvariants();
        EList<ConstraintCall> _calls = _invariants_1.getCalls();
        boolean _hasElements = false;
        for(final ConstraintCall cc : _calls) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(" ", "");
          }
          SrcValidationAnnotation _srcValidationAnnotation = new SrcValidationAnnotation(this.ctx, cc);
          _builder.append(_srcValidationAnnotation, "");
          _builder.newLineIfNotEmpty();
        }
      }
      {
        String _nullable = this.variable.getNullable();
        boolean _equals = Objects.equal(_nullable, null);
        if (_equals) {
          _builder.append("@NotNull");
          _builder.newLine();
        }
      }
      {
        if (this.xml) {
          SrcXmlAttributeOrElement _srcXmlAttributeOrElement = new SrcXmlAttributeOrElement(this.ctx, this.variable);
          _builder.append(_srcXmlAttributeOrElement, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append(this.visibility, "");
      _builder.append(" ");
      String _type = VariableExtensions.type(this.variable, this.ctx);
      _builder.append(_type, "");
      _builder.append(" ");
      String _name = this.variable.getName();
      _builder.append(_name, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _xifexpression = _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      {
        String _nullable_1 = this.variable.getNullable();
        boolean _equals_1 = Objects.equal(_nullable_1, null);
        if (_equals_1) {
          _builder_1.append("@NotNull");
          _builder_1.newLine();
        }
      }
      {
        if (this.xml) {
          SrcXmlAttributeOrElement _srcXmlAttributeOrElement_1 = new SrcXmlAttributeOrElement(this.ctx, this.variable);
          _builder_1.append(_srcXmlAttributeOrElement_1, "");
          _builder_1.newLineIfNotEmpty();
        }
      }
      _builder_1.append(this.visibility, "");
      _builder_1.append(" ");
      String _type_1 = VariableExtensions.type(this.variable, this.ctx);
      _builder_1.append(_type_1, "");
      _builder_1.append(" ");
      String _name_1 = this.variable.getName();
      _builder_1.append(_name_1, "");
      _builder_1.append(";");
      _builder_1.newLineIfNotEmpty();
      _xifexpression = _builder_1.toString();
    }
    return _xifexpression;
  }
}
