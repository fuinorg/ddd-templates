package org.fuin.dsl.ddd.gen.enumgen;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumInstance;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Literal;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class EnumSource extends AbstractSource implements ArtifactFactory<EnumObject> {
  public Class<? extends EnumObject> getModelType() {
    return EnumObject.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final EnumObject enu) throws GenerateException {
    EObject _eContainer = enu.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".");
    String _name_1 = enu.getName();
    String _plus_1 = (_plus + _name_1);
    String _replace = _plus_1.replace(".", "/");
    String filename = (_replace + ".java");
    CharSequence _create = this.create(enu, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact("Enum", filename, _string);
    return _generatedArtifact;
  }
  
  public CharSequence create(final EnumObject vo, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
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
    String _name_1 = vo.getName();
    _builder.append(_name_1, "");
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
        String _name_2 = in.getName();
        _builder.append(_name_2, "");
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
    EList<Variable> _variables_1 = vo.getVariables();
    CharSequence __varsDecl = this._varsDecl(_variables_1);
    _builder.append(__varsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private ");
    String _name_3 = vo.getName();
    _builder.append(_name_3, "	");
    _builder.append("(");
    EList<Variable> _variables_2 = vo.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_2);
    _builder.append(__paramsDecl, "	");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    EList<Variable> _variables_3 = vo.getVariables();
    CharSequence __paramsAssignment = this._paramsAssignment(_variables_3);
    _builder.append(__paramsAssignment, "		");
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
