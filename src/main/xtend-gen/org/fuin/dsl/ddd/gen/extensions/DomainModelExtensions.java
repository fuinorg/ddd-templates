package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.collect.Iterators;
import java.util.Iterator;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.utils4j.InvokeMethodFailedException;
import org.fuin.utils4j.Utils4J;

@SuppressWarnings("all")
public class DomainModelExtensions {
  /**
   * Returns an abstract element of a given type by it's name. The object
   * must have a public instance method <code>String getName()</code>.
   * 
   * Throws an exception if the element is not found.
   * 
   * @param model Domain model.
   * @param type Type to find.
   * @param name Name that is unique within the type.
   * 
   * @return Element.
   */
  public static <T extends EObject> T find(final DomainModel model, final Class<T> type, final String name) {
    TreeIterator<EObject> _eAllContents = model.eAllContents();
    final Iterator<T> iter = Iterators.<T>filter(_eAllContents, type);
    while (iter.hasNext()) {
      {
        final T el = iter.next();
        String _name = DomainModelExtensions.getName(el);
        boolean _equals = name.equals(_name);
        if (_equals) {
          return el;
        }
      }
    }
    String _simpleName = type.getSimpleName();
    String _plus = ("No element of type \'" + _simpleName);
    String _plus_1 = (_plus + "\' found with name \'");
    String _plus_2 = (_plus_1 + name);
    String _plus_3 = (_plus_2 + "\'");
    throw new IllegalArgumentException(_plus_3);
  }
  
  private static String getName(final Object obj) {
    try {
      final Object result = Utils4J.invoke(obj, "getName", null, null);
      if ((result instanceof String)) {
        return ((String)result);
      }
      return null;
    } catch (final Throwable _t) {
      if (_t instanceof InvokeMethodFailedException) {
        final InvokeMethodFailedException ex = (InvokeMethodFailedException)_t;
        return null;
      } else {
        throw Exceptions.sneakyThrow(_t);
      }
    }
  }
}
