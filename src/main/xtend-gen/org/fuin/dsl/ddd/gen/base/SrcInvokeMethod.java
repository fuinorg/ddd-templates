package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for invoking a constructor or a method.
 */
@SuppressWarnings("all")
public class SrcInvokeMethod implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final String method;
  
  private final List<String> names;
  
  /**
   * Constructor with names.
   * 
   * @param ctx Context.
   * @param method Name of the method to call.
   * @param names List of names to use to invoke the super constructor.
   */
  public SrcInvokeMethod(final CodeSnippetContext ctx, final String method, final List<String> names) {
    this.ctx = ctx;
    this.method = method;
    this.names = names;
  }
  
  /**
   * Constructor with names.
   * 
   * @param ctx Context.
   * @param method Name of the method to call.
   * @param names Names to use to invoke the super constructor.
   */
  public SrcInvokeMethod(final CodeSnippetContext ctx, final String method, final String... names) {
    this.ctx = ctx;
    this.method = method;
    ArrayList<String> _arrayList = new ArrayList<String>();
    this.names = _arrayList;
    boolean _notEquals = (!Objects.equal(names, null));
    if (_notEquals) {
      CollectionExtensions.<String>addAll(this.names, names);
    }
  }
  
  public String toString() {
    List<String> _nullSafe = org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.<String>nullSafe(this.names);
    int _size = _nullSafe.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append(this.method, "");
      _builder.append("();");
      return _builder.toString();
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.append(this.method, "");
      _builder_1.append("(");
      {
        boolean _hasElements = false;
        for(final String name : this.names) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder_1.appendImmediate(", ", "");
          }
          _builder_1.append(name, "");
        }
      }
      _builder_1.append(");");
      return _builder_1.toString();
    }
  }
}
