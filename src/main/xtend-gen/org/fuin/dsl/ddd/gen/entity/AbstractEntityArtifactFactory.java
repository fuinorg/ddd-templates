package org.fuin.dsl.ddd.gen.entity;

import java.util.List;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AbstractEntityArtifactFactory extends AbstractSource<Entity> {
  public Class<? extends Entity> getModelType() {
    return Entity.class;
  }
  
  public GeneratedArtifact create(final Entity entity) throws GenerateException {
    try {
      EObject _eContainer = entity.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".Abstract");
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
    _builder.append("public abstract class Abstract");
    String _name = entity.getName();
    _builder.append(_name, "");
    _builder.append(" extends AbstractEntity<");
    Aggregate _root = entity.getRoot();
    AggregateId _idType = _root.getIdType();
    String _name_1 = _idType.getName();
    _builder.append(_name_1, "");
    _builder.append(", ");
    Aggregate _root_1 = entity.getRoot();
    String _name_2 = _root_1.getName();
    _builder.append(_name_2, "");
    _builder.append(", ");
    EntityId _idType_1 = entity.getIdType();
    String _name_3 = _idType_1.getName();
    _builder.append(_name_3, "");
    _builder.append("> {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    EntityId _idType_2 = entity.getIdType();
    String _name_4 = _idType_2.getName();
    _builder.append(_name_4, "\t");
    _builder.append(" id;");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __varsDecl = this._varsDecl(entity);
    _builder.append(__varsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Constructor> _constructors = entity.getConstructors();
    CharSequence __constructorsDecl = this._constructorsDecl(entity, _constructors);
    _builder.append(__constructorsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@Override");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public final EntityType getType() {\t\t\t\t");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("return ");
    EntityId _idType_3 = entity.getIdType();
    String _name_5 = _idType_3.getName();
    _builder.append(_name_5, "\t\t");
    _builder.append(".TYPE;");
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
    EntityId _idType_4 = entity.getIdType();
    String _name_6 = _idType_4.getName();
    _builder.append(_name_6, "\t");
    _builder.append(" getId() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("return id;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = entity.getVariables();
    CharSequence __settersGetters = this._settersGetters("protected final", _variables);
    _builder.append(__settersGetters, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __abstractChildEntityLocatorMethods = this._abstractChildEntityLocatorMethods(entity);
    _builder.append(__abstractChildEntityLocatorMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    CharSequence __eventAbstractMethodsDecl = this._eventAbstractMethodsDecl(entity);
    _builder.append(__eventAbstractMethodsDecl, "\t");
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
    String _text = this.text(_doc);
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
        String _superDoc = this.superDoc(v);
        _builder.append(_superDoc, "");
        _builder.append(" ");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public Abstract");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append("(@NotNull final ");
    Aggregate _root = entity.getRoot();
    String _name_2 = _root.getName();
    _builder.append(_name_2, "");
    _builder.append(" rootAggregate, ");
    EList<Variable> _variables_1 = constructor.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_1);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<String> _allExceptions = this.allExceptions(constructor);
    CharSequence __exceptions = this._exceptions(_allExceptions);
    _builder.append(__exceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super(rootAggregate);");
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables_2 = constructor.getVariables();
    CharSequence __paramsAssignment = this._paramsAssignment(_variables_2);
    _builder.append(__paramsAssignment, "\t");
    _builder.append("\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
