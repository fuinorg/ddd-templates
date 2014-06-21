package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;

/**
 * Data required to create a constructor or method.
 */
@SuppressWarnings("all")
public abstract class AbstractMethodData {
  private String doc;
  
  private String modifiers;
  
  private String name;
  
  private List<String> annotations;
  
  private List<Variable> variables;
  
  private List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions;
  
  /**
   * Constructor without annotations.
   * 
   * @param ctx Documentation for the constructor.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param name Name of the method.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public AbstractMethodData(final String doc, final String modifiers, final String name, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.doc = doc;
    this.annotations = null;
    this.modifiers = modifiers;
    this.name = name;
    this.variables = variables;
    this.exceptions = exceptions;
  }
  
  /**
   * Constructor with all data.
   * 
   * @param ctx Documentation for the constructor.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param name Name of the method.
   * @param variables Variables for the constructor.
   * @param exceptions Exceptions for the constructor.
   */
  public AbstractMethodData(final String doc, final List<String> annotations, final String modifiers, final String name, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    this.doc = doc;
    this.annotations = annotations;
    this.modifiers = modifiers;
    this.name = name;
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
   * Returns a list of method annotations
   * 
   * @return Annotations.
   */
  public List<String> getAnnotations() {
    return this.annotations;
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
   * Returns name method.
   * 
   * @return Name.
   */
  public String getName() {
    return this.name;
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
