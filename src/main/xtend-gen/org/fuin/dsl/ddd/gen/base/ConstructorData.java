package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractMethodData;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;

/**
 * Data required to create a constructor.
 */
@SuppressWarnings("all")
public class ConstructorData extends AbstractMethodData {
  /**
   * Constructor with constructor.
   * 
   * @param modifiers Modifiers.
   * @param typeName Name of the type the constructor belongs to.
   * @param constructor Constructor.
   */
  public ConstructorData(final String modifiers, final String typeName, final Constructor constructor) {
    super(constructor.getDoc(), modifiers, typeName, constructor.getVariables(), ConstructorExtensions.allExceptions(constructor));
  }
  
  /**
   * Constructor without annotations.
   * 
   * @param doc Documentation.
   * @param annotations Annotations.
   * @param modifiers Modifiers.
   * @param typeName Name of the type the constructor belongs to.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public ConstructorData(final String doc, final String modifiers, final String typeName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    super(doc, modifiers, typeName, variables, exceptions);
  }
  
  /**
   * Constructor with all data.
   * 
   * @param doc Documentation.
   * @param annotations Annotations.
   * @param modifiers Modifiers.
   * @param typeName Name of the type the constructor belongs to.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public ConstructorData(final String doc, final List<String> annotations, final String modifiers, final String typeName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    super(doc, annotations, modifiers, typeName, variables, exceptions);
  }
}
