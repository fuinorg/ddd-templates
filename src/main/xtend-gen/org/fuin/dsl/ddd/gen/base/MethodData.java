package org.fuin.dsl.ddd.gen.base;

import java.util.List;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ReturnType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractMethodData;
import org.fuin.dsl.ddd.gen.extensions.MethodExtensions;

/**
 * Data required to create a method.
 */
@SuppressWarnings("all")
public class MethodData extends AbstractMethodData {
  private final boolean makeAbstract;
  
  private final ReturnType returnType;
  
  /**
   * Method with method.
   * 
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract Abstract method?
   * @param method Method.
   */
  public MethodData(final String modifiers, final boolean makeAbstract, final Method method) {
    super(method.getDoc(), modifiers, method.getName(), MethodExtensions.allVariables(method), MethodExtensions.allExceptions(method));
    this.makeAbstract = makeAbstract;
    ReturnType _returnType = method.getReturnType();
    this.returnType = _returnType;
  }
  
  /**
   * Method without annotations.
   * 
   * @param doc Documentation.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract Abstract method?
   * @param returnType Return type.
   * @param methodName Name of the method.
   * @param variables Variables for the method.
   * @param exceptions Exceptions for the method.
   */
  public MethodData(final String doc, final String modifiers, final boolean makeAbstract, final Type type, final String methodName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    super(doc, null, modifiers, methodName, variables, exceptions);
    this.makeAbstract = makeAbstract;
    this.returnType = this.returnType;
  }
  
  /**
   * Method with all data.
   * 
   * @param doc Documentation.
   * @param annotations Annotations.
   * @param modifiers Modifiers (Don't include "abstract" - Use next argument instead).
   * @param makeAbstract Abstract method?
   * @param returnType Return type.
   * @param methodName Name of the method.
   * @param variables Variables for the method.
   * @param exceptions Exceptions for the method.
   */
  public MethodData(final String doc, final List<String> annotations, final String modifiers, final boolean makeAbstract, final ReturnType returnType, final String methodName, final List<Variable> variables, final List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptions) {
    super(doc, annotations, modifiers, methodName, variables, exceptions);
    this.makeAbstract = makeAbstract;
    this.returnType = returnType;
  }
  
  /**
   * Returns if the method is abstract.
   * 
   * @return TRUE if the method is abstract.
   */
  public boolean isMakeAbstract() {
    return this.makeAbstract;
  }
  
  /**
   * Returns the result type of a method.
   * 
   * @return Type returned by a method.
   */
  public ReturnType getReturnType() {
    return this.returnType;
  }
}
