package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for assigning a parameter to an instance variable.
 */
@SuppressWarnings("all")
public class SrcParamAssignment implements CodeSnippet {
  private final Variable variable;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param variable Variable.
   */
  public SrcParamAssignment(final CodeSnippetContext ctx, final Variable variable) {
    this.variable = variable;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("this.");
    String _name = this.variable.getName();
    _builder.append(_name, "");
    _builder.append(" = ");
    String _name_1 = this.variable.getName();
    _builder.append(_name_1, "");
    _builder.append(";");
    return _builder.toString();
  }
}
