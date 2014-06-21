package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcMethodSignature;
import org.fuin.dsl.ddd.gen.extensions.MethodExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a single method.
 */
@SuppressWarnings("all")
public class SrcMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final MethodData method;
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
   * @param method Method to create the source for.
   */
  public SrcMethod(final CodeSnippetContext ctx, final List<String> annotations, final String modifiers, final boolean makeAbstract, final Method method) {
    this(ctx, 
      new MethodData(method.getDoc(), annotations, modifiers, makeAbstract, null, 
        method.getName(), method.getVariables(), MethodExtensions.allExceptions(method)));
  }
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract TRUE for an abstract method or FALSE for a non-abstract method with "// TODO Implement!".
   * @param method Method to create the source for.
   */
  public SrcMethod(final CodeSnippetContext ctx, final MethodData method) {
    this.ctx = ctx;
    this.method = method;
  }
  
  public String toString() {
    String _xifexpression = null;
    boolean _isMakeAbstract = this.method.isMakeAbstract();
    if (_isMakeAbstract) {
      StringConcatenation _builder = new StringConcatenation();
      SrcMethodJavaDoc _srcMethodJavaDoc = new SrcMethodJavaDoc(this.ctx, this.method);
      _builder.append(_srcMethodJavaDoc, "");
      _builder.newLineIfNotEmpty();
      SrcMethodSignature _srcMethodSignature = new SrcMethodSignature(this.ctx, this.method);
      _builder.append(_srcMethodSignature, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _xifexpression = _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      SrcMethodJavaDoc _srcMethodJavaDoc_1 = new SrcMethodJavaDoc(this.ctx, this.method);
      _builder_1.append(_srcMethodJavaDoc_1, "");
      _builder_1.newLineIfNotEmpty();
      SrcMethodSignature _srcMethodSignature_1 = new SrcMethodSignature(this.ctx, this.method);
      _builder_1.append(_srcMethodSignature_1, "");
      _builder_1.append(" {");
      _builder_1.newLineIfNotEmpty();
      _builder_1.append("\t");
      _builder_1.append("// TODO Implement!");
      _builder_1.newLine();
      _builder_1.append("\t");
      {
        Type _returnType = this.method.getReturnType();
        boolean _notEquals = (!Objects.equal(_returnType, null));
        if (_notEquals) {
          _builder_1.append("return null;");
        }
      }
      _builder_1.newLineIfNotEmpty();
      _builder_1.append("}");
      _builder_1.newLine();
      _xifexpression = _builder_1.toString();
    }
    return _xifexpression;
  }
}
