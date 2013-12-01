package org.fuin.dsl.ddd.gen.constraint;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Message;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ValidatorAnnotationArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {
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
    String _name_1 = constraint.getName();
    String _plus_1 = (_plus + _name_1);
    String _replace = _plus_1.replace(".", "/");
    final String filename = (_replace + ".java");
    CharSequence _create = this.create(constraint, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact("ValidatorAnnotation", filename, _string);
    return _generatedArtifact;
  }
  
  public CharSequence create(final Constraint c, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("import static java.lang.annotation.ElementType.*;");
    _builder.newLine();
    _builder.append("import static java.lang.annotation.RetentionPolicy.*;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("import java.lang.annotation.Documented;");
    _builder.newLine();
    _builder.append("import java.lang.annotation.Retention;");
    _builder.newLine();
    _builder.append("import java.lang.annotation.Target;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("import javax.validation.Constraint;");
    _builder.newLine();
    _builder.append("import javax.validation.Payload;");
    _builder.newLine();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = c.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("@Target( { METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })");
    _builder.newLine();
    _builder.append("@Retention(RUNTIME)");
    _builder.newLine();
    _builder.append("@Constraint(validatedBy = ");
    String _name_1 = c.getName();
    _builder.append(_name_1, "");
    _builder.append("Validator.class)");
    _builder.newLineIfNotEmpty();
    _builder.append("@Documented");
    _builder.newLine();
    _builder.append("public @interface ");
    String _name_2 = c.getName();
    _builder.append(_name_2, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("String message() default \"");
    Message _message = c.getMessage();
    String _text_1 = _message.getText();
    _builder.append(_text_1, "    ");
    _builder.append("\";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("Class<?>[] groups() default {};");
    _builder.newLine();
    _builder.newLine();
    _builder.append("    ");
    _builder.append("Class<? extends Payload>[] payload() default {};");
    _builder.newLine();
    _builder.newLine();
    {
      EList<Variable> _variables = c.getVariables();
      int _size = _variables.size();
      boolean _equals = (_size == 1);
      if (_equals) {
        _builder.append("\t");
        EList<Variable> _variables_1 = c.getVariables();
        Variable _last = IterableExtensions.<Variable>last(_variables_1);
        String _asJavaPrimitive = this.asJavaPrimitive(_last);
        _builder.append(_asJavaPrimitive, "	");
        _builder.append(" value();");
        _builder.newLineIfNotEmpty();
      } else {
        EList<Variable> _variables_2 = c.getVariables();
        int _size_1 = _variables_2.size();
        boolean _greaterThan = (_size_1 > 1);
        if (_greaterThan) {
          {
            EList<Variable> _variables_3 = c.getVariables();
            for(final Variable v : _variables_3) {
              _builder.append("\t");
              String _asJavaPrimitive_1 = this.asJavaPrimitive(v);
              _builder.append(_asJavaPrimitive_1, "	");
              _builder.append(" ");
              String _name_3 = v.getName();
              _builder.append(_name_3, "	");
              _builder.append("();");
              _builder.newLineIfNotEmpty();
            }
          }
        }
      }
    }
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
