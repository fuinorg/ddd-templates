package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;

/**
 * Provides extension methods for Event.
 */
@SuppressWarnings("all")
public class EventExtensions {
  /**
   * Returns the unique name of the event.
   * 
   * @param el Event to return a unique name for.
   * 
   * @return Unique name in the context/namespace.
   */
  public static String uniqueName(final Event event) {
    boolean _equals = Objects.equal(event, null);
    if (_equals) {
      throw new IllegalArgumentException("argument \'event\' cannot be null");
    }
    Context _context = EObjectExtensions.getContext(event);
    boolean _equals_1 = Objects.equal(_context, null);
    if (_equals_1) {
      throw new IllegalArgumentException("argument \'event.context\' cannot be null");
    }
    Namespace _namespace = EObjectExtensions.getNamespace(event);
    boolean _equals_2 = Objects.equal(_namespace, null);
    if (_equals_2) {
      throw new IllegalArgumentException("argument \'event.namespace\' cannot be null");
    }
    Context _context_1 = EObjectExtensions.getContext(event);
    String _name = _context_1.getName();
    Namespace _namespace_1 = EObjectExtensions.getNamespace(event);
    String _name_1 = _namespace_1.getName();
    String _name_2 = event.getName();
    return Utils.separated(".", _name, _name_1, _name_2);
  }
}
