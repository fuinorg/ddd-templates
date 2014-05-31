package org.fuin.dsl.ddd.gen.constraint;

import com.google.common.base.Objects;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class ValidatorArtifactFactory extends AbstractSource<Constraint> {
  public Class<? extends Constraint> getModelType() {
    return Constraint.class;
  }
  
  public GeneratedArtifact create(final Constraint constraint) throws GenerateException {
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
      String _name = constraint.getName();
      String _plus_1 = (_plus + _name);
      String _plus_2 = (_plus_1 + "Validator");
      String _replace = _plus_2.replace(".", "/");
      final String filename = (_replace + 
        ".java");
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(constraint, ns);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public CharSequence create(final Constraint c, final Namespace ns) {
    CharSequence _xblockexpression = null;
    {
      ConstraintTarget target = c.getTarget();
      Set<String> imports = new HashSet<String>();
      Set<String> _createImportSet = this.createImportSet(c);
      imports.addAll(_createImportSet);
      String targetName = null;
      List<Variable> variables = null;
      if ((target instanceof ValueObject)) {
        ValueObject vo = ((ValueObject) target);
        String _name = vo.getName();
        targetName = _name;
        Set<String> _createImportSet_1 = this.createImportSet(((AbstractElement) target));
        imports.addAll(_createImportSet_1);
        EList<Variable> _variables = vo.getVariables();
        variables = _variables;
      } else {
        if ((target instanceof ExternalType)) {
          ExternalType type = ((ExternalType) target);
          String _name_1 = type.getName();
          targetName = _name_1;
          ArrayList<Variable> _arrayList = new ArrayList<Variable>();
          variables = _arrayList;
        } else {
          String _string = target.toString();
          targetName = _string;
          ArrayList<Variable> _arrayList_1 = new ArrayList<Variable>();
          variables = _arrayList_1;
        }
      }
      StringConcatenation _builder = new StringConcatenation();
      String _copyrightHeader = this.getCopyrightHeader();
      _builder.append(_copyrightHeader, "");
      _builder.append(" ");
      _builder.newLineIfNotEmpty();
      _builder.append("package ");
      String _asPackage = this.asPackage(ns);
      _builder.append(_asPackage, "");
      _builder.append(";");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("import javax.validation.Validator;");
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
      _builder.append("// CHECKSTYLE:OFF:LineLength");
      _builder.newLine();
      _builder.append("public final class ");
      String _name_2 = c.getName();
      _builder.append(_name_2, "");
      _builder.append("Validator implements ConstraintValidator<");
      String _name_3 = c.getName();
      _builder.append(_name_3, "");
      _builder.append(", ");
      _builder.append(targetName, "");
      _builder.append("> {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("// CHECKSTYLE:ON:LineLength");
      _builder.newLine();
      _builder.newLine();
      _builder.append("    ");
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public final void initialize(final ");
      String _name_4 = c.getName();
      _builder.append(_name_4, "    ");
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
      _builder.append("@Override");
      _builder.newLine();
      _builder.append("    ");
      _builder.append("public final boolean isValid(final ");
      _builder.append(targetName, "    ");
      _builder.append(" object, final ConstraintValidatorContext ctx) {");
      _builder.newLineIfNotEmpty();
      _builder.append("        ");
      _builder.append("// TODO Implement!");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("return true;");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      {
        org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = c.getException();
        boolean _notEquals = (!Objects.equal(_exception, null));
        if (_notEquals) {
          _builder.append("\t");
          _builder.append("/**");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* Verifies if the argument is valid an throws an exception otherwise.");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* ");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* @param validator Validator to use.");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* @param obj Object to validate.");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* ");
          _builder.newLine();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("* @throws ");
          org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_1 = c.getException();
          String _name_5 = _exception_1.getName();
          _builder.append(_name_5, "\t ");
          _builder.append(" The constraint was violated.");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append(" ");
          _builder.append("*/");
          _builder.newLine();
          _builder.append("\t");
          _builder.append("public static void requireValid(final Validator validator, final ");
          _builder.append(targetName, "\t");
          _builder.append(" obj) throws ");
          org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_2 = c.getException();
          String _name_6 = _exception_2.getName();
          _builder.append(_name_6, "\t");
          _builder.append(" {");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("\t");
          _builder.append("if (validator .validate(obj).size() > 0) {");
          _builder.newLine();
          _builder.append("\t");
          _builder.append("\t\t");
          _builder.append("throw new ");
          org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_3 = c.getException();
          String _name_7 = _exception_3.getName();
          _builder.append(_name_7, "\t\t\t");
          _builder.append("(");
          {
            boolean _hasElements = false;
            for(final Variable v : variables) {
              if (!_hasElements) {
                _hasElements = true;
              } else {
                _builder.appendImmediate(", ", "\t\t\t");
              }
              CharSequence __get = this._get("obj", v);
              _builder.append(__get, "\t\t\t");
            }
          }
          _builder.append(");");
          _builder.newLineIfNotEmpty();
          _builder.append("\t");
          _builder.append("\t");
          _builder.append("}");
          _builder.newLine();
          _builder.append("\t");
          _builder.append("}");
          _builder.newLine();
          _builder.append("\t");
          _builder.newLine();
        }
      }
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _xblockexpression = _builder;
    }
    return _xblockexpression;
  }
}
