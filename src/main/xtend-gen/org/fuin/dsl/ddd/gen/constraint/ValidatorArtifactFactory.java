package org.fuin.dsl.ddd.gen.constraint;

import com.google.common.base.Objects;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcAll;
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.ConstraintTargetExtensions;
import org.fuin.dsl.ddd.gen.extensions.EObjectExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class ValidatorArtifactFactory extends AbstractSource<Constraint> {
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
      String _name = constraint.getName();
      final String className = (_name + "Validator");
      EObject _eContainer = constraint.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      String _asPackage = this.asPackage(ns);
      String _plus = (_asPackage + ".");
      final String fqn = (_plus + className);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(constraint);
      String _plus_1 = (_uniqueName + "Validator");
      refReg.putReference(_plus_1, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
      this.addImports(ctx);
      this.addReferences(ctx, constraint);
      ctx.resolve(refReg);
      String _artifactName = this.getArtifactName();
      String _pkg = this.getPkg();
      String _create = this.create(ctx, constraint, _pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void addImports(final CodeSnippetContext ctx) {
    ctx.requiresImport("javax.enterprise.context.ApplicationScoped");
    ctx.requiresImport("javax.validation.Validator");
    ctx.requiresImport("javax.validation.ConstraintValidator");
    ctx.requiresImport("javax.validation.ConstraintValidatorContext");
  }
  
  public void addReferences(final CodeSnippetContext ctx, final Constraint constraint) {
    String _uniqueName = AbstractElementExtensions.uniqueName(constraint);
    ctx.requiresReference(_uniqueName);
    ConstraintTarget _target = constraint.getTarget();
    String _uniqueName_1 = this.uniqueName(_target);
    ctx.requiresReference(_uniqueName_1);
    ConstraintTarget _target_1 = constraint.getTarget();
    final List<Variable> variables = ConstraintTargetExtensions.getVariables(_target_1);
    for (final Variable variable : variables) {
      Type _type = variable.getType();
      String _uniqueName_2 = AbstractElementExtensions.uniqueName(_type);
      ctx.requiresReference(_uniqueName_2);
    }
    org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception = constraint.getException();
    boolean _notEquals = (!Objects.equal(_exception, null));
    if (_notEquals) {
      org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception _exception_1 = constraint.getException();
      String _uniqueName_3 = AbstractElementExtensions.uniqueName(_exception_1);
      ctx.requiresReference(_uniqueName_3);
    }
  }
  
  public String create(final SimpleCodeSnippetContext ctx, final Constraint c, final String pkg, final String className) {
    String _xblockexpression = null;
    {
      ConstraintTarget _target = c.getTarget();
      final String targetName = ConstraintTargetExtensions.getName(_target);
      ConstraintTarget _target_1 = c.getTarget();
      final List<Variable> variables = ConstraintTargetExtensions.getVariables(_target_1);
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("/** ");
      String _doc = c.getDoc();
      String _text = StringExtensions.text(_doc);
      _builder.append(_text, "");
      _builder.append(" */");
      _builder.newLineIfNotEmpty();
      _builder.append("// CHECKSTYLE:OFF:LineLength");
      _builder.newLine();
      _builder.append("public final class ");
      _builder.append(className, "");
      _builder.append(" implements ConstraintValidator<");
      String _name = c.getName();
      _builder.append(_name, "");
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
      String _name_1 = c.getName();
      _builder.append(_name_1, "    ");
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
          String _name_2 = _exception_1.getName();
          _builder.append(_name_2, "\t ");
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
          String _name_3 = _exception_2.getName();
          _builder.append(_name_3, "\t");
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
          String _name_4 = _exception_3.getName();
          _builder.append(_name_4, "\t\t\t");
          _builder.append("(");
          {
            boolean _hasElements = false;
            for(final Variable v : variables) {
              if (!_hasElements) {
                _hasElements = true;
              } else {
                _builder.appendImmediate(", ", "\t\t\t");
              }
              SrcInvokeGetter _srcInvokeGetter = new SrcInvokeGetter(ctx, "obj", v);
              String _string = _srcInvokeGetter.toString();
              _builder.append(_string, "\t\t\t");
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
      final String src = _builder.toString();
      String _copyrightHeader = this.getCopyrightHeader();
      Set<String> _imports = ctx.getImports();
      SrcAll _srcAll = new SrcAll(_copyrightHeader, pkg, _imports, src);
      _xblockexpression = _srcAll.toString();
    }
    return _xblockexpression;
  }
  
  /**
   * Returns the unique name of the constraint target.
   * 
   * @param target Target to return a unique name for.
   * 
   * @return Unique name in the context/namespace.
   */
  public String uniqueName(final ConstraintTarget target) {
    boolean _equals = Objects.equal(target, null);
    if (_equals) {
      throw new IllegalArgumentException("argument \'target\' cannot be null");
    }
    Context _context = EObjectExtensions.getContext(target);
    String _name = _context.getName();
    Namespace _namespace = EObjectExtensions.getNamespace(target);
    String _name_1 = _namespace.getName();
    String _name_2 = ConstraintTargetExtensions.getName(target);
    return Utils.separated(".", _name, _name_1, _name_2);
  }
}
