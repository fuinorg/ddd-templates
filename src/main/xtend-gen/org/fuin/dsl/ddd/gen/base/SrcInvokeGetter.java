package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for calling a single getter.<br>
 * Examples: <code>getX()</code> or <code>y.getX()</code>
 */
@SuppressWarnings("all")
public class SrcInvokeGetter implements CodeSnippet {
  private final String objName;
  
  private final Variable variable;
  
  public SrcInvokeGetter(final CodeSnippetContext ctx, final String objName, final Variable variable) {
    this.objName = objName;
    this.variable = variable;
  }
  
  public String toString() {
    String _xifexpression = null;
    boolean _equals = Objects.equal(this.objName, null);
    if (_equals) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("get");
      String _name = this.variable.getName();
      String _firstUpper = StringExtensions.toFirstUpper(_name);
      _builder.append(_firstUpper, "");
      _builder.append("()");
      _xifexpression = _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.append(this.objName, "");
      _builder_1.append(".get");
      String _name_1 = this.variable.getName();
      String _firstUpper_1 = StringExtensions.toFirstUpper(_name_1);
      _builder_1.append(_firstUpper_1, "");
      _builder_1.append("()");
      _xifexpression = _builder_1.toString();
    }
    return _xifexpression;
  }
}
