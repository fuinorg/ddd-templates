package org.fuin.dsl.ddd.gen.extensions;

import java.util.ArrayList;
import java.util.List;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;

/**
 * Provides extension methods for ConstraintTarget.
 */
@SuppressWarnings("all")
public class ConstraintTargetExtensions {
  /**
   * Returns the name of a constraint target.
   * 
   * @param target Target to return a name for.
   * 
   * @return Name.
   */
  public static String getName(final ConstraintTarget target) {
    if ((target instanceof ValueObject)) {
      return ((ValueObject)target).getName();
    } else {
      if ((target instanceof ExternalType)) {
        return ((ExternalType)target).getName();
      }
    }
    throw new IllegalStateException(("Unknown constraint target type: " + target));
  }
  
  /**
   * Returns the variables of a constraint target.
   * 
   * @param target Target to return a list of variables for.
   * 
   * @return Variables - Never null.
   */
  public static List<Variable> getVariables(final ConstraintTarget target) {
    if ((target instanceof ValueObject)) {
      return ((ValueObject)target).getVariables();
    } else {
      if ((target instanceof ExternalType)) {
        return new ArrayList<Variable>();
      }
    }
    throw new IllegalStateException(("Unknown constraint target type: " + target));
  }
}
