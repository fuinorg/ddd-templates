package org.fuin.dsl.ddd.gen.aggregate;

import java.util.List;
import java.util.Map;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraints;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.extensions.CollectionExtensions;
import org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateArtifactFactory extends AbstractSource<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
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
    _builder.append("public final class ");
    String _name = aggregate.getName();
    _builder.append(_name, "");
    _builder.append(" extends Abstract");
    String _name_1 = aggregate.getName();
    _builder.append(_name_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/**");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("* Default constructor for loading the aggregate root from history. ");
    _builder.newLine();
    _builder.append("\t ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _name_2 = aggregate.getName();
    _builder.append(_name_2, "\t");
    _builder.append("() {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __constructorsDecl = this._constructorsDecl(aggregate);
    _builder.append(__constructorsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __childEntityLocatorMethods = this._childEntityLocatorMethods(aggregate);
    _builder.append(__childEntityLocatorMethods, "\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    CharSequence __methodsDecl = this._methodsDecl(aggregate);
    _builder.append(__methodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __eventMethodsDecl = this._eventMethodsDecl(aggregate);
    _builder.append(__eventMethodsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public CharSequence _constructorDecl(final String internalTypeName, final List<Variable> variables, final Constraints constraints) {
    StringConcatenation _builder = new StringConcatenation();
    CharSequence __methodDoc = this._methodDoc("Constructor with all data.", variables, null);
    _builder.append(__methodDoc, "");
    _builder.newLineIfNotEmpty();
    _builder.append("public ");
    _builder.append(internalTypeName, "");
    _builder.append("(");
    List<Variable> _nullSafe = CollectionExtensions.<Variable>nullSafe(variables);
    CharSequence __paramsDecl = this._paramsDecl(_nullSafe);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<String> _exceptionList = ConstraintsExtensions.exceptionList(constraints);
    CharSequence __exceptions = this._exceptions(_exceptionList);
    _builder.append(__exceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Implement!");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
