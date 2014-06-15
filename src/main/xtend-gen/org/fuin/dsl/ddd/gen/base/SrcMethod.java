package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.extensions.MethodExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single method.
 */
@SuppressWarnings("all")
public class SrcMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String modifiers;
  
  private final boolean makeAbstract;
  
  private final Method method;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
   * @param method Method to create the source for.
   */
  public SrcMethod(final CodeSnippetContext ctx, final String modifiers, final boolean makeAbstract, final Method method) {
    this.ctx = ctx;
    this.modifiers = modifiers;
    this.makeAbstract = makeAbstract;
    this.method = method;
  }
  
  public String toString() {
    String _xifexpression = null;
    if (this.makeAbstract) {
      StringConcatenation _builder = new StringConcatenation();
      SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(this.ctx, this.method);
      _builder.append(_srcMethodJavaDoc, "");
      _builder.newLineIfNotEmpty();
      _builder.append(this.modifiers, "");
      _builder.append(" abstract void ");
      String _name = this.method.getName();
      _builder.append(_name, "");
      _builder.append("(");
      List<Variable> _allVariables = MethodExtensions.allVariables(this.method);
      SrcParamsDecl _srcParamsDecl = new SrcParamsDecl(this.ctx, _allVariables);
      _builder.append(_srcParamsDecl, "");
      _builder.append(")");
      List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _allExceptions = MethodExtensions.allExceptions(this.method);
      SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(this.ctx, _allExceptions);
      _builder.append(_srcThrowsExceptions, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _xifexpression = _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      SrcMethodJavaDoc _srcMethodJavaDoc_1 = new SrcMethodJavaDoc(this.ctx, this.method);
      _builder_1.append(_srcMethodJavaDoc_1, "");
      _builder_1.newLineIfNotEmpty();
      _builder_1.append(this.modifiers, "");
      _builder_1.append(" void ");
      String _name_1 = this.method.getName();
      _builder_1.append(_name_1, "");
      _builder_1.append("(");
      List<Variable> _allVariables_1 = MethodExtensions.allVariables(this.method);
      SrcParamsDecl _srcParamsDecl_1 = new SrcParamsDecl(this.ctx, _allVariables_1);
      _builder_1.append(_srcParamsDecl_1, "");
      _builder_1.append(")");
      List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _allExceptions_1 = MethodExtensions.allExceptions(this.method);
      SrcThrowsExceptions _srcThrowsExceptions_1 = new SrcThrowsExceptions(this.ctx, _allExceptions_1);
      _builder_1.append(_srcThrowsExceptions_1, "");
      _builder_1.append(" {");
      _builder_1.newLineIfNotEmpty();
      _builder_1.append("\t");
      _builder_1.append("// TODO Implement!");
      _builder_1.newLine();
      _builder_1.append("}");
      _builder_1.newLine();
      _xifexpression = _builder_1.toString();
    }
    return _xifexpression;
  }
}
