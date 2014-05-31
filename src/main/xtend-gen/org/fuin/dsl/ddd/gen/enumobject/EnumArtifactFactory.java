package org.fuin.dsl.ddd.gen.enumobject;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumInstance;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EnumArtifactFactory extends AbstractSource<EnumObject> {
  public Class<? extends EnumObject> getModelType() {
    return EnumObject.class;
  }
  
  public GeneratedArtifact create(final EnumObject enu) throws GenerateException {
    try {
      EObject _eContainer = enu.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _name = enu.getName();
      String _plus_1 = (_plus + _name);
      String _replace = _plus_1.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(enu, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final EnumObject vo, final Namespace ns) {
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
    CharSequence __imports = this._imports(vo);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = vo.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("public enum ");
    String _name = vo.getName();
    _builder.append(_name, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    {
      EList<EnumInstance> _instances = vo.getInstances();
      boolean _hasElements = false;
      for(final EnumInstance in : _instances) {
        if (!_hasElements) {
          _hasElements = true;
        } else {
          _builder.appendImmediate(",", "");
        }
        String _doc_1 = in.getDoc();
        _builder.append(_doc_1, "");
        _builder.newLineIfNotEmpty();
        String _name_1 = in.getName();
        _builder.append(_name_1, "");
        _builder.append("(");
        EList<Variable> _variables = vo.getVariables();
        EList<Literal> _params = in.getParams();
        String __methodCall = this._methodCall(_variables, _params);
        _builder.append(__methodCall, "");
        _builder.append(")");
        _builder.newLineIfNotEmpty();
        _builder.append("\t\t");
      }
    }
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    CharSequence __varsDecl = this._varsDecl(vo);
    _builder.append(__varsDecl, "\t");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    String _name_2 = vo.getName();
    _builder.append(_name_2, "\t");
    _builder.append("(");
    EList<Variable> _variables_1 = vo.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_1);
    _builder.append(__paramsDecl, "\t");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    EList<Variable> _variables_2 = vo.getVariables();
    CharSequence __paramsAssignment = this._paramsAssignment(_variables_2);
    _builder.append(__paramsAssignment, "\t\t");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
