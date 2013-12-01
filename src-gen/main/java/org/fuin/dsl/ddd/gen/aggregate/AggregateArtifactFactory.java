package org.fuin.dsl.ddd.gen.aggregate;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateArtifactFactory extends AbstractSource implements ArtifactFactory<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate) throws GenerateException {
    EObject _eContainer = aggregate.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".");
    String _name_1 = aggregate.getName();
    String _replace = _name_1.replace(".", "/");
    String _plus_1 = (_plus + _replace);
    final String filename = (_plus_1 + ".java");
    CharSequence _create = this.create(aggregate, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact("Aggregate", filename, _string);
    return _generatedArtifact;
  }
  
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
    _builder.append("public class ");
    String _name_1 = aggregate.getName();
    _builder.append(_name_1, "");
    _builder.append(" extends Abstract");
    String _name_2 = aggregate.getName();
    _builder.append(_name_2, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Constructor> _constructors = aggregate.getConstructors();
    CharSequence __constructorsDecl = this._constructorsDecl(aggregate, _constructors);
    _builder.append(__constructorsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Method> _methods = aggregate.getMethods();
    CharSequence __methodsDecl = this._methodsDecl(_methods);
    _builder.append(__methodsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Method> _methods_1 = aggregate.getMethods();
    CharSequence __eventMethodsDecl = this._eventMethodsDecl(_methods_1);
    _builder.append(__eventMethodsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
