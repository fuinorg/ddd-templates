package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single method.
 */
@SuppressWarnings("all")
public class SrcMethodSignature implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final MethodData methodData;
  
  private final String returnType;
  
  /**
   * Constructor with method.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
   * @param method Method to create the source for.
   */
  public SrcMethodSignature(final CodeSnippetContext ctx, final String modifiers, final boolean makeAbstract, final Method method) {
    this(ctx, new MethodData(modifiers, makeAbstract, method));
  }
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param methodData Method data.
   */
  public SrcMethodSignature(final CodeSnippetContext ctx, final MethodData methodData) {
    this.ctx = ctx;
    this.methodData = methodData;
    ReturnType _returnType = methodData.getReturnType();
    boolean _equals = Objects.equal(_returnType, null);
    if (_equals) {
      this.returnType = "void";
    } else {
      ReturnType _returnType_1 = methodData.getReturnType();
      Type _type = _returnType_1.getType();
      String _name = _type.getName();
      this.returnType = _name;
      ReturnType _returnType_2 = methodData.getReturnType();
      Type _type_1 = _returnType_2.getType();
      String _uniqueName = AbstractElementExtensions.uniqueName(_type_1);
      ctx.requiresReference(_uniqueName);
    }
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    {
      List<String> _annotations = this.methodData.getAnnotations();
      List<String> _nullSafe = CollectionExtensions.<String>nullSafe(_annotations);
      for(final String annotation : _nullSafe) {
        _builder.append(annotation, "");
        _builder.newLineIfNotEmpty();
      }
    }
    String _modifiers = this.methodData.getModifiers();
    _builder.append(_modifiers, "");
    _builder.append(" ");
    {
      boolean _isMakeAbstract = this.methodData.isMakeAbstract();
      if (_isMakeAbstract) {
        _builder.append("abstract ");
      }
    }
    _builder.append(this.returnType, "");
    _builder.append(" ");
    String _name = this.methodData.getName();
    _builder.append(_name, "");
    _builder.append("(");
    List<Variable> _variables = this.methodData.getVariables();
    SrcParamsDecl _srcParamsDecl = new SrcParamsDecl(this.ctx, _variables);
    _builder.append(_srcParamsDecl, "");
    _builder.append(")");
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _exceptions = this.methodData.getExceptions();
    SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(this.ctx, _exceptions);
    _builder.append(_srcThrowsExceptions, "");
    return _builder.toString();
  }
}
