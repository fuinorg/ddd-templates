package org.fuin.dsl.ddd.gen.extensions;

import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;

/**
 * Provides extension methods for Type.
 */
@SuppressWarnings("all")
public class TypeExtensions {
  /**
   * Returns the doc text from the type.
   * 
   * @param variable Type with doc text to read.
   * 
   * @return Type doc text.
   */
  public static String doc(final Type type) {
    if ((type instanceof AbstractEntity)) {
      return ((AbstractEntity) type).getDoc();
    } else {
      if ((type instanceof AbstractVO)) {
        return ((AbstractVO) type).getDoc();
      }
    }
    return type.getName();
  }
  
  /**
   * Returns the last part of the name.
   * 
   * @param type Type.
   * @param ctx Context.
   * 
   * @return Simple name (Name without package).
   */
  public static String simpleName(final Type type, final CodeSnippetContext ctx) {
    String _uniqueName = AbstractElementExtensions.uniqueName(type);
    final String name = ctx.getReference(_uniqueName);
    final int p = name.lastIndexOf(".");
    if ((p == (-1))) {
      return name;
    }
    return name.substring((p + 1));
  }
}
