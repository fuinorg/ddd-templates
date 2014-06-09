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
 * Creates source code for a single getter.
 */
@SuppressWarnings("all")
public class SrcGetter implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final Variable variable;
  
  public SrcGetter(final CodeSnippetContext ctx, final String visibility, final Variable variable) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.variable = variable;
    String _nullable = variable.getNullable();
    boolean _equals = Objects.equal(_nullable, null);
    if (_equals) {
      ctx.requiresImport("org.fuin.objects4j.common.NeverNull");
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
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns: ");
    String _superDoc = VariableExtensions.superDoc(this.variable);
    String _text = StringExtensions.text(_superDoc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Current value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(" ");
    {
      String _nullable = this.variable.getNullable();
      boolean _equals = Objects.equal(_nullable, null);
      if (_equals) {
        _builder.append("@NeverNull");
      }
    }
    _builder.newLineIfNotEmpty();
    _builder.append(this.visibility, "");
    _builder.append(" ");
    String _type = VariableExtensions.type(this.variable, this.ctx);
    _builder.append(_type, "");
    _builder.append(" get");
    String _name = this.variable.getName();
    String _firstUpper = org.eclipse.xtext.xbase.lib.StringExtensions.toFirstUpper(_name);
    _builder.append(_firstUpper, "");
    _builder.append("() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("return ");
    String _name_1 = this.variable.getName();
    _builder.append(_name_1, "\t");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
}
