package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single setter.
 */
@SuppressWarnings("all")
public class SrcSetter implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final Variable variable;
  
  public SrcSetter(final CodeSnippetContext ctx, final String visibility, final Variable variable) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.variable = variable;
    ctx.requiresImport("javax.validation.constraints.NotNull");
    ctx.requiresImport("org.fuin.objects4j.common.Contract");
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
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Sets: ");
    String _doc = this.variable.getDoc();
    String _text = StringExtensions.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param ");
    String _name = this.variable.getName();
    _builder.append(_name, " ");
    _builder.append(" Value to set.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(this.visibility, "");
    _builder.append(" void set");
    String _name_1 = this.variable.getName();
    String _firstUpper = org.eclipse.xtext.xbase.lib.StringExtensions.toFirstUpper(_name_1);
    _builder.append(_firstUpper, "");
    _builder.append("(");
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
    String _name_2 = this.variable.getName();
    _builder.append(_name_2, "");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    {
      String _nullable_1 = this.variable.getNullable();
      boolean _equals_1 = Objects.equal(_nullable_1, null);
      if (_equals_1) {
        _builder.append("\t");
        _builder.append("Contract.requireArgNotNull(\"");
        String _name_3 = this.variable.getName();
        _builder.append(_name_3, "\t");
        _builder.append("\", ");
        String _name_4 = this.variable.getName();
        _builder.append(_name_4, "\t");
        _builder.append(");");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("\t");
    _builder.append("this.");
    String _name_5 = this.variable.getName();
    _builder.append(_name_5, "\t");
    _builder.append(" = ");
    String _name_6 = this.variable.getName();
    _builder.append(_name_6, "\t");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
}
