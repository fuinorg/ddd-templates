package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.TypeExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Provides extension methods for Variable.
 */
@SuppressWarnings("all")
public class VariableExtensions {
  /**
   * Returns the doc text from the variable or the type.
   * 
   * @param variable Variable with doc text to read.
   * 
   * @return Variable or type doc.
   */
  public static String superDoc(final Variable variable) {
    String _xifexpression = null;
    String _doc = variable.getDoc();
    boolean _equals = Objects.equal(_doc, null);
    if (_equals) {
      Type _type = variable.getType();
      String _doc_1 = TypeExtensions.doc(_type);
      _xifexpression = StringExtensions.text(_doc_1);
    } else {
      String _doc_2 = variable.getDoc();
      return StringExtensions.text(_doc_2);
    }
    return _xifexpression;
  }
  
  /**
   * Returns the simple type name. If there is a multiplicity <code>List</code>
   * with the type as generic argument will be returned.
   * 
   * @param variable Variable.
   * @param ctx Context.
   * 
   * @return <code>Type name</code> or <code>List&lt;type name&gt;</code>
   */
  public static String type(final Variable variable, final CodeSnippetContext ctx) {
    Type _type = variable.getType();
    String name = TypeExtensions.simpleName(_type, ctx);
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      return name;
    }
    return (("List<" + name) + ">");
  }
  
  /**
   * Returns the corresponding Java primitive type.
   * 
   * @param variable Variable
   * 
   * @return Primitive type or original type name.
   */
  public static String asJavaPrimitive(final Variable variable) {
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      Type _type = variable.getType();
      return TypeExtensions.asJavaPrimitive(_type);
    }
    Type _type_1 = variable.getType();
    String _asJavaPrimitive = TypeExtensions.asJavaPrimitive(_type_1);
    return (_asJavaPrimitive + "[]");
  }
}
