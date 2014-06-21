package org.fuin.dsl.ddd.gen.extensions;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractMethod;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;

/**
 * Provides extension methods for AbstractEntity.
 */
@SuppressWarnings("all")
public class AbstractEntityExtensions {
  /**
   * Returns a list of all constructors and methods.
   * 
   * @param entity Entity to return all constructors and methods for.
   * 
   * @return List of all constructors and methods.
   */
  public static List<AbstractMethod> constructorsAndMethods(final AbstractEntity entity) {
    final List<AbstractMethod> methods = new ArrayList<AbstractMethod>();
    EList<Constructor> _constructors = entity.getConstructors();
    methods.addAll(_constructors);
    EList<Method> _methods = entity.getMethods();
    methods.addAll(_methods);
    return methods;
  }
  
  /**
   * Returns a list of all direct child entities for an entity.
   * 
   * @param parent Direct parent with references to entities.
   * 
   * @return List of directly referenced child entities.
   */
  public static Set<Entity> childEntities(final AbstractEntity parent) {
    Set<Entity> childs = new HashSet<Entity>();
    EList<Variable> _variables = parent.getVariables();
    for (final Variable v : _variables) {
      Type _type = v.getType();
      if ((_type instanceof Entity)) {
        Type _type_1 = v.getType();
        childs.add(((Entity) _type_1));
      }
    }
    return childs;
  }
  
  /**
   * Returns a list of all events from all methods of the entity.
   * 
   * @param entity Entity to return all events for.
   * 
   * @return List of events from all methods.
   */
  public static List<Event> allEvents(final AbstractEntity entity) {
    final ArrayList<Event> events = new ArrayList<Event>();
    List<AbstractMethod> _constructorsAndMethods = AbstractEntityExtensions.constructorsAndMethods(entity);
    for (final AbstractMethod method : _constructorsAndMethods) {
      EList<Event> _events = method.getEvents();
      List<Event> _nullSafe = CollectionExtensions.<Event>nullSafe(_events);
      events.addAll(_nullSafe);
    }
    return events;
  }
}
