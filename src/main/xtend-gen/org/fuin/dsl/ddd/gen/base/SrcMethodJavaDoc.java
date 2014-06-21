package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.ConstructorData;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.dsl.ddd.gen.extensions.MethodExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for the JavaDoc of a constructor or method.
 */
@SuppressWarnings("all")
public class SrcMethodJavaDoc implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String doc;
  
  private final ReturnType returnType;
  
  private final List<Variable> variables;
  
  private final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions;
  
  /**
   * Constructor with constructor.
   * 
   * @param ctx Context.
   * @param constructor Constructor.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final Constructor constructor) {
    this(ctx, constructor.getDoc(), null, constructor.getVariables(), ConstructorExtensions.allExceptions(constructor));
  }
  
  /**
   * Constructor with method.
   * 
   * @param ctx Context.
   * @param method method.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final Method method) {
    this(ctx, method.getDoc(), null, MethodExtensions.allVariables(method), MethodExtensions.allExceptions(method));
  }
  
  /**
   * Constructor with constructor data.
   * 
   * @param ctx Context.
   * @param method Method data.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final ConstructorData constructor) {
    this(ctx, constructor.getDoc(), null, constructor.getVariables(), constructor.getExceptions());
  }
  
  /**
   * Constructor with method data.
   * 
   * @param ctx Context.
   * @param method Method data.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final MethodData method) {
    this(ctx, method.getDoc(), method.getReturnType(), method.getVariables(), method.getExceptions());
  }
  
  /**
   * Constructor with mandatory data.
   * 
   * @param ctx Context.
   * @param doc Original doc.
   * @param returnType Return type.
   * @param variables Variables.
   * @param exceptions Exceptions.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final String doc, final ReturnType returnType, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.ctx = ctx;
    this.doc = doc;
    this.returnType = returnType;
    this.variables = variables;
    this.exceptions = exceptions;
  }
  
  public String sp() {
    return " ";
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _equals = Objects.equal(this.doc, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* ");
      String _text = StringExtensions.text(this.doc);
      _builder.append(_text, " ");
      _builder.newLineIfNotEmpty();
      _builder.append(" ");
      _builder.append("*");
      _builder.newLine();
      {
        List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(this.variables);
        for(final Variable v : _nullSafe) {
          String _sp = this.sp();
          _builder.append(_sp, "");
          _builder.append("* @param ");
          String _name = v.getName();
          _builder.append(_name, "");
          _builder.append(" ");
          String _superDoc = VariableExtensions.superDoc(v);
          _builder.append(_superDoc, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append(" ");
      _builder.append("*");
      _builder.newLine();
      {
        List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _nullSafe_1 = CollectionExtensions.<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception>nullSafe(this.exceptions);
        for(final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception exception : _nullSafe_1) {
          String _sp_1 = this.sp();
          _builder.append(_sp_1, "");
          _builder.append("* @throws ");
          String _name_1 = exception.getName();
          _builder.append(_name_1, "");
          _builder.append(" ");
          String _doc = exception.getDoc();
          String _text_1 = StringExtensions.text(_doc);
          _builder.append(_text_1, "");
          _builder.newLineIfNotEmpty();
        }
      }
      {
        boolean _notEquals = (!Objects.equal(this.returnType, null));
        if (_notEquals) {
          String _sp_2 = this.sp();
          _builder.append(_sp_2, "");
          _builder.append("* @return ");
          String _doc_1 = this.returnType.getDoc();
          String _text_2 = StringExtensions.text(_doc_1);
          _builder.append(_text_2, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
