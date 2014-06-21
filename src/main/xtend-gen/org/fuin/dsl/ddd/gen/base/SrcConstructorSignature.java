package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.ConstructorData;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single constructor signature.
 */
@SuppressWarnings("all")
public class SrcConstructorSignature implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final ConstructorData constructorData;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param constructor Constructor to create the source for.
   */
  public SrcConstructorSignature(final CodeSnippetContext ctx, final String modifiers, final String typeName, final Constructor constructor) {
    this(ctx, new ConstructorData(modifiers, typeName, constructor));
  }
  
  /**
   * Constructor with variables and exceptions.
   * 
   * @param ctx Context.
   * @param constructorData Constructor data.
   */
  public SrcConstructorSignature(final CodeSnippetContext ctx, final ConstructorData constructorData) {
    this.ctx = ctx;
    this.constructorData = constructorData;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      List<String> _annotations = this.constructorData.getAnnotations();
      List<String> _nullSafe = CollectionExtensions.<String>nullSafe(_annotations);
      for(final String annotation : _nullSafe) {
        _builder.append(annotation, "");
        _builder.newLineIfNotEmpty();
      }
    }
    String _modifiers = this.constructorData.getModifiers();
    _builder.append(_modifiers, "");
    _builder.append(" ");
    String _name = this.constructorData.getName();
    _builder.append(_name, "");
    _builder.append("(");
    List<Variable> _variables = this.constructorData.getVariables();
    SrcParamsDecl _srcParamsDecl = new SrcParamsDecl(this.ctx, _variables);
    _builder.append(_srcParamsDecl, "");
    _builder.append(")");
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _exceptions = this.constructorData.getExceptions();
    SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(
      this.ctx, _exceptions);
    _builder.append(_srcThrowsExceptions, "");
    return _builder.toString();
  }
}
