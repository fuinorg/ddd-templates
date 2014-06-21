package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single constructor signature.
 */
@SuppressWarnings("all")
public class SrcConstructorSignature implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String modifiers;
  
  private final String typeName;
  
  private final List<Variable> variables;
  
  private final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param constructor Constructor to create the source for.
   */
  public SrcConstructorSignature(final CodeSnippetContext ctx, final String modifiers, final String typeName, final Constructor constructor) {
    this(ctx, modifiers, typeName, constructor.getVariables(), ConstructorExtensions.allExceptions(constructor));
  }
  
  /**
   * Constructor with variables and exceptions.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public SrcConstructorSignature(final CodeSnippetContext ctx, final String modifiers, final String typeName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.ctx = ctx;
    this.modifiers = modifiers;
    this.typeName = typeName;
    this.variables = variables;
    this.exceptions = exceptions;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append(this.modifiers, "");
    _builder.append(" ");
    _builder.append(this.typeName, "");
    _builder.append("(");
    SrcParamsDecl _srcParamsDecl = new SrcParamsDecl(this.ctx, this.variables);
    _builder.append(_srcParamsDecl, "");
    _builder.append(")");
    SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(this.ctx, 
      this.exceptions);
    _builder.append(_srcThrowsExceptions, "");
    return _builder.toString();
  }
}
