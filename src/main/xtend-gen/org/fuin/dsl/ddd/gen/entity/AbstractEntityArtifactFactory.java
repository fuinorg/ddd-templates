package org.fuin.dsl.ddd.gen.entity;

import java.util.List;
import java.util.Map;
import java.util.Set;
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
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc;
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment;
import org.fuin.dsl.ddd.gen.base.SrcSetters;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class AbstractEntityArtifactFactory extends AbstractSource<Entity> {
  public Class<? extends Entity> getModelType() {
    return Entity.class;
  }
  
  public GeneratedArtifact create(final Entity entity, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      String _name = entity.getName();
      final String className = ("Abstract" + _name);
      EObject _eContainer = entity.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      final String fqn = ((pkg + ".") + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueAbstractName = AbstractElementExtensions.uniqueAbstractName(entity);
      refReg.putReference(_uniqueAbstractName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
      this.addImports(ctx);
      this.addReferences(ctx, entity);
      String _artifactName = this.getArtifactName();
      String _create = this.create(ctx, entity, pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("org.fuin.ddd4j.ddd.AbstractEntity");
    ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final Entity entity) {
    EntityId _idType = entity.getIdType();
    String _uniqueName = AbstractElementExtensions.uniqueName(_idType);
    ctx.requiresReference(_uniqueName);
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Entity entity, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      SrcJavaDoc _srcJavaDoc = new SrcJavaDoc(entity);
      _builder.append(_srcJavaDoc, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public abstract class ");
      _builder.append(className, "");
      _builder.append(" extends AbstractEntity<");
      Aggregate _root = entity.getRoot();
      AggregateId _idType = _root.getIdType();
      String _name = _idType.getName();
      _builder.append(_name, "");
      _builder.append(", ");
      Aggregate _root_1 = entity.getRoot();
      String _name_1 = _root_1.getName();
      _builder.append(_name_1, "");
      _builder.append(", ");
      EntityId _idType_1 = entity.getIdType();
      String _name_2 = _idType_1.getName();
      _builder.append(_name_2, "");
      _builder.append("> {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("private ");
      EntityId _idType_2 = entity.getIdType();
      String _name_3 = _idType_2.getName();
      _builder.append(_name_3, "\t");
      _builder.append(" id;");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      SrcVarsDecl _srcVarsDecl = new SrcVarsDecl(ctx, "private", false, entity);
      _builder.append(_srcVarsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      EList<Constructor> _constructors = entity.getConstructors();
      CharSequence __constructorsDecl = this._constructorsDecl(ctx, entity, _constructors);
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
      String _name_4 = _idType_3.getName();
      _builder.append(_name_4, "\t\t");
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
      String _name_5 = _idType_4.getName();
      _builder.append(_name_5, "\t");
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
      SrcGetters _srcGetters = new SrcGetters(ctx, "protected final", _variables);
      _builder.append(_srcGetters, "\t");
      _builder.append("\t\t\t\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      EList<Variable> _variables_1 = entity.getVariables();
      SrcSetters _srcSetters = new SrcSetters(ctx, "protected final", _variables_1);
      _builder.append(_srcSetters, "\t");
      _builder.newLineIfNotEmpty();
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
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = ctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
  
  public CharSequence _constructorsDecl(final CodeSnippetContext ctx, final Entity entity, final List<Constructor> constructors) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Constructor constructor : constructors) {
        CharSequence __constructorDecl = this._constructorDecl(ctx, entity, constructor);
        _builder.append(__constructorDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _constructorDecl(final CodeSnippetContext ctx, final Entity entity, final Constructor constructor) {
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
    _builder.append("public Abstract");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append("(@NotNull final ");
    Aggregate _root = entity.getRoot();
    String _name_2 = _root.getName();
    _builder.append(_name_2, "");
    _builder.append(" rootAggregate, ");
    EList<Variable> _variables_1 = constructor.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(ctx, _variables_1);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _allExceptions = ConstructorExtensions.allExceptions(constructor);
    SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(ctx, _allExceptions);
    _builder.append(_srcThrowsExceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super(rootAggregate);");
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables_2 = constructor.getVariables();
    SrcParamsAssignment _srcParamsAssignment = new SrcParamsAssignment(ctx, _variables_2);
    _builder.append(_srcParamsAssignment, "\t");
    _builder.append("\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
