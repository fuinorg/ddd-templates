package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a JAXB element annotation.
 */
@SuppressWarnings("all")
public class SrcXmlElement implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final Variable variable;
  
  public SrcXmlElement(final CodeSnippetContext ctx, final Variable variable) {
    this.ctx = ctx;
    this.variable = variable;
    ctx.requiresImport("javax.xml.bind.annotation.XmlElement");
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlElement(name = \"");
    String _name = this.variable.getName();
    String _xmlName = StringExtensions.toXmlName(_name);
    _builder.append(_xmlName, "");
    _builder.append("\")");
    return _builder.toString();
  }
}
