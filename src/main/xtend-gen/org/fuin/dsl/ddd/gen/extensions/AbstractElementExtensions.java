package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;

/**
 * Provides extension methods for AbstractElement.
 */
@SuppressWarnings("all")
public class AbstractElementExtensions {
  /**
   * Returns the unique name .
   * 
   * @param el Element to return a unique name for.
   * 
   * @return Unique name in the context/namespace.
   */
  public static String uniqueName(final AbstractElement el) {
    boolean _equals = Objects.equal(el, null);
    if (_equals) {
      throw new IllegalArgumentException("argument \'el\' cannot be null");
    }
    Context _context = EObjectExtensions.getContext(el);
    boolean _equals_1 = Objects.equal(_context, null);
    if (_equals_1) {
      throw new IllegalArgumentException("argument \'el.context\' cannot be null");
    }
    Namespace _namespace = EObjectExtensions.getNamespace(el);
    boolean _equals_2 = Objects.equal(_namespace, null);
    if (_equals_2) {
      throw new IllegalArgumentException("argument \'el.namespace\' cannot be null");
    }
    Context _context_1 = EObjectExtensions.getContext(el);
    String _name = _context_1.getName();
    Namespace _namespace_1 = EObjectExtensions.getNamespace(el);
    String _name_1 = _namespace_1.getName();
    String _name_2 = el.getName();
    return Utils.separated(".", _name, _name_1, _name_2);
  }
  
  /**
   * Returns the abstract unique name.
   * 
   * @param el Element to return an abstract unique name for.
   * 
   * @return Abstract unique name in the context/namespace.
   */
  public static String uniqueAbstractName(final AbstractElement el) {
    boolean _equals = Objects.equal(el, null);
    if (_equals) {
      throw new IllegalArgumentException("argument \'el\' cannot be null");
    }
    Context _context = EObjectExtensions.getContext(el);
    boolean _equals_1 = Objects.equal(_context, null);
    if (_equals_1) {
      throw new IllegalArgumentException("argument \'el.context\' cannot be null");
    }
    Namespace _namespace = EObjectExtensions.getNamespace(el);
    boolean _equals_2 = Objects.equal(_namespace, null);
    if (_equals_2) {
      throw new IllegalArgumentException("argument \'el.namespace\' cannot be null");
    }
    Context _context_1 = EObjectExtensions.getContext(el);
    String _name = _context_1.getName();
    Namespace _namespace_1 = EObjectExtensions.getNamespace(el);
    String _name_1 = _namespace_1.getName();
    String _name_2 = el.getName();
    String _plus = ("Abstract" + _name_2);
    return Utils.separated(".", _name, _name_1, _plus);
  }
}
