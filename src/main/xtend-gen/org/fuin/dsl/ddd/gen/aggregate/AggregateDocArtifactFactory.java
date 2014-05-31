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
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AggregateDocArtifactFactory extends AbstractSource<Aggregate> {
  public Class<? extends Aggregate> getModelType() {
    return Aggregate.class;
  }
  
  public GeneratedArtifact create(final Aggregate aggregate) throws GenerateException {
    try {
      EObject _eContainer = aggregate.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = aggregate.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".html");
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
    _builder.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">");
    _builder.newLine();
    _builder.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<head>");
    _builder.newLine();
    _builder.append("\t\t");
    _builder.append("<title>");
    String _asPackage = this.asPackage(ns);
    _builder.append(_asPackage, "\t\t");
    _builder.append(".");
    String _name = aggregate.getName();
    _builder.append(_name, "\t\t");
    _builder.append("</title>");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("</head>");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("<body>");
    _builder.newLine();
    _builder.append("\t\t");
    String _asPackage_1 = this.asPackage(ns);
    _builder.append(_asPackage_1, "\t\t");
    _builder.append(".");
    String _name_1 = aggregate.getName();
    _builder.append(_name_1, "\t\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("<table border=\"1\">");
    _builder.newLine();
    {
      EList<Variable> _variables = aggregate.getVariables();
      for(final Variable variable : _variables) {
        _builder.append("\t\t");
        _builder.append("<tr><td>");
        String _name_2 = variable.getName();
        _builder.append(_name_2, "\t\t");
        _builder.append("</td><td>");
        Type _type = variable.getType();
        String _name_3 = _type.getName();
        _builder.append(_name_3, "\t\t");
        _builder.append("</td><td>");
        String _doc = variable.getDoc();
        String _text = this.text(_doc);
        _builder.append(_text, "\t\t");
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