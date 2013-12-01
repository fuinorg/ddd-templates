package org.fuin.dsl.ddd.gen.constraint;

import java.util.HashSet;
import java.util.Set;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ValidatorArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {
  private String artifactName;
  
  public Class<? extends Constraint> getModelType() {
    return Constraint.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final Constraint constraint) throws GenerateException {
    EObject _eContainer = constraint.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".");
    String _name_1 = constraint.getName();
    String _plus_1 = (_plus + _name_1);
    String _plus_2 = (_plus_1 + "Validator");
    String _replace = _plus_2.replace(".", "/");
    final String filename = (_replace + ".java");
    CharSequence _create = this.create(constraint, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact(this.artifactName, filename, _string);
    return _generatedArtifact;
  }
  
  public CharSequence create(final Constraint c, final Namespace ns) {
    CharSequence _xblockexpression = null;
    {
      ConstraintTarget target = c.getTarget();
      HashSet<String> _hashSet = new HashSet<String>();
      Set<String> imports = _hashSet;
      Set<String> _createImportSet = this.createImportSet(c);
      imports.addAll(_createImportSet);
      String targetName = null;
      if ((target instanceof ExternalType)) {
        String _name = ((ExternalType) target).getName();
        targetName = _name;
        Set<String> _createImportSet_1 = this.createImportSet(((ExternalType) target));
        imports.addAll(_createImportSet_1);
      } else {
        if ((target instanceof ValueObject)) {
          String _name_1 = ((ValueObject) target).getName();
          targetName = _name_1;
          Set<String> _createImportSet_2 = this.createImportSet(((ValueObject) target));
          imports.addAll(_createImportSet_2);
        } else {
          String _string = target.toString();
          targetName = _string;
        }
      }
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("package ");
      String _name_2 = ns.getName();
      _builder.append(_name_2, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("import javax.validation.ConstraintValidator;");
      _builder.newLine();
      _builder.append("import javax.validation.ConstraintValidatorContext;");
      _builder.newLine();
      {
        for(final String imp : imports) {
          _builder.append("import ");
          _builder.append(imp, "");
          _builder.append(";");
          _builder.newLineIfNotEmpty();
        }
      }
      _builder.newLine();
      _builder.append("/** ");
      String _doc = c.getDoc();
      String _text = this.text(_doc);
      _builder.append(_text, "");
      _builder.append(" */");
      _builder.newLineIfNotEmpty();
      _builder.append("public class ");
      String _name_3 = c.getName();
      _builder.append(_name_3, "");
      _builder.append("Validator extends Abstract");
      String _name_4 = c.getName();
      _builder.append(_name_4, "");
      _builder.append("Validator {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public void initialize(");
      String _name_5 = c.getName();
      _builder.append(_name_5, "    ");
      _builder.append(" annotation) {");
      _builder.newLineIfNotEmpty();
      _builder.append("        ");
      _builder.append("// TODO Implement!");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public boolean isValid(");
      _builder.append(targetName, "    ");
      _builder.append(" object, ConstraintValidatorContext ctx) {");
      _builder.newLineIfNotEmpty();
      _builder.append("        ");
      _builder.append("// TODO Implement!");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return true;");
      _builder.newLine();
      _builder.append("  ");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      _xblockexpression = (_builder);
    }
    return _xblockexpression;
  }
}
