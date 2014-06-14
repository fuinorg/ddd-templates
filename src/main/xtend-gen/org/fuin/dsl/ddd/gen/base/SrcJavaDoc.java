package org.fuin.dsl.ddd.gen.base;

import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;

/**
 * Creates the JavaDoc source code.
 */
@SuppressWarnings("all")
public class SrcJavaDoc implements CodeSnippet {
  private final String text;
  
  public SrcJavaDoc(final InternalType internalType) {
    String _doc = internalType.getDoc();
    String _text = StringExtensions.text(_doc);
    this.text = _text;
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
