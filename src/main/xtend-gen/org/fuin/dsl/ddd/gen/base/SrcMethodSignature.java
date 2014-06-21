package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.extensions.MethodExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single method.
 */
@SuppressWarnings("all")
public class SrcMethodSignature implements CodeSnippet {
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
  public SrcMethodSignature(final CodeSnippetContext ctx, final String modifiers, final boolean makeAbstract, final Method method) {
    this.ctx = ctx;
    this.modifiers = modifiers;
    this.makeAbstract = makeAbstract;
    this.method = method;
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append(this.modifiers, "");
    _builder.append(" ");
    {
      if (this.makeAbstract) {
        _builder.append("abstract ");
      }
    }
    _builder.append("void ");
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
    return _builder.toString();
  }
}
