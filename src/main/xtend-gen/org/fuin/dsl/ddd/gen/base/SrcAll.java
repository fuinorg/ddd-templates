package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.fuin.srcgen4j.core.emf.CodeSnippet;

/**
 * Creates source code for copyright, package, imports and the class.
 */
@SuppressWarnings("all")
public class SrcAll implements CodeSnippet {
  private final String copyrightHeader;
  
  private final String pkg;
  
  private final Set<String> imports;
  
  private final String src;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param copyrightHeader Copyright header.
   * @param pkg Package.
   * @param imports Imports.
   * @param src Class source code.
   */
  public SrcAll(final String copyrightHeader, final String pkg, final Set<String> imports, final String src) {
    this.copyrightHeader = copyrightHeader;
    this.pkg = pkg;
    this.imports = imports;
    this.src = src;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append(this.copyrightHeader, "");
    _builder.append(" ");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    _builder.append(this.pkg, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    SrcImports _srcImports = new SrcImports(this.pkg, this.imports);
    _builder.append(_srcImports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append(this.src, "");
    _builder.newLineIfNotEmpty();
    return _builder.toString();
  }
}
