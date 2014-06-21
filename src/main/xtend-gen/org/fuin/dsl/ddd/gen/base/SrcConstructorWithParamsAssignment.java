package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.ConstructorData;
import org.fuin.dsl.ddd.gen.base.SrcConstructorSignature;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single constructor. In the constructor the
 * parameters will be assigned to variables with the same name.
 */
@SuppressWarnings("all")
public class SrcConstructorWithParamsAssignment implements CodeSnippet {
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
  public SrcConstructorWithParamsAssignment(final CodeSnippetContext ctx, final String modifiers, final String typeName, final Constructor constructor) {
    this(ctx, new ConstructorData(modifiers, typeName, constructor));
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
  public SrcConstructorWithParamsAssignment(final CodeSnippetContext ctx, final ConstructorData constructorData) {
    this.ctx = ctx;
    this.constructorData = constructorData;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    String _doc = this.constructorData.getDoc();
    List<Variable> _variables = this.constructorData.getVariables();
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _exceptions = this.constructorData.getExceptions();
    SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(this.ctx, _doc, _variables, _exceptions);
    _builder.append(_srcMethodJavaDoc, "");
    _builder.newLineIfNotEmpty();
    SrcConstructorSignature _srcConstructorSignature = new SrcConstructorSignature(this.ctx, this.constructorData);
    _builder.append(_srcConstructorSignature, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    List<Variable> _variables_1 = this.constructorData.getVariables();
    SrcParamsAssignment _srcParamsAssignment = new SrcParamsAssignment(this.ctx, _variables_1);
    _builder.append(_srcParamsAssignment, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
}
