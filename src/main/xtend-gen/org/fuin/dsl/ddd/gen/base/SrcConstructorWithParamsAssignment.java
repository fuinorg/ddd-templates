package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcConstructorSignature;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single constructor. In the constructor the
 * parameters will be assigned to variables with the same name.
 */
@SuppressWarnings("all")
public class SrcConstructorWithParamsAssignment implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String doc;
  
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
  public SrcConstructorWithParamsAssignment(final CodeSnippetContext ctx, final String modifiers, final String typeName, final Constructor constructor) {
    this(ctx, constructor.getDoc(), modifiers, typeName, constructor.getVariables(), ConstructorExtensions.allExceptions(constructor));
  }
  
  /**
   * Constructor with variables and exceptions.
   * 
   * @param ctx Context.
   * @param ctx Documentation for the constructor.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public SrcConstructorWithParamsAssignment(final CodeSnippetContext ctx, final String doc, final String modifiers, final String typeName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.ctx = ctx;
    this.doc = doc;
    this.modifiers = modifiers;
    this.typeName = typeName;
    this.variables = variables;
    this.exceptions = exceptions;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(this.ctx, this.doc, this.variables, this.exceptions);
    _builder.append(_srcMethodJavaDoc, "");
    _builder.newLineIfNotEmpty();
    SrcConstructorSignature _srcConstructorSignature = new SrcConstructorSignature(this.ctx, this.modifiers, this.typeName, this.variables, this.exceptions);
    _builder.append(_srcConstructorSignature, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    SrcParamsAssignment _srcParamsAssignment = new SrcParamsAssignment(this.ctx, this.variables);
    _builder.append(_srcParamsAssignment, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
}
