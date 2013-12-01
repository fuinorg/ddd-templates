package org.fuin.dsl.ddd.gen.constraint;

import java.util.List;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ExceptionArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {
  public Class<? extends Constraint> getModelType() {
    return Constraint.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final Constraint constraint) throws GenerateException {
    EObject _eContainer = constraint.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".");
    String _exception = constraint.getException();
    String _plus_1 = (_plus + _exception);
    String _replace = _plus_1.replace(".", "/");
    final String filename = (_replace + ".java");
    CharSequence _create = this.create(constraint, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact("Exception", filename, _string);
    return _generatedArtifact;
  }
  
  public CharSequence create(final Constraint constr, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(constr);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = constr.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("public final class ");
    String _exception = constr.getException();
    _builder.append(_exception, "");
    _builder.append(" extends Abstract");
    String _exception_1 = constr.getException();
    _builder.append(_exception_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("private static final long serialVersionUID = 1L;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public ");
    String _exception_2 = constr.getException();
    _builder.append(_exception_2, "	");
    _builder.append("(");
    List<Variable> _allVariables = this.allVariables(constr);
    CharSequence __paramsDecl = this._paramsDecl(_allVariables);
    _builder.append(__paramsDecl, "	");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    List<Variable> _allVariables_1 = this.allVariables(constr);
    String __superCall = this._superCall(_allVariables_1);
    _builder.append(__superCall, "		");
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
