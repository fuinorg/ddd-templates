package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcSetter;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for one or more setters.
 */
@SuppressWarnings("all")
public class SrcSetters implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final List<Variable> variables;
  
  public SrcSetters(final CodeSnippetContext ctx, final String visibility, final List<Variable> variables) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.variables = variables;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable variable : this.variables) {
        SrcSetter _srcSetter = new SrcSetter(this.ctx, this.visibility, variable);
        _builder.append(_srcSetter, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder.toString();
  }
}
