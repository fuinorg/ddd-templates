package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a JAXB root element annotation.
 */
@SuppressWarnings("all")
public class SrcXmlRootElement implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String name;
  
  /**
   * Constructor with name.
   * 
   * @param ctx Context.
   * @param name Type name.
   */
  public SrcXmlRootElement(final CodeSnippetContext ctx, final String name) {
    this.ctx = ctx;
    this.name = name;
    ctx.requiresImport("javax.xml.bind.annotation.XmlRootElement");
  }
  
  /**
   * Constructor with value object.
   * 
   * @param ctx Context.
   * @param vo Value object.
   */
  public SrcXmlRootElement(final CodeSnippetContext ctx, final ValueObject vo) {
    this(ctx, vo.getName());
  }
  
  /**
   * Constructor with event.
   * 
   * @param ctx Context.
   * @param event Event.
   */
  public SrcXmlRootElement(final CodeSnippetContext ctx, final Event event) {
    this(ctx, event.getName());
  }
  
  /**
   * Constructor with element.
   * 
   * @param ctx Context.
   * @param el Element.
   */
  public SrcXmlRootElement(final CodeSnippetContext ctx, final AbstractElement el) {
    this(ctx, el.getName());
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlRootElement(name = \"");
    String _xmlName = StringExtensions.toXmlName(this.name);
    _builder.append(_xmlName, "");
    _builder.append("\")");
    return _builder.toString();
  }
}
