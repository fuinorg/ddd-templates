package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.gen.base.MethodData;
import org.fuin.dsl.ddd.gen.base.SrcMethod;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippet;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Creates source code for a number of methods.
 */
@SuppressWarnings("all")
public class SrcMethods implements CodeSnippet {
  private final CodeSnippetContext ctx;
  
  private final List<MethodData> methods;
  
  /**
   * Constructor with internal type.
   * 
   * @param ctx Context.
   * @param type Type.
   */
  public SrcMethods(final CodeSnippetContext ctx, final InternalType type) {
    this.ctx = ctx;
    ArrayList<MethodData> _arrayList = new ArrayList<MethodData>();
    this.methods = _arrayList;
    EList<Method> _methods = type.getMethods();
    List<Method> _nullSafe = CollectionExtensions.<Method>nullSafe(_methods);
    for (final Method method : _nullSafe) {
      MethodData _methodData = new MethodData("public final", false, method);
      this.methods.add(_methodData);
    }
  }
  
  /**
   * Constructor with all mandatory data.
   * 
   * @param ctx Context.
   * @param typeName Name of the type the constructors creates.
   * @param constructors Constructors.
   */
  public SrcMethods(final CodeSnippetContext ctx, final String typeName, final List<MethodData> methods) {
    this.ctx = ctx;
    this.methods = methods;
  }
  
  public String toString() {
    String _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(this.methods, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = this.methods.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        List<MethodData> _nullSafe = CollectionExtensions.<MethodData>nullSafe(this.methods);
        for(final MethodData method : _nullSafe) {
          SrcMethod _srcMethod = new SrcMethod(this.ctx, method);
          _builder.append(_srcMethod, "");
          _builder.newLineIfNotEmpty();
          _builder.newLine();
        }
      }
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
}
