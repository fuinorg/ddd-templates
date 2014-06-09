package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions;

/**
 * Provides extension methods for Constructor.
 */
@SuppressWarnings("all")
public class ConstructorExtensions {
  public static List<String> allExceptions(final Constructor constructor) {
    List<String> list = new ArrayList<String>();
    Constraints _constraints = constructor.getConstraints();
    boolean _notEquals = (!Objects.equal(_constraints, null));
    if (_notEquals) {
      Constraints _constraints_1 = constructor.getConstraints();
      List<String> _exceptionList = ConstraintsExtensions.exceptionList(_constraints_1);
      list.addAll(_exceptionList);
    }
    return list;
  }
  
  public static List<Constraint> allConstraints(final Constructor constructor) {
    final List<Constraint> list = new ArrayList<Constraint>();
    Constraints _constraints = constructor.getConstraints();
    boolean _notEquals = (!Objects.equal(_constraints, null));
    if (_notEquals) {
      Constraints _constraints_1 = constructor.getConstraints();
      EList<ConstraintCall> _calls = _constraints_1.getCalls();
      for (final ConstraintCall cc : _calls) {
        Constraint _constraint = cc.getConstraint();
        list.add(_constraint);
      }
    }
    return list;
  }
}
