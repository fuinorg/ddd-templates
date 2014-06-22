package org.fuin.dsl.ddd.gen.extensions;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions;

/**
 * Provides extension methods for Method.
 */
@SuppressWarnings("all")
public class MethodExtensions {
  public static List<Constraint> allConstraints(final Method method) {
    final List<Constraint> list = new ArrayList<Constraint>();
    boolean _and = false;
    Method _refMethod = method.getRefMethod();
    boolean _notEquals = (!Objects.equal(_refMethod, null));
    if (!_notEquals) {
      _and = false;
    } else {
      Method _refMethod_1 = method.getRefMethod();
      boolean _notEquals_1 = (!Objects.equal(method, _refMethod_1));
      _and = _notEquals_1;
    }
    if (_and) {
      Method _refMethod_2 = method.getRefMethod();
      List<Constraint> _allConstraints = MethodExtensions.allConstraints(_refMethod_2);
      list.addAll(_allConstraints);
    }
    Constraints _constraints = method.getConstraints();
    boolean _notEquals_2 = (!Objects.equal(_constraints, null));
    if (_notEquals_2) {
      Constraints _constraints_1 = method.getConstraints();
      EList<ConstraintCall> _calls = _constraints_1.getCalls();
      for (final ConstraintCall cc : _calls) {
        Constraint _constraint = cc.getConstraint();
        list.add(_constraint);
      }
    }
    return list;
  }
  
  public static List<Variable> allVariables(final Method method) {
    List<Variable> list = new ArrayList<Variable>();
    EList<Variable> _variables = method.getVariables();
    list.addAll(_variables);
    boolean _and = false;
    Method _refMethod = method.getRefMethod();
    boolean _notEquals = (!Objects.equal(_refMethod, null));
    if (!_notEquals) {
      _and = false;
    } else {
      Method _refMethod_1 = method.getRefMethod();
      boolean _notEquals_1 = (!Objects.equal(method, _refMethod_1));
      _and = _notEquals_1;
    }
    if (_and) {
      Method _refMethod_2 = method.getRefMethod();
      List<Variable> _allVariables = MethodExtensions.allVariables(_refMethod_2);
      list.addAll(_allVariables);
    }
    return list;
  }
  
  public static List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> allExceptions(final Method method) {
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> list = new ArrayList<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception>();
    boolean _and = false;
    Method _refMethod = method.getRefMethod();
    boolean _notEquals = (!Objects.equal(_refMethod, null));
    if (!_notEquals) {
      _and = false;
    } else {
      Method _refMethod_1 = method.getRefMethod();
      boolean _notEquals_1 = (!Objects.equal(method, _refMethod_1));
      _and = _notEquals_1;
    }
    if (_and) {
      Method _refMethod_2 = method.getRefMethod();
      List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _allExceptions = MethodExtensions.allExceptions(_refMethod_2);
      list.addAll(_allExceptions);
    }
    Constraints _constraints = method.getConstraints();
    boolean _notEquals_2 = (!Objects.equal(_constraints, null));
    if (_notEquals_2) {
      Constraints _constraints_1 = method.getConstraints();
      List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _exceptionList = ConstraintsExtensions.exceptionList(_constraints_1);
      list.addAll(_exceptionList);
    }
    return list;
  }
}
