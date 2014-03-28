package org.fuin.dsl.ddd.gen.aggregate;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateDocArtifactFactory extends AbstractSource implements ArtifactFactory<Aggregate> {
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
    String _plus = (_name + ".");
    String _name_1 = aggregate.getName();
    String _plus_1 = (_plus + _name_1);
    String _replace = _plus_1.replace(".", "/");
    final String filename = (_replace + ".html");
    try {
      CharSequence _create = this.create(aggregate, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      GeneratedArtifact _generatedArtifact = new GeneratedArtifact(this.artifactName, filename, _bytes);
      return _generatedArtifact;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final Aggregate aggregate, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
    _builder.newLine();
    _builder.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<head>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<title>");
    String _name = ns.getName();
    _builder.append(_name, "		");
    _builder.append(".");
    String _name_1 = aggregate.getName();
    _builder.append(_name_1, "		");
    _builder.append("</title>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</head>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<body>");
    _builder.newLine();
    _builder.append("\t\t");
    String _name_2 = ns.getName();
    _builder.append(_name_2, "		");
    _builder.append(".");
    String _name_3 = aggregate.getName();
    _builder.append(_name_3, "		");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<table border=\"1\">");
    _builder.newLine();
    {
      EList<Variable> _variables = aggregate.getVariables();
      for(final Variable variable : _variables) {
        _builder.append("\t\t");
        _builder.append("<tr><td>");
        String _name_4 = variable.getName();
        _builder.append(_name_4, "		");
        _builder.append("</td><td>");
        Type _type = variable.getType();
        String _name_5 = _type.getName();
        _builder.append(_name_5, "		");
        _builder.append("</td><td>");
        String _doc = variable.getDoc();
        String _text = this.text(_doc);
        _builder.append(_text, "		");
        _builder.append("</td></tr>");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append("\t\t");
    _builder.append("</table>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("</body>");
    _builder.newLine();
    _builder.append("</html>");
    _builder.newLine();
    return _builder;
  }
}
