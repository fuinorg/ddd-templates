package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractMethod;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.OverriddenTypeMetaInfo;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;

@SuppressWarnings("all")
public abstract class AbstractSource<T extends Object> implements ArtifactFactory<T> {
  private String artifactName;
  
  private Map<String,String> varMap;
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
    Map<String,String> _varMap = config.getVarMap();
    this.varMap = _varMap;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public String getArtifactName() {
    return this.artifactName;
  }
  
  public String getBasePkg() {
    Map<String,String> _nullSafe = this.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("basepkg");
  }
  
  public String getPkg() {
    Map<String,String> _nullSafe = this.<String, String>nullSafe(this.varMap);
    return _nullSafe.get("pkg");
  }
  
  public String getCopyrightHeader() {
    Map<String,String> _nullSafe = this.<String, String>nullSafe(this.varMap);
    final String header = _nullSafe.get("copyrightHeader");
    boolean _equals = Objects.equal(header, null);
    if (_equals) {
      return "";
    }
    return header;
  }
  
  /**
   * Returns the pure doc message without slashes and stars in one line.
   * 
   * @param str JavaDoc comment.
   * 
   * @return Plain single line text.
   */
  public String text(final String str) {
    boolean _equals = Objects.equal(str, null);
    if (_equals) {
      return "";
    }
    StringBuilder sb = new StringBuilder();
    StringTokenizer tok = new StringTokenizer(str, "\r\n");
    boolean _hasMoreTokens = tok.hasMoreTokens();
    boolean _while = _hasMoreTokens;
    while (_while) {
      {
        String line = tok.nextToken();
        String _replace = line.replace("/**", "");
        line = _replace;
        String _replace_1 = line.replace(" * ", "");
        line = _replace_1;
        String _replace_2 = line.replace("*/", "");
        line = _replace_2;
        sb.append(line);
        sb.append(" ");
      }
      boolean _hasMoreTokens_1 = tok.hasMoreTokens();
      _while = _hasMoreTokens_1;
    }
    String _string = sb.toString();
    String _replace = _string.replace("  ", " ");
    String result = _replace.trim();
    return result;
  }
  
  public Set<String> createImportSet(final EObject el) {
    Set<String> types = new HashSet<String>();
    types.add("org.fuin.ddd4j.ddd.*");
    types.add("org.fuin.objects4j.vo.*");
    types.add("java.util.List");
    types.add("java.util.Locale");
    this.addJavaImport(types, el);
    TreeIterator<EObject> _eAllContents = el.eAllContents();
    Iterable<EObject> _iterable = IteratorExtensions.<EObject>toIterable(_eAllContents);
    Iterable<Variable> _filter = Iterables.<Variable>filter(_iterable, Variable.class);
    for (final Variable variable : _filter) {
      {
        Invariants _invariants = variable.getInvariants();
        boolean _notEquals = (!Objects.equal(_invariants, null));
        if (_notEquals) {
          Invariants _invariants_1 = variable.getInvariants();
          EList<ConstraintCall> _calls = _invariants_1.getCalls();
          for (final ConstraintCall call : _calls) {
            Constraint _constraint = call.getConstraint();
            String _fqn = this.fqn(_constraint);
            types.add(_fqn);
          }
        }
        Type _type = variable.getType();
        this.addJavaImport(types, _type);
        String _multiplicity = variable.getMultiplicity();
        boolean _notEquals_1 = (!Objects.equal(_multiplicity, null));
        if (_notEquals_1) {
          String _name = List.class.getName();
          types.add(_name);
        }
      }
    }
    TreeIterator<EObject> _eAllContents_1 = el.eAllContents();
    Iterable<EObject> _iterable_1 = IteratorExtensions.<EObject>toIterable(_eAllContents_1);
    Iterable<Constraints> _filter_1 = Iterables.<Constraints>filter(_iterable_1, Constraints.class);
    for (final Constraints constraints : _filter_1) {
      EList<ConstraintCall> _calls = constraints.getCalls();
      boolean _notEquals = (!Objects.equal(_calls, null));
      if (_notEquals) {
        EList<ConstraintCall> _calls_1 = constraints.getCalls();
        for (final ConstraintCall call : _calls_1) {
          {
            Constraint constraint = call.getConstraint();
            org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = constraint.getException();
            boolean _notEquals_1 = (!Objects.equal(_exception, null));
            if (_notEquals_1) {
              EObject _eContainer = constraint.eContainer();
              Namespace ns = ((Namespace) _eContainer);
              String _asPackage = this.asPackage(ns);
              String _plus = (_asPackage + ".");
              org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_1 = constraint.getException();
              String _name = _exception_1.getName();
              String _plus_1 = (_plus + _name);
              types.add(_plus_1);
            }
          }
        }
      }
    }
    TreeIterator<EObject> _eAllContents_2 = el.eAllContents();
    Iterable<EObject> _iterable_2 = IteratorExtensions.<EObject>toIterable(_eAllContents_2);
    Iterable<Method> _filter_2 = Iterables.<Method>filter(_iterable_2, Method.class);
    for (final Method method : _filter_2) {
      Method _refMethod = method.getRefMethod();
      boolean _notEquals_1 = (!Objects.equal(_refMethod, null));
      if (_notEquals_1) {
        Method _refMethod_1 = method.getRefMethod();
        Set<String> _createImportSet = this.createImportSet(_refMethod_1);
        types.addAll(_createImportSet);
      }
    }
    TreeIterator<EObject> _eAllContents_3 = el.eAllContents();
    Iterable<EObject> _iterable_3 = IteratorExtensions.<EObject>toIterable(_eAllContents_3);
    Iterable<ConstraintTarget> _filter_3 = Iterables.<ConstraintTarget>filter(_iterable_3, ConstraintTarget.class);
    for (final ConstraintTarget constraintTarget : _filter_3) {
      this.addJavaImport(types, constraintTarget);
    }
    return types;
  }
  
  public String fqn(final Event event) {
    Namespace ns = this.getNamespace(event);
    String _asPackage = this.asPackage(ns);
    String _plus = (_asPackage + ".");
    String _name = event.getName();
    return (_plus + _name);
  }
  
  public String fqn(final AbstractElement el) {
    Namespace ns = this.getNamespace(el);
    String _asPackage = this.asPackage(ns);
    String _plus = (_asPackage + ".");
    String _name = el.getName();
    return (_plus + _name);
  }
  
  public Namespace getNamespace(final EObject obj) {
    if ((obj instanceof Namespace)) {
      return ((Namespace)obj);
    }
    EObject _eContainer = obj.eContainer();
    return this.getNamespace(_eContainer);
  }
  
  public Context getContext(final EObject obj) {
    if ((obj instanceof Context)) {
      return ((Context)obj);
    }
    EObject _eContainer = obj.eContainer();
    return this.getContext(_eContainer);
  }
  
  public String asPackage(final Namespace ns) {
    String _pkg = this.getPkg();
    boolean _equals = Objects.equal(_pkg, null);
    if (_equals) {
      String _basePkg = this.getBasePkg();
      String _plus = (_basePkg + ".");
      Context _context = this.getContext(ns);
      String _name = _context.getName();
      String _plus_1 = (_plus + _name);
      String _plus_2 = (_plus_1 + ".");
      String _name_1 = ns.getName();
      return (_plus_2 + _name_1);
    }
    String _basePkg_1 = this.getBasePkg();
    String _plus_3 = (_basePkg_1 + ".");
    Context _context_1 = this.getContext(ns);
    String _name_2 = _context_1.getName();
    String _plus_4 = (_plus_3 + _name_2);
    String _plus_5 = (_plus_4 + ".");
    String _pkg_1 = this.getPkg();
    String _plus_6 = (_plus_5 + _pkg_1);
    String _plus_7 = (_plus_6 + ".");
    String _name_3 = ns.getName();
    return (_plus_7 + _name_3);
  }
  
  public Boolean addJavaImport(final Set<String> imports, final EObject obj) {
    Boolean _xblockexpression = null;
    {
      if ((!(obj instanceof AbstractElement))) {
        return null;
      }
      AbstractElement type = ((AbstractElement) obj);
      String name = type.getName();
      Boolean _switchResult = null;
      boolean _matched = false;
      if (!_matched) {
        if (Objects.equal(name,"UUID")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("java.util.UUID"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Date")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("org.joda.time.LocalDate"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Time")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("org.joda.time.LocalTime"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Timestamp")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("org.joda.time.LocalDateTime"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Currency")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("java.util.Currency"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"BigDecimal")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("java.math.BigDecimal"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Locale")) {
          _matched=true;
          _switchResult = Boolean.valueOf(imports.add("java.util.Locale"));
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Byte")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Short")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Integer")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Long")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Float")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Double")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Boolean")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Character")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"String")) {
          _matched=true;
          _switchResult = null;
        }
      }
      if (!_matched) {
        String _fqn = this.fqn(type);
        _switchResult = Boolean.valueOf(imports.add(_fqn));
      }
      _xblockexpression = _switchResult;
    }
    return _xblockexpression;
  }
  
  public String asJavaType(final Variable variable) {
    Type _type = variable.getType();
    String name = _type.getName();
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(name,"Date")) {
        _matched=true;
        name = "LocalDate";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Time")) {
        _matched=true;
        name = "LocalTime";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Timestamp")) {
        _matched=true;
        name = "LocalDateTime";
      }
    }
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      return name;
    }
    return (("List<" + name) + ">");
  }
  
  public String asJavaPrimitive(final Variable variable) {
    Type _type = variable.getType();
    String name = _type.getName();
    boolean _matched = false;
    if (!_matched) {
      if (Objects.equal(name,"Byte")) {
        _matched=true;
        name = "byte";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Short")) {
        _matched=true;
        name = "short";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Integer")) {
        _matched=true;
        name = "int";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Long")) {
        _matched=true;
        name = "long";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Float")) {
        _matched=true;
        name = "float";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Double")) {
        _matched=true;
        name = "double";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Boolean")) {
        _matched=true;
        name = "boolean";
      }
    }
    if (!_matched) {
      if (Objects.equal(name,"Character")) {
        _matched=true;
        name = "char";
      }
    }
    String _multiplicity = variable.getMultiplicity();
    boolean _equals = Objects.equal(_multiplicity, null);
    if (_equals) {
      return name;
    }
    return (name + "[]");
  }
  
  public String str(final Literal literal) {
    if ((literal instanceof StringLiteral)) {
      String _value = ((StringLiteral)literal).getValue();
      String _plus = ("\"" + _value);
      return (_plus + "\"");
    }
    return literal.getValue();
  }
  
  public List<String> exceptionList(final Constraints constraints) {
    boolean _equals = Objects.equal(constraints, null);
    if (_equals) {
      return Collections.<String>emptyList();
    }
    List<String> list = new ArrayList<String>();
    EList<ConstraintCall> _calls = constraints.getCalls();
    for (final ConstraintCall call : _calls) {
      Constraint _constraint = call.getConstraint();
      boolean _notEquals = (!Objects.equal(_constraint, null));
      if (_notEquals) {
        Constraint _constraint_1 = call.getConstraint();
        org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = _constraint_1.getException();
        String exception = _exception.getName();
        boolean _notEquals_1 = (!Objects.equal(exception, null));
        if (_notEquals_1) {
          list.add(exception);
        }
      }
    }
    return list;
  }
  
  public Variable copyRenamed(final Variable v, final String name) {
    Variable vv = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
    vv.setName(name);
    String _doc = v.getDoc();
    vv.setDoc(_doc);
    String _nullable = v.getNullable();
    vv.setNullable(_nullable);
    Type _type = v.getType();
    vv.setType(_type);
    String _multiplicity = v.getMultiplicity();
    vv.setMultiplicity(_multiplicity);
    Invariants _invariants = v.getInvariants();
    vv.setInvariants(_invariants);
    OverriddenTypeMetaInfo _overridden = v.getOverridden();
    vv.setOverridden(_overridden);
    return vv;
  }
  
  public List<Variable> allVariables(final Constraint constr) {
    List<Variable> list = new ArrayList<Variable>();
    EList<Variable> _variables = constr.getVariables();
    boolean _notEquals = (!Objects.equal(_variables, null));
    if (_notEquals) {
      EList<Variable> _variables_1 = constr.getVariables();
      list.addAll(_variables_1);
    }
    ConstraintTarget target = constr.getTarget();
    if ((target instanceof ExternalType)) {
      ExternalType et = ((ExternalType) target);
      Variable vv = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
      vv.setName("vv");
      vv.setDoc("/** The validated value. */");
      vv.setType(et);
      list.add(vv);
    } else {
      ValueObject vo = ((ValueObject) target);
      EList<Variable> _variables_2 = vo.getVariables();
      boolean _notEquals_1 = (!Objects.equal(_variables_2, null));
      if (_notEquals_1) {
        EList<Variable> _variables_3 = vo.getVariables();
        for (final Variable v : _variables_3) {
          {
            String _name = v.getName();
            String _plus = ("vv_" + _name);
            Variable vv_1 = this.copyRenamed(v, _plus);
            list.add(vv_1);
          }
        }
      }
    }
    return list;
  }
  
  public List<Variable> allVariables(final Method method) {
    List<Variable> list = new ArrayList<Variable>();
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
      Variable refVar = this.createVariableForRef(_refMethod_2);
      boolean _notEquals_2 = (!Objects.equal(refVar, null));
      if (_notEquals_2) {
        list.add(refVar);
      }
      Method _refMethod_3 = method.getRefMethod();
      List<Variable> _allVariables = this.allVariables(_refMethod_3);
      list.addAll(_allVariables);
    }
    EList<Variable> _variables = method.getVariables();
    list.addAll(_variables);
    return list;
  }
  
  public List<String> allExceptions(final Method method) {
    List<String> list = new ArrayList<String>();
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
      List<String> _allExceptions = this.allExceptions(_refMethod_2);
      list.addAll(_allExceptions);
    }
    Constraints _constraints = method.getConstraints();
    boolean _notEquals_2 = (!Objects.equal(_constraints, null));
    if (_notEquals_2) {
      Constraints _constraints_1 = method.getConstraints();
      List<String> _exceptionList = this.exceptionList(_constraints_1);
      list.addAll(_exceptionList);
    }
    return list;
  }
  
  public List<String> allExceptions(final Constructor constructor) {
    List<String> list = new ArrayList<String>();
    Constraints _constraints = constructor.getConstraints();
    boolean _notEquals = (!Objects.equal(_constraints, null));
    if (_notEquals) {
      Constraints _constraints_1 = constructor.getConstraints();
      List<String> _exceptionList = this.exceptionList(_constraints_1);
      list.addAll(_exceptionList);
    }
    return list;
  }
  
  public Variable createVariableForRef(final AbstractMethod method) {
    EObject _eContainer = method.eContainer();
    if ((_eContainer instanceof AbstractVO)) {
      EObject _eContainer_1 = method.eContainer();
      AbstractVO vo = ((AbstractVO) _eContainer_1);
      Variable v = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
      String _name = vo.getName();
      String _firstLower = StringExtensions.toFirstLower(_name);
      v.setName(_firstLower);
      v.setType(vo);
      return v;
    } else {
      EObject _eContainer_2 = method.eContainer();
      if ((_eContainer_2 instanceof AbstractEntity)) {
        ExternalType et = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType();
        et.setName("EntityIdPath");
        Variable v_1 = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
        v_1.setName("entityIdPath");
        v_1.setType(et);
        return v_1;
      }
    }
    return null;
  }
  
  public Variable first(final List<Variable> variables) {
    boolean _or = false;
    boolean _equals = Objects.equal(variables, null);
    if (_equals) {
      _or = true;
    } else {
      int _size = variables.size();
      boolean _equals_1 = (_size == 0);
      _or = _equals_1;
    }
    if (_or) {
      return null;
    }
    return variables.get(0);
  }
  
  public List<Variable> withoutFirst(final List<Variable> variables) {
    List<Variable> rest = new ArrayList<Variable>();
    boolean _and = false;
    boolean _notEquals = (!Objects.equal(variables, null));
    if (!_notEquals) {
      _and = false;
    } else {
      int _size = variables.size();
      boolean _greaterThan = (_size > 0);
      _and = _greaterThan;
    }
    if (_and) {
      int count = 0;
      for (final Variable v : variables) {
        {
          if ((count > 0)) {
            rest.add(v);
          }
          count = (count + 1);
        }
      }
    }
    return rest;
  }
  
  public AbstractEntityId getEntityIdType(final Event event) {
    EObject _eContainer = event.eContainer();
    EObject _eContainer_1 = _eContainer.eContainer();
    AbstractEntity abstractEntity = ((AbstractEntity) _eContainer_1);
    if ((abstractEntity instanceof Aggregate)) {
      Aggregate aggregate = ((Aggregate) abstractEntity);
      return aggregate.getIdType();
    } else {
      Entity entity = ((Entity) abstractEntity);
      return entity.getIdType();
    }
  }
  
  public String toXmlName(final String name) {
    String _replaceAll = name.replaceAll("(.)(\\p{Upper})", "$1-$2");
    return _replaceAll.toLowerCase();
  }
  
  public String toSqlUpper(final String name) {
    String _replaceAll = name.replaceAll("(.)(\\p{Upper})", "$1_$2");
    return _replaceAll.toUpperCase();
  }
  
  public String toSqlLower(final String name) {
    String _replaceAll = name.replaceAll("(.)(\\p{Upper})", "$1_$2");
    return _replaceAll.toLowerCase();
  }
  
  public String toSqlInitials(final String name) {
    boolean _or = false;
    boolean _equals = Objects.equal(name, null);
    if (_equals) {
      _or = true;
    } else {
      int _length = name.length();
      boolean _equals_1 = (_length == 0);
      _or = _equals_1;
    }
    if (_or) {
      return name;
    }
    final StringBuilder sb = new StringBuilder();
    final String lname = this.toSqlLower(name);
    int _length_1 = lname.length();
    int _minus = (_length_1 - 1);
    IntegerRange _upTo = new IntegerRange(0, _minus);
    for (final Integer i : _upTo) {
      {
        final char ch = lname.charAt((i).intValue());
        if (((i).intValue() == 0)) {
          sb.append(ch);
        } else {
          boolean _and = false;
          int _compareTo = Character.valueOf(ch).compareTo(Character.valueOf('_'));
          boolean _equals_2 = (_compareTo == 0);
          if (!_equals_2) {
            _and = false;
          } else {
            int _length_2 = lname.length();
            int _minus_1 = (_length_2 - 1);
            boolean _lessThan = ((i).intValue() < _minus_1);
            _and = _lessThan;
          }
          if (_and) {
            sb.append("_");
            char _charAt = lname.charAt(((i).intValue() + 1));
            sb.append(_charAt);
          }
        }
      }
    }
    return sb.toString();
  }
  
  public String superDoc(final Variable variable) {
    String _xifexpression = null;
    String _doc = variable.getDoc();
    boolean _equals = Objects.equal(_doc, null);
    if (_equals) {
      Type _type = variable.getType();
      String _doc_1 = this.doc(_type);
      _xifexpression = this.text(_doc_1);
    } else {
      String _doc_2 = variable.getDoc();
      return this.text(_doc_2);
    }
    return _xifexpression;
  }
  
  public String doc(final Type type) {
    if ((type instanceof AbstractEntity)) {
      return ((AbstractEntity) type).getDoc();
    } else {
      if ((type instanceof AbstractVO)) {
        return ((AbstractVO) type).getDoc();
      }
    }
    return type.getName();
  }
  
  private Set<Entity> childEntities(final AbstractEntity parent) {
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
  
  public <T extends Object> List<T> nullSafe(final List<T> list) {
    boolean _equals = Objects.equal(list, null);
    if (_equals) {
      return Collections.<T>emptyList();
    }
    return list;
  }
  
  public <K extends Object, V extends Object> Map<K,V> nullSafe(final Map<K,V> map) {
    boolean _equals = Objects.equal(map, null);
    if (_equals) {
      return Collections.<K, V>emptyMap();
    }
    return map;
  }
  
  public List<AbstractMethod> constructorsAndMethods(final AbstractEntity entity) {
    final List<AbstractMethod> methods = new ArrayList<AbstractMethod>();
    EList<Constructor> _constructors = entity.getConstructors();
    methods.addAll(_constructors);
    EList<Method> _methods = entity.getMethods();
    methods.addAll(_methods);
    return methods;
  }
  
  public List<Constraint> allConstraints(final Method method) {
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
      List<Constraint> _allConstraints = this.allConstraints(_refMethod_2);
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
  
  public List<Constraint> allConstraints(final Constructor constructor) {
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
  
  public CharSequence _imports(final EObject... elements) {
    CharSequence _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(elements, null);
      if (_equals) {
        _or = true;
      } else {
        int _length = elements.length;
        boolean _equals_1 = (_length == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      Set<String> imports = new HashSet<String>();
      for (final EObject el : elements) {
        Set<String> _createImportSet = this.createImportSet(el);
        imports.addAll(_createImportSet);
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final String imp : imports) {
          _builder.append("import ");
          _builder.append(imp, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence _methodDoc(final Constructor constructor) {
    String _doc = constructor.getDoc();
    EList<Variable> _variables = constructor.getVariables();
    List<Constraint> _allConstraints = this.allConstraints(constructor);
    return this._methodDoc(_doc, _variables, _allConstraints);
  }
  
  public CharSequence _methodDoc(final Method method) {
    String _doc = method.getDoc();
    List<Variable> _allVariables = this.allVariables(method);
    List<Constraint> _allConstraints = this.allConstraints(method);
    return this._methodDoc(_doc, _allVariables, _allConstraints);
  }
  
  public CharSequence _methodDoc(final String doc, final List<Variable> variables, final List<Constraint> constraints) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _text = this.text(doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    {
      List<Variable> _nullSafe = this.<Variable>nullSafe(variables);
      for(final Variable v : _nullSafe) {
        _builder.append("* @param ");
        String _name = v.getName();
        _builder.append(_name, "");
        _builder.append(" ");
        String _superDoc = this.superDoc(v);
        _builder.append(_superDoc, "");
        _builder.append(" ");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    {
      List<Constraint> _nullSafe_1 = this.<Constraint>nullSafe(constraints);
      for(final Constraint constraint : _nullSafe_1) {
        {
          org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = constraint.getException();
          boolean _notEquals = (!Objects.equal(_exception, null));
          if (_notEquals) {
            _builder.append("* @throws ");
            org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_1 = constraint.getException();
            String _name_1 = _exception_1.getName();
            _builder.append(_name_1, "");
            _builder.append(" Thrown if the constraint was violated: ");
            String _doc = constraint.getDoc();
            String _text_1 = this.text(_doc);
            _builder.append(_text_1, "");
            _builder.append(" ");
            _builder.newLineIfNotEmpty();
          }
        }
      }
    }
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _typeDoc(final InternalType internalType) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _doc = internalType.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _varsDecl(final InternalType internalType) {
    return this._varsDecl(internalType, false);
  }
  
  public CharSequence _varsDecl(final InternalType internalType, final boolean xml) {
    StringConcatenation _builder = new StringConcatenation();
    {
      EList<Variable> _variables = internalType.getVariables();
      List<Variable> _nullSafe = this.<Variable>nullSafe(_variables);
      for(final Variable variable : _nullSafe) {
        CharSequence __varDecl = this._varDecl(variable, xml);
        _builder.append(__varDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _varDecl(final Variable v) {
    return this._varDecl(v, false);
  }
  
  public CharSequence _varDecl(final Variable v, final boolean xml) {
    CharSequence _xifexpression = null;
    Invariants _invariants = v.getInvariants();
    boolean _notEquals = (!Objects.equal(_invariants, null));
    if (_notEquals) {
      StringConcatenation _builder = new StringConcatenation();
      {
        Invariants _invariants_1 = v.getInvariants();
        EList<ConstraintCall> _calls = _invariants_1.getCalls();
        boolean _hasElements = false;
        for(final ConstraintCall cc : _calls) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(" ", "");
          }
          String __constraintCall = this._constraintCall(cc);
          _builder.append(__constraintCall, "");
          _builder.append("\t");
          _builder.newLineIfNotEmpty();
        }
      }
      {
        String _nullable = v.getNullable();
        boolean _equals = Objects.equal(_nullable, null);
        if (_equals) {
          _builder.append("@NotNull");
          _builder.newLine();
        }
      }
      {
        if (xml) {
          CharSequence __xmlAttributeOrElement = this._xmlAttributeOrElement(v);
          _builder.append(__xmlAttributeOrElement, "");
          _builder.append("\t\t\t");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.append("private ");
      String _asJavaType = this.asJavaType(v);
      _builder.append(_asJavaType, "");
      _builder.append(" ");
      String _name = v.getName();
      _builder.append(_name, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      {
        String _nullable_1 = v.getNullable();
        boolean _equals_1 = Objects.equal(_nullable_1, null);
        if (_equals_1) {
          _builder_1.append("@NotNull");
          _builder_1.newLine();
        }
      }
      {
        if (xml) {
          CharSequence __xmlAttributeOrElement_1 = this._xmlAttributeOrElement(v);
          _builder_1.append(__xmlAttributeOrElement_1, "");
          _builder_1.append("\t\t\t");
          _builder_1.newLineIfNotEmpty();
        }
      }
      _builder_1.append("private ");
      String _asJavaType_1 = this.asJavaType(v);
      _builder_1.append(_asJavaType_1, "");
      _builder_1.append(" ");
      String _name_1 = v.getName();
      _builder_1.append(_name_1, "");
      _builder_1.append(";");
      _builder_1.newLineIfNotEmpty();
      _xifexpression = _builder_1;
    }
    return _xifexpression;
  }
  
  public String _constraintCall(final ConstraintCall cc) {
    Constraint constraint = cc.getConstraint();
    EList<Variable> vars = constraint.getVariables();
    EList<Literal> params = cc.getParams();
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("@");
      String _name = constraint.getName();
      _builder.append(_name, "");
      return _builder.toString();
    } else {
      int _size_1 = vars.size();
      boolean _equals_1 = (_size_1 == 1);
      if (_equals_1) {
        StringConcatenation _builder_1 = new StringConcatenation();
        _builder_1.append("@");
        String _name_1 = constraint.getName();
        _builder_1.append(_name_1, "");
        _builder_1.append("(");
        Literal _last = IterableExtensions.<Literal>last(params);
        String _str = this.str(_last);
        _builder_1.append(_str, "");
        _builder_1.append(")");
        return _builder_1.toString();
      } else {
        int _size_2 = vars.size();
        boolean _greaterThan = (_size_2 > 1);
        if (_greaterThan) {
          List<String> list = new ArrayList<String>();
          int i = 0;
          boolean _dowhile = false;
          do {
            {
              Variable _get = vars.get(i);
              String name = _get.getName();
              Literal _get_1 = params.get(i);
              String value = this.str(_get_1);
              list.add(((name + " = ") + value));
              i = (i + 1);
            }
            int _size_3 = vars.size();
            boolean _lessThan = (i < _size_3);
            _dowhile = _lessThan;
          } while(_dowhile);
          StringConcatenation _builder_2 = new StringConcatenation();
          _builder_2.append("@");
          String _name_2 = constraint.getName();
          _builder_2.append(_name_2, "");
          _builder_2.append("(");
          {
            boolean _hasElements = false;
            for(final String str : list) {
              if (!_hasElements) {
                _hasElements = true;
              } else {
                _builder_2.appendImmediate(", ", "");
              }
              _builder_2.append(str, "");
            }
          }
          _builder_2.append(")");
          return _builder_2.toString();
        }
      }
    }
    return null;
  }
  
  public CharSequence _constructorsDecl(final InternalType internalType) {
    StringConcatenation _builder = new StringConcatenation();
    {
      EList<Constructor> _constructors = internalType.getConstructors();
      List<Constructor> _nullSafe = this.<Constructor>nullSafe(_constructors);
      for(final Constructor constructor : _nullSafe) {
        String _name = internalType.getName();
        EList<Variable> _variables = constructor.getVariables();
        Constraints _constraints = constructor.getConstraints();
        CharSequence __constructorDecl = this._constructorDecl(_name, _variables, _constraints);
        _builder.append(__constructorDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _constructorsDecl(final AbstractVO vo) {
    CharSequence _xifexpression = null;
    EList<Constructor> _constructors = vo.getConstructors();
    List<Constructor> _nullSafe = this.<Constructor>nullSafe(_constructors);
    int _size = _nullSafe.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      String _name = vo.getName();
      EList<Variable> _variables = vo.getVariables();
      _xifexpression = this._constructorDecl(_name, _variables, null);
    } else {
      _xifexpression = this._constructorsDecl(((InternalType) vo));
    }
    return _xifexpression;
  }
  
  public CharSequence _constructorDecl(final String internalTypeName, final List<Variable> variables, final Constraints constraints) {
    StringConcatenation _builder = new StringConcatenation();
    CharSequence __methodDoc = this._methodDoc("Constructor with all data.", variables, null);
    _builder.append(__methodDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public ");
    _builder.append(internalTypeName, "");
    _builder.append("(");
    List<Variable> _nullSafe = this.<Variable>nullSafe(variables);
    CharSequence __paramsDecl = this._paramsDecl(_nullSafe);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<String> _exceptionList = this.exceptionList(constraints);
    CharSequence __exceptions = this._exceptions(_exceptionList);
    _builder.append(__exceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    List<Variable> _nullSafe_1 = this.<Variable>nullSafe(variables);
    CharSequence __paramsAssignment = this._paramsAssignment(_nullSafe_1);
    _builder.append(__paramsAssignment, "\t");
    _builder.append("\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _methodsDecl(final InternalType internalType) {
    StringConcatenation _builder = new StringConcatenation();
    {
      EList<Method> _methods = internalType.getMethods();
      List<Method> _nullSafe = this.<Method>nullSafe(_methods);
      for(final Method method : _nullSafe) {
        CharSequence __methodDecl = this._methodDecl(method);
        _builder.append(__methodDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _methodDecl(final Method method) {
    StringConcatenation _builder = new StringConcatenation();
    CharSequence __methodDoc = this._methodDoc(method);
    _builder.append(__methodDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public final void ");
    String _name = method.getName();
    _builder.append(_name, "");
    _builder.append("(");
    List<Variable> _allVariables = this.allVariables(method);
    CharSequence __paramsDecl = this._paramsDecl(_allVariables);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<String> _allExceptions = this.allExceptions(method);
    CharSequence __exceptions = this._exceptions(_allExceptions);
    _builder.append(__exceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("// TODO Implement\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public String _methodCall(final List<Variable> vars) {
    String _xblockexpression = null;
    {
      List<Literal> params = new ArrayList<Literal>();
      for (final Variable v : vars) {
        {
          Literal name = DomainDrivenDesignDslFactory.eINSTANCE.createLiteral();
          String _name = v.getName();
          name.setValue(_name);
          params.add(name);
        }
      }
      _xblockexpression = this._methodCall(vars, params);
    }
    return _xblockexpression;
  }
  
  public String _methodCall(final List<Variable> vars, final List<Literal> params) {
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      return "";
    } else {
      int _size_1 = vars.size();
      boolean _equals_1 = (_size_1 == 1);
      if (_equals_1) {
        Literal _last = IterableExtensions.<Literal>last(params);
        return this.str(_last);
      } else {
        int _size_2 = vars.size();
        boolean _greaterThan = (_size_2 > 1);
        if (_greaterThan) {
          StringConcatenation _builder = new StringConcatenation();
          {
            boolean _hasElements = false;
            for(final Literal p : params) {
              if (!_hasElements) {
                _hasElements = true;
              } else {
                _builder.appendImmediate(", ", "");
              }
              String _str = this.str(p);
              _builder.append(_str, "");
            }
          }
          return _builder.toString();
        }
      }
    }
    return null;
  }
  
  public String _superCall(final List<Variable> vars) {
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      return "super();";
    } else {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("super(");
      {
        boolean _hasElements = false;
        for(final Variable v : vars) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", "");
          }
          String _name = v.getName();
          _builder.append(_name, "");
        }
      }
      _builder.append(");");
      return _builder.toString();
    }
  }
  
  public CharSequence _paramsDecl(final List<Variable> vars) {
    CharSequence _xblockexpression = null;
    {
      boolean _equals = Objects.equal(vars, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        boolean _hasElements = false;
        for(final Variable variable : vars) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", "");
          }
          CharSequence __paramDecl = this._paramDecl(variable);
          _builder.append(__paramDecl, "");
        }
      }
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence _paramDecl(final Variable v) {
    CharSequence _xifexpression = null;
    boolean _and = false;
    boolean _and_1 = false;
    Invariants _invariants = v.getInvariants();
    boolean _notEquals = (!Objects.equal(_invariants, null));
    if (!_notEquals) {
      _and_1 = false;
    } else {
      Invariants _invariants_1 = v.getInvariants();
      EList<ConstraintCall> _calls = _invariants_1.getCalls();
      boolean _notEquals_1 = (!Objects.equal(_calls, null));
      _and_1 = _notEquals_1;
    }
    if (!_and_1) {
      _and = false;
    } else {
      Invariants _invariants_2 = v.getInvariants();
      EList<ConstraintCall> _calls_1 = _invariants_2.getCalls();
      int _size = _calls_1.size();
      boolean _greaterThan = (_size > 0);
      _and = _greaterThan;
    }
    if (_and) {
      StringConcatenation _builder = new StringConcatenation();
      {
        Invariants _invariants_3 = v.getInvariants();
        EList<ConstraintCall> _calls_2 = _invariants_3.getCalls();
        boolean _hasElements = false;
        for(final ConstraintCall cc : _calls_2) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(" ", "");
          }
          String __constraintCall = this._constraintCall(cc);
          _builder.append(__constraintCall, "");
        }
      }
      _builder.append(" ");
      {
        String _nullable = v.getNullable();
        boolean _equals = Objects.equal(_nullable, null);
        if (_equals) {
          _builder.append("@NotNull\t");
        }
      }
      _builder.append("final ");
      String _asJavaType = this.asJavaType(v);
      _builder.append(_asJavaType, "");
      _builder.append(" ");
      String _name = v.getName();
      _builder.append(_name, "");
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      {
        String _nullable_1 = v.getNullable();
        boolean _equals_1 = Objects.equal(_nullable_1, null);
        if (_equals_1) {
          _builder_1.append("@NotNull ");
        }
      }
      _builder_1.append("final ");
      String _asJavaType_1 = this.asJavaType(v);
      _builder_1.append(_asJavaType_1, "");
      _builder_1.append(" ");
      String _name_1 = v.getName();
      _builder_1.append(_name_1, "");
      _xifexpression = _builder_1;
    }
    return _xifexpression;
  }
  
  public CharSequence _paramsAssignment(final List<Variable> vars) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable v : vars) {
        {
          String _nullable = v.getNullable();
          boolean _equals = Objects.equal(_nullable, null);
          if (_equals) {
            _builder.append("Contract.requireArgNotNull(\"");
            String _name = v.getName();
            _builder.append(_name, "");
            _builder.append("\", ");
            String _name_1 = v.getName();
            _builder.append(_name_1, "");
            _builder.append(");");
            _builder.newLineIfNotEmpty();
          }
        }
      }
    }
    {
      for(final Variable v_1 : vars) {
        CharSequence __paramAssignment = this._paramAssignment(v_1);
        _builder.append(__paramAssignment, "");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence _paramAssignment(final Variable v) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("this.");
    String _name = v.getName();
    _builder.append(_name, "");
    _builder.append(" = ");
    String _name_1 = v.getName();
    _builder.append(_name_1, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _settersGetters(final String visibility, final List<Variable> vars) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable v : vars) {
        CharSequence __setter = this._setter(visibility, v);
        _builder.append(__setter, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
        CharSequence __getter = this._getter(visibility, v);
        _builder.append(__getter, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _getters(final String visibility, final List<Variable> vars) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable v : vars) {
        CharSequence __getter = this._getter(visibility, v);
        _builder.append(__getter, "");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence _getter(final String visibility, final Variable v) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns: ");
    String _superDoc = this.superDoc(v);
    String _text = this.text(_superDoc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Current value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(" ");
    {
      String _nullable = v.getNullable();
      boolean _equals = Objects.equal(_nullable, null);
      if (_equals) {
        _builder.append("@NeverNull");
      }
    }
    _builder.newLineIfNotEmpty();
    _builder.append(visibility, "");
    _builder.append(" ");
    String _asJavaType = this.asJavaType(v);
    _builder.append(_asJavaType, "");
    _builder.append(" get");
    String _name = v.getName();
    String _firstUpper = StringExtensions.toFirstUpper(_name);
    _builder.append(_firstUpper, "");
    _builder.append("() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("return ");
    String _name_1 = v.getName();
    _builder.append(_name_1, "\t");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _setters(final String visibility, final List<Variable> vars) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable variable : vars) {
        CharSequence __setter = this._setter(visibility, variable);
        _builder.append(__setter, "");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence _setter(final String visibility, final Variable variable) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Sets: ");
    String _doc = variable.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param ");
    String _name = variable.getName();
    _builder.append(_name, " ");
    _builder.append(" Value to set.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(visibility, "");
    _builder.append(" void set");
    String _name_1 = variable.getName();
    String _firstUpper = StringExtensions.toFirstUpper(_name_1);
    _builder.append(_firstUpper, "");
    _builder.append("(");
    {
      String _nullable = variable.getNullable();
      boolean _equals = Objects.equal(_nullable, null);
      if (_equals) {
        _builder.append("@NotNull ");
      }
    }
    _builder.append("final ");
    String _asJavaType = this.asJavaType(variable);
    _builder.append(_asJavaType, "");
    _builder.append(" ");
    String _name_2 = variable.getName();
    _builder.append(_name_2, "");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    {
      String _nullable_1 = variable.getNullable();
      boolean _equals_1 = Objects.equal(_nullable_1, null);
      if (_equals_1) {
        _builder.append("\t");
        _builder.append("Contract.requireArgNotNull(\"");
        String _name_3 = variable.getName();
        _builder.append(_name_3, "\t");
        _builder.append("\", ");
        String _name_4 = variable.getName();
        _builder.append(_name_4, "\t");
        _builder.append(");");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("\t");
    _builder.append("this.");
    String _name_5 = variable.getName();
    _builder.append(_name_5, "\t");
    _builder.append(" = ");
    String _name_6 = variable.getName();
    _builder.append(_name_6, "\t");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _exceptions(final List<String> exceptions) {
    CharSequence _xblockexpression = null;
    {
      boolean _or = false;
      boolean _equals = Objects.equal(exceptions, null);
      if (_equals) {
        _or = true;
      } else {
        int _size = exceptions.size();
        boolean _equals_1 = (_size == 0);
        _or = _equals_1;
      }
      if (_or) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("throws ");
      {
        boolean _hasElements = false;
        for(final String ex : exceptions) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", "");
          }
          _builder.append(ex, "");
        }
      }
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence _eventAbstractMethodsDecl(final AbstractEntity entity) {
    StringConcatenation _builder = new StringConcatenation();
    {
      List<AbstractMethod> _constructorsAndMethods = this.constructorsAndMethods(entity);
      for(final AbstractMethod method : _constructorsAndMethods) {
        EList<Event> _events = method.getEvents();
        CharSequence __eventAbstractMethods = this._eventAbstractMethods(_events);
        _builder.append(__eventAbstractMethods, "");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence _eventAbstractMethods(final List<Event> events) {
    CharSequence _xblockexpression = null;
    {
      boolean _equals = Objects.equal(events, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final Event event : events) {
          CharSequence __eventAbstractMethod = this._eventAbstractMethod(event);
          _builder.append(__eventAbstractMethod, "");
          _builder.newLineIfNotEmpty();
          _builder.newLine();
        }
      }
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence _eventAbstractMethod(final Event event) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Handles: ");
    String _name = event.getName();
    _builder.append(_name, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param event Event to handle.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("protected abstract void handle(final ");
    String _name_1 = event.getName();
    _builder.append(_name_1, "");
    _builder.append(" event);");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _eventMethodsDecl(final AbstractEntity entity) {
    StringConcatenation _builder = new StringConcatenation();
    {
      List<AbstractMethod> _constructorsAndMethods = this.constructorsAndMethods(entity);
      for(final AbstractMethod method : _constructorsAndMethods) {
        EList<Event> _events = method.getEvents();
        CharSequence __eventMethods = this._eventMethods(_events);
        _builder.append(__eventMethods, "");
        _builder.newLineIfNotEmpty();
      }
    }
    return _builder;
  }
  
  public CharSequence _eventMethods(final List<Event> events) {
    CharSequence _xblockexpression = null;
    {
      boolean _equals = Objects.equal(events, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final Event event : events) {
          CharSequence __eventMethod = this._eventMethod(event);
          _builder.append(__eventMethod, "");
          _builder.newLineIfNotEmpty();
          _builder.newLine();
        }
      }
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
  
  public CharSequence _eventMethod(final Event event) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("@EventHandler");
    _builder.newLine();
    _builder.append("protected final void handle(final ");
    String _name = event.getName();
    _builder.append(_name, "");
    _builder.append(" event) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("// TODO Handle event!");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public String optionalExtendsForBase(final String typeName, final ExternalType base) {
    boolean _equals = Objects.equal(base, null);
    if (_equals) {
      return "";
    }
    String _name = base.getName();
    boolean _equals_1 = _name.equals("String");
    if (_equals_1) {
      return "extends AbstractStringValueObject ";
    }
    String _name_1 = base.getName();
    boolean _equals_2 = _name_1.equals("UUID");
    if (_equals_2) {
      return "extends AbstractUUIDVO ";
    }
    String _name_2 = base.getName();
    boolean _equals_3 = _name_2.equals("Integer");
    if (_equals_3) {
      return "extends AbstractIntegerValueObject ";
    }
    String _name_3 = base.getName();
    boolean _equals_4 = _name_3.equals("Long");
    if (_equals_4) {
      return "extends AbstractLongValueObject ";
    }
    return "";
  }
  
  public CharSequence _optionalBaseMethods(final String typeName, final ExternalType base) {
    boolean _equals = Objects.equal(base, null);
    if (_equals) {
      return "";
    }
    String _name = base.getName();
    boolean _equals_1 = _name.equals("String");
    if (_equals_1) {
      return this._optionalBaseMethodsString(typeName);
    }
    String _name_1 = base.getName();
    boolean _equals_2 = _name_1.equals("UUID");
    if (_equals_2) {
      return this._optionalBaseMethodsUUID(typeName);
    }
    boolean _or = false;
    String _name_2 = base.getName();
    boolean _equals_3 = _name_2.equals("Integer");
    if (_equals_3) {
      _or = true;
    } else {
      String _name_3 = base.getName();
      boolean _equals_4 = _name_3.equals("Long");
      _or = _equals_4;
    }
    if (_or) {
      String _name_4 = base.getName();
      return this._optionalBaseMethodsNumber(typeName, _name_4);
    }
    return "";
  }
  
  public CharSequence _optionalBaseMethodsNumber(final String typeName, final String baseName) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given ");
    _builder.append(baseName, " ");
    _builder.append(" can be converted into");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* an instance of this class. A <code>null</code> value returns <code>true</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid ");
    _builder.append(baseName, " ");
    _builder.append(", else FALSE.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final ");
    _builder.append(baseName, "");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("try {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append(baseName, "\t\t");
    _builder.append(".valueOf(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("} catch (final NumberFormatException ex) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return false;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given ");
    _builder.append(baseName, " ");
    _builder.append(" and returns a new instance of this class.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final ");
    _builder.append(baseName, "");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(typeName, "\t");
    _builder.append("(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("public Integer asBaseType() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return val;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("public String asString() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return \"\" + val;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given String and returns a new instance of this class.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(typeName, "\t");
    _builder.append("(");
    _builder.append(baseName, "\t");
    _builder.append(".valueOf(value));");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _optionalBaseMethodsString(final String typeName) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given string can be converted into");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* an instance of this class. A <code>null</code> value returns <code>true</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid string, else FALSE.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final String value) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Verify the value is valid!");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return true;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given string and returns a new instance of this class.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Parse string value and return new instance! ");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// return new ");
    _builder.append(typeName, "\t");
    _builder.append("(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _optionalBaseMethodsUUID(final String typeName) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns the information if a given string can be converted into");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* an instance of this class. A <code>null</code> value returns <code>true</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to check.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return TRUE if it\'s a valid string, else FALSE.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static boolean isValid(final String value) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return UUIDStrValidator.isValid(value);");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Parses a given string and returns a new instance of this class.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param value");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            Value to convert. A <code>null</code> value returns");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*            <code>null</code>.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Converted value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public static ");
    _builder.append(typeName, "");
    _builder.append(" valueOf(final String value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return new ");
    _builder.append(typeName, "\t");
    _builder.append("(UUID.fromString(value));");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  /**
   * Generates source for a protected default constructor
   * if no other constructor with no arguments exists.
   * 
   * @param internalType Type to optionally generate the default constructor for.
   */
  public String _optionalDeserializationConstructor(final InternalType internalType) {
    String _xblockexpression = null;
    {
      EList<Constructor> _constructors = internalType.getConstructors();
      List<Constructor> _nullSafe = this.<Constructor>nullSafe(_constructors);
      for (final Constructor constructor : _nullSafe) {
        boolean _or = false;
        boolean _equals = Objects.equal(constructor, null);
        if (_equals) {
          _or = true;
        } else {
          EList<Variable> _variables = constructor.getVariables();
          List<Variable> _nullSafe_1 = this.<Variable>nullSafe(_variables);
          int _size = _nullSafe_1.size();
          boolean _equals_1 = (_size == 0);
          _or = _equals_1;
        }
        if (_or) {
          return "";
        }
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/**");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("* Default constructor only for de-serialization.");
      _builder.newLine();
      _builder.append(" ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("protected ");
      String _name = internalType.getName();
      _builder.append(_name, "");
      _builder.append("() {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("super();");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _xblockexpression = _builder.toString();
    }
    return _xblockexpression;
  }
  
  public String _valueObjectConverterSource(final Namespace ns, final String voTypeName, final String targetTypeName, final boolean implementsSingleEntityIdFactory) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import javax.enterprise.context.ApplicationScoped;");
    _builder.newLine();
    _builder.append("import javax.persistence.AttributeConverter;");
    _builder.newLine();
    _builder.append("import javax.persistence.Converter;");
    _builder.newLine();
    _builder.append("import org.fuin.objects4j.common.ThreadSafe;");
    _builder.newLine();
    _builder.append("import org.fuin.objects4j.vo.AbstractValueObjectConverter;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Converts ");
    _builder.append(voTypeName, " ");
    _builder.append(" from/to ");
    _builder.append(targetTypeName, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@ThreadSafe");
    _builder.newLine();
    _builder.append("@ApplicationScoped");
    _builder.newLine();
    _builder.append("@Converter(autoApply = true)");
    _builder.newLine();
    _builder.append("public final class ");
    _builder.append(voTypeName, "");
    _builder.append("Converter extends");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("AbstractValueObjectConverter<");
    _builder.append(targetTypeName, "\t\t");
    _builder.append(", ");
    _builder.append(voTypeName, "\t\t");
    _builder.append("> implements");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("AttributeConverter<");
    _builder.append(voTypeName, "\t\t");
    _builder.append(", ");
    _builder.append(targetTypeName, "\t\t");
    _builder.append(">");
    {
      if (implementsSingleEntityIdFactory) {
        _builder.append(", SingleEntityIdFactory");
      }
    }
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public Class<");
    _builder.append(targetTypeName, "\t");
    _builder.append("> getBaseTypeClass() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(targetTypeName, "\t\t");
    _builder.append(".class;");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final Class<");
    _builder.append(voTypeName, "\t");
    _builder.append("> getValueObjectClass() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(voTypeName, "\t\t");
    _builder.append(".class;");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final boolean isValid(final ");
    _builder.append(targetTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(voTypeName, "\t\t");
    _builder.append(".isValid(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final ");
    _builder.append(voTypeName, "\t");
    _builder.append(" toVO(final ");
    _builder.append(targetTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return ");
    _builder.append(voTypeName, "\t\t");
    _builder.append(".valueOf(value);");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final ");
    _builder.append(targetTypeName, "\t");
    _builder.append(" fromVO(final ");
    _builder.append(voTypeName, "\t");
    _builder.append(" value) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("if (value == null) {");
    _builder.newLine();
    _builder.append("\t\t\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return value.asBaseType();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    {
      if (implementsSingleEntityIdFactory) {
        _builder.append("@Override");
        _builder.newLine();
        _builder.append("public final EntityId createEntityId(final String id) {");
        _builder.newLine();
        _builder.append("\t");
        _builder.append("return ");
        _builder.append(voTypeName, "\t");
        _builder.append(".valueOf(id);");
        _builder.newLineIfNotEmpty();
        _builder.append("}");
        _builder.newLine();
      }
    }
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder.toString();
  }
  
  public CharSequence _xmlRootElement(final String name) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlRootElement(name = \"");
    String _xmlName = this.toXmlName(name);
    _builder.append(_xmlName, "");
    _builder.append("\")");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _xmlAttributeOrElement(final Variable v) {
    Type _type = v.getType();
    if ((_type instanceof ValueObject)) {
      Type _type_1 = v.getType();
      final ValueObject vo = ((ValueObject) _type_1);
      ExternalType _base = vo.getBase();
      boolean _notEquals = (!Objects.equal(_base, null));
      if (_notEquals) {
        return this._xmlAttribute(v);
      }
    } else {
      Type _type_2 = v.getType();
      if ((_type_2 instanceof EntityId)) {
        Type _type_3 = v.getType();
        final EntityId id = ((EntityId) _type_3);
        ExternalType _base_1 = id.getBase();
        boolean _notEquals_1 = (!Objects.equal(_base_1, null));
        if (_notEquals_1) {
          return this._xmlAttribute(v);
        }
      } else {
        Type _type_4 = v.getType();
        if ((_type_4 instanceof AggregateId)) {
          Type _type_5 = v.getType();
          final AggregateId id_1 = ((AggregateId) _type_5);
          ExternalType _base_2 = id_1.getBase();
          boolean _notEquals_2 = (!Objects.equal(_base_2, null));
          if (_notEquals_2) {
            return this._xmlAttribute(v);
          }
        }
      }
    }
    return this._xmlElement(v);
  }
  
  public CharSequence _xmlElement(final Variable v) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlElement(name = \"");
    String _name = v.getName();
    String _xmlName = this.toXmlName(_name);
    _builder.append(_xmlName, "");
    _builder.append("\")");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _xmlAttribute(final Variable v) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlAttribute(name = \"");
    String _name = v.getName();
    String _xmlName = this.toXmlName(_name);
    _builder.append(_xmlName, "");
    _builder.append("\")");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _abstractChildEntityLocatorMethods(final AbstractEntity parent) {
    StringConcatenation _builder = new StringConcatenation();
    {
      Set<Entity> _childEntities = this.childEntities(parent);
      for(final Entity child : _childEntities) {
        CharSequence __abstractChildEntityLocatorMethod = this._abstractChildEntityLocatorMethod(child);
        _builder.append(__abstractChildEntityLocatorMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _abstractChildEntityLocatorMethod(final AbstractEntity entity) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Locates the child entity of type ");
    String _name = entity.getName();
    _builder.append(_name, " ");
    _builder.append(".");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param ");
    AbstractEntityId _idType = entity.getIdType();
    String _name_1 = _idType.getName();
    String _firstLower = StringExtensions.toFirstLower(_name_1);
    _builder.append(_firstLower, " ");
    _builder.append(" Unique identifier of the child entity to find.");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Child entity or NULL if no entity with the given identifier was found.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("protected abstract ");
    String _name_2 = entity.getName();
    _builder.append(_name_2, "");
    _builder.append(" find");
    String _name_3 = entity.getName();
    _builder.append(_name_3, "");
    _builder.append("(final ");
    AbstractEntityId _idType_1 = entity.getIdType();
    String _name_4 = _idType_1.getName();
    _builder.append(_name_4, "");
    _builder.append(" ");
    AbstractEntityId _idType_2 = entity.getIdType();
    String _name_5 = _idType_2.getName();
    String _firstLower_1 = StringExtensions.toFirstLower(_name_5);
    _builder.append(_firstLower_1, "");
    _builder.append(");");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _childEntityLocatorMethods(final AbstractEntity parent) {
    StringConcatenation _builder = new StringConcatenation();
    {
      Set<Entity> _childEntities = this.childEntities(parent);
      for(final Entity child : _childEntities) {
        CharSequence __childEntityLocatorMethod = this._childEntityLocatorMethod(child);
        _builder.append(__childEntityLocatorMethod, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _childEntityLocatorMethod(final AbstractEntity entity) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("@ChildEntityLocator");
    _builder.newLine();
    _builder.append("protected final ");
    String _name = entity.getName();
    _builder.append(_name, "");
    _builder.append(" find");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append("(final ");
    AbstractEntityId _idType = entity.getIdType();
    String _name_2 = _idType.getName();
    _builder.append(_name_2, "");
    _builder.append(" ");
    AbstractEntityId _idType_1 = entity.getIdType();
    String _name_3 = _idType_1.getName();
    String _firstLower = StringExtensions.toFirstLower(_name_3);
    _builder.append(_firstLower, "");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("// TODO Implement!");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return null;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _get(final String objName, final Variable v) {
    CharSequence _xifexpression = null;
    boolean _equals = Objects.equal(objName, null);
    if (_equals) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("get");
      String _name = v.getName();
      String _firstUpper = StringExtensions.toFirstUpper(_name);
      _builder.append(_firstUpper, "");
      _builder.append("()");
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.append(objName, "");
      _builder_1.append(".get");
      String _name_1 = v.getName();
      String _firstUpper_1 = StringExtensions.toFirstUpper(_name_1);
      _builder_1.append(_firstUpper_1, "");
      _builder_1.append("()");
      _xifexpression = _builder_1;
    }
    return _xifexpression;
  }
  
  public CharSequence _uniquelyNumberedException(final org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception ex) {
    CharSequence _xifexpression = null;
    int _cid = ex.getCid();
    boolean _greaterThan = (_cid > 0);
    if (_greaterThan) {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("UniquelyNumberedException");
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
      _builder_1.append("Exception");
      _xifexpression = _builder_1;
    }
    return _xifexpression;
  }
}
