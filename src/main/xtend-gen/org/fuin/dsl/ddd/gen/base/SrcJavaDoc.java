package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;

/**
 * Creates the JavaDoc source code.
 */
@SuppressWarnings("all")
public class SrcJavaDoc implements CodeSnippet {
  private final String text;
  
  /**
   * Constructor with doc.
   * 
   * @param doc Doc including comment characters.
   */
  public SrcJavaDoc(final String doc) {
    String _text = StringExtensions.text(doc);
    this.text = _text;
  }
  
  /**
   * Constructor with constructor.
   * 
   * @param method Constructor with doc.
   */
  public SrcJavaDoc(final Constructor constructor) {
    this(constructor.getDoc());
  }
  
  /**
   * Constructor with method.
   * 
   * @param method Method with doc.
   */
  public SrcJavaDoc(final Method method) {
    this(method.getDoc());
  }
  
  /**
   * Constructor with internal type.
   * 
   * @param internalType Type with doc.
   */
  public SrcJavaDoc(final InternalType internalType) {
    this(internalType.getDoc());
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.append(this.text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    return _builder.toString();
  }
}
