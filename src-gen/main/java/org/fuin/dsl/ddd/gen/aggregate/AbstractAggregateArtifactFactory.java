package org.fuin.dsl.ddd.gen.aggregate;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

/**
 * Generates an abstract aggregate Java class.
 */
@SuppressWarnings("all")
public class AbstractAggregateArtifactFactory extends AbstractSource implements ArtifactFactory<Aggregate> {
  private String artifactName;
  
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate) throws GenerateException {
    EObject _eContainer = aggregate.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".Abstract");
    String _name_1 = aggregate.getName();
    String _plus_1 = (_plus + _name_1);
    String _replace = _plus_1.replace(".", "/");
    final String filename = (_replace + ".java");
    CharSequence _create = this.create(aggregate, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact(this.artifactName, filename, _string);
    return _generatedArtifact;
  }
  
  /**
   * Creates the actual source code.
   */
  public CharSequence create(final Aggregate aggregate, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(aggregate);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = aggregate.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("public abstract class Abstract");
    String _name_1 = aggregate.getName();
    _builder.append(_name_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = aggregate.getVariables();
    CharSequence __varsDecl = this._varsDecl(_variables);
    _builder.append(__varsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables_1 = aggregate.getVariables();
    CharSequence __settersGetters = this._settersGetters("protected final", _variables_1);
    _builder.append(__settersGetters, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Method> _methods = aggregate.getMethods();
    CharSequence __abstractMethodsDecl = this._abstractMethodsDecl(_methods);
    _builder.append(__abstractMethodsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Method> _methods_1 = aggregate.getMethods();
    CharSequence __eventAbstractMethodsDecl = this._eventAbstractMethodsDecl(_methods_1);
    _builder.append(__eventAbstractMethodsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
