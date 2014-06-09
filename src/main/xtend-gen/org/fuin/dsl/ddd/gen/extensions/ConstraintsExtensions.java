package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;

@SuppressWarnings("all")
public class ConstraintsExtensions {
  public static List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> exceptionList(final Constraints constraints) {
    boolean _equals = Objects.equal(constraints, null);
    if (_equals) {
      return Collections.<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception>emptyList();
    }
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> list = new ArrayList<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception>();
    EList<ConstraintCall> _calls = constraints.getCalls();
    for (final ConstraintCall call : _calls) {
      Constraint _constraint = call.getConstraint();
      boolean _notEquals = (!Objects.equal(_constraint, null));
      if (_notEquals) {
        Constraint _constraint_1 = call.getConstraint();
        org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception exception = _constraint_1.getException();
        boolean _notEquals_1 = (!Objects.equal(exception, null));
        if (_notEquals_1) {
          list.add(exception);
        }
      }
    }
    return list;
  }
}
