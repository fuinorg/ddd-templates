package org.fuin.dsl.ddd.gen.base;

import com.google.common.base.Objects;
import com.google.common.collect.Iterables;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.TreeIterator;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Message;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.StringLiteral;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;

@SuppressWarnings("all")
public abstract class AbstractSource {
  /**
   * Returns the pure doc message
   * 
   * without slashes and stars in one
   * line.
   */
  public String text(final String str) {
    StringBuilder _stringBuilder = new StringBuilder();
    StringBuilder sb = _stringBuilder;
    StringTokenizer _stringTokenizer = new StringTokenizer(str, "\r\n");
    StringTokenizer tok = _stringTokenizer;
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
    HashSet<String> _hashSet = new HashSet<String>();
    Set<String> types = _hashSet;
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
            String _exception = constraint.getException();
            boolean _notEquals_1 = (!Objects.equal(_exception, null));
            if (_notEquals_1) {
              EObject _eContainer = constraint.eContainer();
              Namespace ns = ((Namespace) _eContainer);
              String _name = ns.getName();
              String _plus = (_name + ".");
              String _exception_1 = constraint.getException();
              String _plus_1 = (_plus + _exception_1);
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
    return types;
  }
  
  public String fqn(final AbstractElement el) {
    EObject _eContainer = el.eContainer();
    Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".");
    String _name_1 = el.getName();
    return (_plus + _name_1);
  }
  
  public Boolean addJavaImport(final Set<String> imports, final EObject obj) {
    Boolean _xblockexpression = null;
    {
      boolean _not = (!(obj instanceof AbstractElement));
      if (_not) {
        return null;
      }
      AbstractElement type = ((AbstractElement) obj);
      String name = type.getName();
      Boolean _switchResult = null;
      boolean _matched = false;
      if (!_matched) {
        if (Objects.equal(name,"UUID")) {
          _matched=true;
          boolean _add = imports.add("java.util.UUID");
          _switchResult = Boolean.valueOf(_add);
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Date")) {
          _matched=true;
          boolean _add_1 = imports.add("org.joda.time.LocalDate");
          _switchResult = Boolean.valueOf(_add_1);
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Time")) {
          _matched=true;
          boolean _add_2 = imports.add("org.joda.time.LocalTime");
          _switchResult = Boolean.valueOf(_add_2);
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Timestamp")) {
          _matched=true;
          boolean _add_3 = imports.add("org.joda.time.LocalDateTime");
          _switchResult = Boolean.valueOf(_add_3);
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"Currency")) {
          _matched=true;
          boolean _add_4 = imports.add("java.util.Currency");
          _switchResult = Boolean.valueOf(_add_4);
        }
      }
      if (!_matched) {
        if (Objects.equal(name,"BigDecimal")) {
          _matched=true;
          boolean _add_5 = imports.add("java.math.BigDecimal");
          _switchResult = Boolean.valueOf(_add_5);
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
        boolean _add_6 = imports.add(_fqn);
        _switchResult = Boolean.valueOf(_add_6);
      }
      _xblockexpression = (_switchResult);
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
    String _plus = ("List<" + name);
    return (_plus + ">");
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
        _or = (_equals || _equals_1);
      }
      if (_or) {
        return "";
      }
      HashSet<String> _hashSet = new HashSet<String>();
      Set<String> imports = _hashSet;
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
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
  }
  
  public CharSequence _varsDecl(final List<Variable> vars) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Variable variable : vars) {
        CharSequence __varDecl = this._varDecl(variable);
        _builder.append(__varDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _varDecl(final Variable v) {
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
    String _xblockexpression = null;
    {
      Constraint constraint = cc.getConstraint();
      EList<Variable> vars = constraint.getVariables();
      EList<Literal> params = cc.getParams();
      String _xifexpression = null;
      int _size = vars.size();
      boolean _equals = (_size == 0);
      if (_equals) {
        StringConcatenation _builder = new StringConcatenation();
        _builder.append("@");
        String _name = constraint.getName();
        _builder.append(_name, "");
        return _builder.toString();
      } else {
        String _xifexpression_1 = null;
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
          String _xifexpression_2 = null;
          int _size_2 = vars.size();
          boolean _greaterThan = (_size_2 > 1);
          if (_greaterThan) {
            ArrayList<String> _arrayList = new ArrayList<String>();
            List<String> list = _arrayList;
            int i = 0;
            boolean _dowhile = false;
            do {
              {
                Variable _get = vars.get(i);
                String name = _get.getName();
                Literal _get_1 = params.get(i);
                String value = this.str(_get_1);
                String _plus = (name + " = ");
                String _plus_1 = (_plus + value);
                list.add(_plus_1);
                int _plus_2 = (i + 1);
                i = _plus_2;
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
          _xifexpression_1 = _xifexpression_2;
        }
        _xifexpression = _xifexpression_1;
      }
      _xblockexpression = (_xifexpression);
    }
    return _xblockexpression;
  }
  
  public CharSequence _constructorsDecl(final AbstractEntity entity, final List<Constructor> constructors) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Constructor constructor : constructors) {
        CharSequence __constructorDecl = this._constructorDecl(entity, constructor);
        _builder.append(__constructorDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _constructorDecl(final AbstractEntity entity, final Constructor constructor) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("public ");
    String _name = entity.getName();
    _builder.append(_name, "");
    _builder.append("(");
    EList<Variable> _variables = constructor.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    CharSequence __exceptions = this._exceptions(constructor);
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
  
  public CharSequence _methodsDecl(final List<Method> methods) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Method method : methods) {
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
    _builder.append("public void ");
    String _name = method.getName();
    _builder.append(_name, "");
    _builder.append("(");
    List<Variable> _allVariables = this.allVariables(method);
    CharSequence __paramsDecl = this._paramsDecl(_allVariables);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    CharSequence __exceptions = this._exceptions(method);
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
  
  public CharSequence _abstractMethodsDecl(final List<Method> methods) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Method method : methods) {
        CharSequence __abstractMethodDecl = this._abstractMethodDecl(method);
        _builder.append(__abstractMethodDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _abstractMethodDecl(final Method method) {
    StringConcatenation _builder = new StringConcatenation();
    String _doc = method.getDoc();
    _builder.append(_doc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public abstract void ");
    String _name = method.getName();
    _builder.append(_name, "");
    _builder.append("(");
    List<Variable> _allVariables = this.allVariables(method);
    CharSequence __paramsDecl = this._paramsDecl(_allVariables);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    CharSequence __exceptions = this._exceptions(method);
    _builder.append(__exceptions, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public String _methodCall(final List<Variable> vars, final List<Literal> params) {
    String _xifexpression = null;
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      return "";
    } else {
      String _xifexpression_1 = null;
      int _size_1 = vars.size();
      boolean _equals_1 = (_size_1 == 1);
      if (_equals_1) {
        Literal _last = IterableExtensions.<Literal>last(params);
        return this.str(_last);
      } else {
        String _xifexpression_2 = null;
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
        _xifexpression_1 = _xifexpression_2;
      }
      _xifexpression = _xifexpression_1;
    }
    return _xifexpression;
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
      _xblockexpression = (_builder);
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
      _and_1 = (_notEquals && _notEquals_1);
    }
    if (!_and_1) {
      _and = false;
    } else {
      Invariants _invariants_2 = v.getInvariants();
      EList<ConstraintCall> _calls_1 = _invariants_2.getCalls();
      int _size = _calls_1.size();
      boolean _greaterThan = (_size > 0);
      _and = (_and_1 && _greaterThan);
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
      _builder.append(" final ");
      String _asJavaType = this.asJavaType(v);
      _builder.append(_asJavaType, "");
      _builder.append(" ");
      String _name = v.getName();
      _builder.append(_name, "");
      _xifexpression = _builder;
    } else {
      StringConcatenation _builder_1 = new StringConcatenation();
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
        _builder.append("this.");
        String _name = v.getName();
        _builder.append(_name, "");
        _builder.append(" = ");
        String _name_1 = v.getName();
        _builder.append(_name_1, "");
        _builder.append(";");
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
    String _doc = v.getDoc();
    _builder.append(_doc, "");
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
    _builder.append(_name_1, "	");
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
    String _doc = variable.getDoc();
    _builder.append(_doc, "");
    _builder.newLineIfNotEmpty();
    _builder.append(visibility, "");
    _builder.append(" void set");
    String _name = variable.getName();
    String _firstUpper = StringExtensions.toFirstUpper(_name);
    _builder.append(_firstUpper, "");
    _builder.append("(");
    String _asJavaType = this.asJavaType(variable);
    _builder.append(_asJavaType, "");
    _builder.append(" ");
    String _name_1 = variable.getName();
    _builder.append(_name_1, "");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("this.");
    String _name_2 = variable.getName();
    _builder.append(_name_2, "	");
    _builder.append(" = ");
    String _name_3 = variable.getName();
    _builder.append(_name_3, "	");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public String str(final Literal literal) {
    if ((literal instanceof StringLiteral)) {
      String _value = literal.getValue();
      String _plus = ("\"" + _value);
      return (_plus + "\"");
    }
    return literal.getValue();
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
        _or = (_equals || _equals_1);
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
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
  }
  
  public CharSequence _exceptions(final Constructor constructor) {
    List<String> _exceptionList = this.exceptionList(constructor);
    CharSequence __exceptions = this._exceptions(_exceptionList);
    return __exceptions;
  }
  
  public CharSequence _exceptions(final Method method) {
    List<String> _exceptionList = this.exceptionList(method);
    CharSequence __exceptions = this._exceptions(_exceptionList);
    return __exceptions;
  }
  
  public List<String> exceptionList(final Constructor constructor) {
    Constraints _constraints = constructor.getConstraints();
    List<String> _exceptionList = this.exceptionList(_constraints);
    return _exceptionList;
  }
  
  public List<String> exceptionList(final Method method) {
    Constraints _constraints = method.getConstraints();
    List<String> _exceptionList = this.exceptionList(_constraints);
    return _exceptionList;
  }
  
  public List<String> exceptionList(final Constraints constraints) {
    boolean _equals = Objects.equal(constraints, null);
    if (_equals) {
      return Collections.<String>emptyList();
    }
    ArrayList<String> _arrayList = new ArrayList<String>();
    List<String> list = _arrayList;
    EList<ConstraintCall> _calls = constraints.getCalls();
    for (final ConstraintCall call : _calls) {
      Constraint _constraint = call.getConstraint();
      boolean _notEquals = (!Objects.equal(_constraint, null));
      if (_notEquals) {
        Constraint _constraint_1 = call.getConstraint();
        String exception = _constraint_1.getException();
        boolean _notEquals_1 = (!Objects.equal(exception, null));
        if (_notEquals_1) {
          list.add(exception);
        }
      }
    }
    return list;
  }
  
  public List<Variable> allVariables(final Constraint constr) {
    ArrayList<Variable> _arrayList = new ArrayList<Variable>();
    List<Variable> list = _arrayList;
    EList<Variable> _variables = constr.getVariables();
    boolean _notEquals = (!Objects.equal(_variables, null));
    if (_notEquals) {
      EList<Variable> _variables_1 = constr.getVariables();
      list.addAll(_variables_1);
    }
    boolean _and = false;
    Message _message = constr.getMessage();
    boolean _notEquals_1 = (!Objects.equal(_message, null));
    if (!_notEquals_1) {
      _and = false;
    } else {
      Message _message_1 = constr.getMessage();
      EList<Variable> _variables_2 = _message_1.getVariables();
      boolean _notEquals_2 = (!Objects.equal(_variables_2, null));
      _and = (_notEquals_1 && _notEquals_2);
    }
    if (_and) {
      Message _message_2 = constr.getMessage();
      EList<Variable> _variables_3 = _message_2.getVariables();
      list.addAll(_variables_3);
    }
    return list;
  }
  
  public List<Variable> allVariables(final Method method) {
    ArrayList<Variable> _arrayList = new ArrayList<Variable>();
    List<Variable> list = _arrayList;
    Method _refMethod = method.getRefMethod();
    boolean _notEquals = (!Objects.equal(_refMethod, null));
    if (_notEquals) {
      Method _refMethod_1 = method.getRefMethod();
      Variable parentVar = this.createVariableForParentType(_refMethod_1);
      boolean _notEquals_1 = (!Objects.equal(parentVar, null));
      if (_notEquals_1) {
        list.add(parentVar);
      }
      Method _refMethod_2 = method.getRefMethod();
      List<Variable> _allVariables = this.allVariables(_refMethod_2);
      list.addAll(_allVariables);
    }
    EList<Variable> _variables = method.getVariables();
    list.addAll(_variables);
    return list;
  }
  
  public List<String> allExceptions(final Method method) {
    ArrayList<String> _arrayList = new ArrayList<String>();
    List<String> list = _arrayList;
    Method _refMethod = method.getRefMethod();
    boolean _notEquals = (!Objects.equal(_refMethod, null));
    if (_notEquals) {
      Method _refMethod_1 = method.getRefMethod();
      List<String> _allExceptions = this.allExceptions(_refMethod_1);
      list.addAll(_allExceptions);
    }
    List<String> _exceptionList = this.exceptionList(method);
    list.addAll(_exceptionList);
    return list;
  }
  
  public Variable createVariableForParentType(final Method method) {
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
        EObject _eContainer_3 = method.eContainer();
        AbstractEntity entity = ((AbstractEntity) _eContainer_3);
        Variable v_1 = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
        String _name_1 = entity.getName();
        String _firstLower_1 = StringExtensions.toFirstLower(_name_1);
        v_1.setName(_firstLower_1);
        v_1.setType(entity);
        return v_1;
      }
    }
    return null;
  }
  
  public CharSequence _eventAbstractMethodsDecl(final List<Method> methods) {
    CharSequence _xblockexpression = null;
    {
      boolean _equals = Objects.equal(methods, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final Method method : methods) {
          EList<Event> _events = method.getEvents();
          CharSequence __eventAbstractMethods = this._eventAbstractMethods(_events);
          _builder.append(__eventAbstractMethods, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
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
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
  }
  
  public CharSequence _eventAbstractMethod(final Event event) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("protected abstract void handle(final ");
    String _name = event.getName();
    _builder.append(_name, "");
    _builder.append(" event);");
    _builder.newLineIfNotEmpty();
    return _builder;
  }
  
  public CharSequence _eventMethodsDecl(final List<Method> methods) {
    CharSequence _xblockexpression = null;
    {
      boolean _equals = Objects.equal(methods, null);
      if (_equals) {
        return "";
      }
      StringConcatenation _builder = new StringConcatenation();
      {
        for(final Method method : methods) {
          EList<Event> _events = method.getEvents();
          CharSequence __eventMethods = this._eventMethods(_events);
          _builder.append(__eventMethods, "");
          _builder.newLineIfNotEmpty();
        }
      }
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
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
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
  }
  
  public CharSequence _eventMethod(final Event event) {
    StringConcatenation _builder = new StringConcatenation();
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
}
