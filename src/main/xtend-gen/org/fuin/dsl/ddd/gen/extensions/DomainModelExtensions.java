package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.collect.Iterators;
import java.util.Iterator;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;

@SuppressWarnings("all")
public class DomainModelExtensions {
  /**
   * Returns an abstract element of a given type by it's name.
   * Throws an exception if the element is not found.
   * 
   * @param model Domain model.
   * @param type Type to find.
   * @param name Name that is unique within the type.
   * 
   * @return Element.
   */
  public static <T extends AbstractElement> T find(final DomainModel model, final Class<T> type, final String name) {
    TreeIterator<EObject> _eAllContents = model.eAllContents();
    final Iterator<T> iter = Iterators.<T>filter(_eAllContents, type);
    boolean _hasNext = iter.hasNext();
    boolean _while = _hasNext;
    while (_while) {
      {
        final T el = iter.next();
        String _name = el.getName();
        boolean _equals = name.equals(_name);
        if (_equals) {
          return el;
        }
      }
      boolean _hasNext_1 = iter.hasNext();
      _while = _hasNext_1;
    }
    String _simpleName = type.getSimpleName();
    String _plus = ("No abstract element of type \'" + _simpleName);
    String _plus_1 = (_plus + "\' found with name \'");
    String _plus_2 = (_plus_1 + name);
    String _plus_3 = (_plus_2 + "\'");
    throw new IllegalArgumentException(_plus_3);
  }
}
