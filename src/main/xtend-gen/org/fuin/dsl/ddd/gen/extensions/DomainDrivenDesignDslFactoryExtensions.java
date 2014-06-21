package org.fuin.dsl.ddd.gen.extensions;

import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;

@SuppressWarnings("all")
public class DomainDrivenDesignDslFactoryExtensions {
  /**
   * Creates a variable with a name.
   * 
   * @param factory Factory.
   * @param name Name.
   */
  public static Variable createVariable(final DomainDrivenDesignDslFactory factory, final String name) {
    return DomainDrivenDesignDslFactoryExtensions.createVariable(factory, name, false);
  }
  
  /**
   * Creates a variable with a name and "nullable" information.
   * 
   * @param factory Factory.
   * @param name Name.
   * @param nullable TRUE if nullable, else false.
   */
  public static Variable createVariable(final DomainDrivenDesignDslFactory factory, final String name, final boolean nullable) {
    Variable v = factory.createVariable();
    v.setName(name);
    if (nullable) {
      v.setNullable("nullable");
    }
    return v;
  }
  
  /**
   * Creates a variable with type, name and "nullable" information.
   * 
   * @param factory Factory.
   * @param type Type.
   * @param name Name.
   * @param nullable TRUE if nullable, else false.
   */
  public static Variable createVariable(final DomainDrivenDesignDslFactory factory, final Type type, final String name, final boolean nullable) {
    Variable v = factory.createVariable();
    v.setName(name);
    if (nullable) {
      v.setNullable("nullable");
    }
    v.setType(type);
    return v;
  }
}
