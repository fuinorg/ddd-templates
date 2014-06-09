package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcGetter;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for one or more getters.
 */
@SuppressWarnings("all")
public class SrcGetters implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String visibility;
  
  private final List<Variable> variables;
  
  public SrcGetters(final CodeSnippetContext ctx, final String visibility, final List<Variable> variables) {
    this.ctx = ctx;
    this.visibility = visibility;
    this.variables = variables;
    for (final Variable variable : variables) {
      Type _type = variable.getType();
      String _uniqueName = AbstractElementExtensions.uniqueName(_type);
      ctx.requiresReference(_uniqueName);
    }
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable v : this.variables) {
        SrcGetter _srcGetter = new SrcGetter(this.ctx, this.visibility, v);
        String _string = _srcGetter.toString();
        _builder.append(_string, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder.toString();
  }
}
