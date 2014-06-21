package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;

/**
 * Data required to create a constructor.
 */
@SuppressWarnings("all")
public class ConstructorData {
  private String doc;
  
  private String modifiers;
  
  private String typeName;
  
  private List<Variable> variables;
  
  private List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions;
  
  /**
   * Constructor with constructor.
   * 
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param constructor Constructor.
   */
  public ConstructorData(final String modifiers, final String typeName, final Constructor constructor) {
    this(constructor.getDoc(), modifiers, typeName, constructor.getVariables(), ConstructorExtensions.allExceptions(constructor));
  }
  
  /**
   * Constructor with all data.
   * 
   * @param ctx Documentation for the constructor.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param typeName Name of the type the constructor belongs to.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public ConstructorData(final String doc, final String modifiers, final String typeName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.doc = doc;
    this.modifiers = modifiers;
    this.typeName = typeName;
    this.variables = variables;
    this.exceptions = exceptions;
  }
  
  /**
   * Returns the documentation.
   * 
   * @return Documentation.
   */
  public String getDoc() {
    return this.doc;
  }
  
  /**
   * Returns the modifiers.
   * 
   * @return Modifiers.
   */
  public String getModifiers() {
    return this.modifiers;
  }
  
  /**
   * Returns name of the type the constructor belongs to.
   * 
   * @return Type name.
   */
  public String getTypeName() {
    return this.typeName;
  }
  
  /**
   * Returns the variables.
   * 
   * @return Variables.
   */
  public List<Variable> getVariables() {
    return this.variables;
  }
  
  /**
   * Returns the exceptions.
   * 
   * @return Exceptions.
   */
  public List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> getExceptions() {
    return this.exceptions;
  }
}
