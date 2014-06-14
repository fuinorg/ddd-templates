package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
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
  
  private final List<Variable> variables;
  
  private final List<Constraint> constraints;
  
  /**
   * Constructor with constructor.
   * 
   * @param ctx Context.
   * @param constructor Constructor.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final Constructor constructor) {
    this(ctx, constructor.getDoc(), constructor.getVariables(), ConstructorExtensions.allConstraints(constructor));
  }
  
  /**
   * Constructor with method.
   * 
   * @param ctx Context.
   * @param method method.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final Method method) {
    this(ctx, method.getDoc(), MethodExtensions.allVariables(method), MethodExtensions.allConstraints(method));
  }
  
  /**
   * Constructor with mandatory data.
   * 
   * @param ctx Context.
   * @param doc Original doc.
   * @param variables Variables.
   * @param constraints Constraints.
   */
  public SrcMethodJavaDoc(final CodeSnippetContext ctx, final String doc, final List<Variable> variables, final List<Constraint> constraints) {
    this.ctx = ctx;
    this.doc = doc;
    this.variables = variables;
    this.constraints = constraints;
  }
  
  public String sp() {
    return " ";
  }
  
  public String toString() {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/*");
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
      List<Constraint> _nullSafe_1 = CollectionExtensions.<Constraint>nullSafe(this.constraints);
      for(final Constraint constraint : _nullSafe_1) {
        {
          org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = constraint.getException();
          boolean _notEquals = (!Objects.equal(_exception, null));
          if (_notEquals) {
            String _sp_1 = this.sp();
            _builder.append(_sp_1, "");
            _builder.append("* @throws ");
            org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_1 = constraint.getException();
            String _name_1 = _exception_1.getName();
            _builder.append(_name_1, "");
            _builder.append(" Thrown if the constraint was violated: ");
            String _doc = constraint.getDoc();
            String _text_1 = StringExtensions.text(_doc);
            _builder.append(_text_1, "");
            _builder.append(" ");
            _builder.newLineIfNotEmpty();
          }
        }
      }
    }
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    return _builder.toString();
  }
}
