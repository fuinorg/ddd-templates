package org.fuin.dsl.ddd.gen.aggregate;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

/**
 * Generates an abstract aggregate Java class.
 */
@SuppressWarnings("all")
public class AbstractAggregateArtifactFactory extends AbstractSource<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate) throws GenerateException {
    try {
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".Abstract");
      String _name = aggregate.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(aggregate, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  /**
   * Creates the actual source code.
   */
  public CharSequence create(final Aggregate aggregate, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    String _copyrightHeader = this.getCopyrightHeader();
    _builder.append(_copyrightHeader, "");
    _builder.append(" ");
    _builder.newLineIfNotEmpty();
    _builder.append("package ");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(aggregate);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __typeDoc = this._typeDoc(aggregate);
    _builder.append(__typeDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public abstract class Abstract");
    String _name = aggregate.getName();
    _builder.append(_name, "");
    _builder.append(" extends AbstractAggregateRoot<");
    AggregateId _idType = aggregate.getIdType();
    String _name_1 = _idType.getName();
    _builder.append(_name_1, "");
    _builder.append("> {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    AggregateId _idType_1 = aggregate.getIdType();
    String _name_2 = _idType_1.getName();
    _builder.append(_name_2, "\t");
    _builder.append(" id;");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __varsDecl = this._varsDecl(aggregate);
    _builder.append(__varsDecl, "\t");
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
    AggregateId _idType_2 = aggregate.getIdType();
    String _name_3 = _idType_2.getName();
    _builder.append(_name_3, "\t\t");
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
    AggregateId _idType_3 = aggregate.getIdType();
    String _name_4 = _idType_3.getName();
    _builder.append(_name_4, "\t");
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
    _builder.append("/**");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* Sets the aggregate identifier.");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* ");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* @param id Unique aggregate identifier.");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("protected final void setId(@NotNull final ");
    AggregateId _idType_4 = aggregate.getIdType();
    String _name_5 = _idType_4.getName();
    _builder.append(_name_5, "\t");
    _builder.append(" id) {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("Contract.requireArgNotNull(\"id\", id);");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("this.id = id;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = aggregate.getVariables();
    CharSequence __settersGetters = this._settersGetters("protected final", _variables);
    _builder.append(__settersGetters, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __abstractChildEntityLocatorMethods = this._abstractChildEntityLocatorMethods(aggregate);
    _builder.append(__abstractChildEntityLocatorMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __eventAbstractMethodsDecl = this._eventAbstractMethodsDecl(aggregate);
    _builder.append(__eventAbstractMethodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
