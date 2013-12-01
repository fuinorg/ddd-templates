package org.fuin.dsl.ddd.gen.event;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EventArtifactFactory extends AbstractSource implements ArtifactFactory<Event> {
  private String artifactName;
  
  public Class<? extends Event> getModelType() {
    return Event.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final Event event) throws GenerateException {
    GeneratedArtifact _xblockexpression = null;
    {
      final EObject method = event.eContainer();
      final EObject container = method.eContainer();
      GeneratedArtifact _xifexpression = null;
      if ((container instanceof AbstractEntity)) {
        final AbstractEntity entity = ((AbstractEntity) container);
        EObject _eContainer = entity.eContainer();
        final Namespace ns = ((Namespace) _eContainer);
        String _name = ns.getName();
        String _plus = (_name + ".");
        String _name_1 = event.getName();
        String _plus_1 = (_plus + _name_1);
        String _replace = _plus_1.replace(".", "/");
        final String filename = (_replace + ".java");
        CharSequence _create = this.create(event, ns);
        String _string = _create.toString();
        GeneratedArtifact _generatedArtifact = new GeneratedArtifact(this.artifactName, filename, _string);
        return _generatedArtifact;
      }
      _xblockexpression = (_xifexpression);
    }
    return _xblockexpression;
  }
  
  public CharSequence create(final Event event, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(event);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = event.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("public class ");
    String _name_1 = event.getName();
    _builder.append(_name_1, "");
    _builder.append(" extends Abstract");
    String _name_2 = event.getName();
    _builder.append(_name_2, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private static final long serialVersionUID = 1L;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _name_3 = event.getName();
    _builder.append(_name_3, "	");
    _builder.append("(");
    EList<Variable> _variables = event.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables);
    _builder.append(__paramsDecl, "	");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    EList<Variable> _variables_1 = event.getVariables();
    String __superCall = this._superCall(_variables_1);
    _builder.append(__superCall, "		");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
