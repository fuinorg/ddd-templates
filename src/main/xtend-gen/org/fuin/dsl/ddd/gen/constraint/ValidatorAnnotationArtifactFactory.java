package org.fuin.dsl.ddd.gen.constraint;

import com.google.common.base.Objects;
import java.util.Map;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ValidatorAnnotationArtifactFactory extends AbstractSource<Constraint> {
  public Class<? extends Constraint> getModelType() {
    return Constraint.class;
  }
  
  public GeneratedArtifact create(final Constraint constraint, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      ConstraintTarget _target = constraint.getTarget();
      boolean _equals = Objects.equal(_target, null);
      if (_equals) {
        return null;
      }
      EObject _eContainer = constraint.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      String _plus_1 = (_plus + ".");
      String _name = constraint.getName();
      String _plus_2 = (_plus_1 + _name);
      String _replace = _plus_2.replace(".", "/");
      final String filename = (_replace + ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(constraint, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public String replaceValidatedValue(final String msg) {
    String newMsg = msg.replace("${vv_", "${validatedValue.");
    return newMsg.replace("${vv}", "${validatedValue}");
  }
  
  public CharSequence create(final Constraint c, final Namespace ns) {
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
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _doc = c.getDoc();
    String _text = StringExtensions.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@Target({ TYPE, METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })");
    _builder.newLine();
    _builder.append("@Retention(RUNTIME)");
    _builder.newLine();
    _builder.append("@Constraint(validatedBy = ");
    String _name = c.getName();
    _builder.append(_name, "");
    _builder.append("Validator.class)");
    _builder.newLineIfNotEmpty();
    _builder.append("@Documented");
    _builder.newLine();
    _builder.append("// CHECKSTYLE:OFF:LineLength");
    _builder.newLine();
    _builder.append("public @interface ");
    String _name_1 = c.getName();
    _builder.append(_name_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/** Used to create an error message. */");
    _builder.newLine();
    _builder.append("\t   ");
    _builder.append("String message() default \"");
    String _message = c.getMessage();
    String _replaceValidatedValue = this.replaceValidatedValue(_message);
    _builder.append(_replaceValidatedValue, "\t   ");
    _builder.append("\";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/** Processing groups with which the constraint declaration is associated. */\t\t");
    _builder.newLine();
    _builder.append("   ");
    _builder.append("Class<?>[] groups() default {};");
    _builder.newLine();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("/** Payload with which the the constraint declaration is associated. */");
    _builder.newLine();
    _builder.append("\t   ");
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
        String _doc_1 = _last.getDoc();
        _builder.append(_doc_1, "\t");
        _builder.newLineIfNotEmpty();
        _builder.append("\t");
        EList<Variable> _variables_2 = c.getVariables();
        Variable _last_1 = IterableExtensions.<Variable>last(_variables_2);
        String _asJavaPrimitive = this.asJavaPrimitive(_last_1);
        _builder.append(_asJavaPrimitive, "\t");
        _builder.append(" value();");
        _builder.newLineIfNotEmpty();
        _builder.append("\t");
        _builder.newLine();
      } else {
        EList<Variable> _variables_3 = c.getVariables();
        int _size_1 = _variables_3.size();
        boolean _greaterThan = (_size_1 > 1);
        if (_greaterThan) {
          {
            EList<Variable> _variables_4 = c.getVariables();
            for(final Variable v : _variables_4) {
              _builder.append("\t");
              String _doc_2 = v.getDoc();
              _builder.append(_doc_2, "\t");
              _builder.newLineIfNotEmpty();
              _builder.append("\t");
              String _asJavaPrimitive_1 = this.asJavaPrimitive(v);
              _builder.append(_asJavaPrimitive_1, "\t");
              _builder.append(" ");
              String _name_2 = v.getName();
              _builder.append(_name_2, "\t");
              _builder.append("();");
              _builder.newLineIfNotEmpty();
              _builder.append("\t");
              _builder.newLine();
            }
          }
        }
      }
    }
    _builder.append("}");
    _builder.newLine();
    _builder.append("//CHECKSTYLE:ON:LineLength");
    _builder.newLine();
    return _builder;
  }
}
