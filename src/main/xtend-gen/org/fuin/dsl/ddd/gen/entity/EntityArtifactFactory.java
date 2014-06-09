package org.fuin.dsl.ddd.gen.entity;

import java.util.List;
import java.util.Map;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EntityArtifactFactory extends AbstractSource<Entity> {
  public Class<? extends Entity> getModelType() {
    return Entity.class;
  }
  
  public GeneratedArtifact create(final Entity entity, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      EObject _eContainer = entity.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = entity.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(entity, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final Entity entity, final Namespace ns) {
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
    CharSequence __imports = this._imports(entity);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __typeDoc = this._typeDoc(entity);
    _builder.append(__typeDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public final class ");
    String _name = entity.getName();
    _builder.append(_name, "");
    _builder.append(" extends Abstract");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Constructor> _constructors = entity.getConstructors();
    CharSequence __constructorsDecl = this._constructorsDecl(entity, _constructors);
    _builder.append(__constructorsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __childEntityLocatorMethods = this._childEntityLocatorMethods(entity);
    _builder.append(__childEntityLocatorMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    CharSequence __methodsDecl = this._methodsDecl(entity);
    _builder.append(__methodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __eventMethodsDecl = this._eventMethodsDecl(entity);
    _builder.append(__eventMethodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _constructorsDecl(final Entity entity, final List<Constructor> constructors) {
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
  
  public CharSequence _constructorDecl(final Entity entity, final Constructor constructor) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _doc = constructor.getDoc();
    String _text = StringExtensions.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param rootAggregate The root aggregate of this entity.");
    _builder.newLine();
    {
      EList<Variable> _variables = constructor.getVariables();
      for(final Variable v : _variables) {
        _builder.append("* @param ");
        String _name = v.getName();
        _builder.append(_name, "");
        _builder.append(" ");
        String _superDoc = VariableExtensions.superDoc(v);
        _builder.append(_superDoc, "");
        _builder.append(" ");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public ");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append("(final ");
    Aggregate _root = entity.getRoot();
    String _name_2 = _root.getName();
    _builder.append(_name_2, "");
    _builder.append(" rootAggregate, ");
    EList<Variable> _variables_1 = constructor.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_1);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<String> _allExceptions = ConstructorExtensions.allExceptions(constructor);
    CharSequence __exceptions = this._exceptions(_allExceptions);
    _builder.append(__exceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    EList<Variable> _variables_2 = constructor.getVariables();
    String __superCall = this._superCall(_variables_2);
    _builder.append(__superCall, "\t");
    _builder.append("\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public String _superCall(final List<Variable> vars) {
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      return "super(rootAggregate);";
    } else {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("super(rootAggregate, ");
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
}
