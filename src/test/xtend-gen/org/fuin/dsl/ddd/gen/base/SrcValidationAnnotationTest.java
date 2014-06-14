package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.junit4.InjectWith;
import org.eclipse.xtext.junit4.XtextRunner;
import org.eclipse.xtext.junit4.util.ParseHelper;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcValidationAnnotation;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcValidationAnnotationTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreateNoArgConstraint() {
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint");
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(0);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    ctx.resolve(refReg);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@NoArgConstraint");
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("y.a.NoArgConstraint");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("a.b.c.NoArgConstraint");
  }
  
  @Test
  public void testCreateOneArgConstraint() {
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.OneArgConstraint", "a.b.c.OneArgConstraint");
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(1);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    ctx.resolve(refReg);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@OneArgConstraint(50)");
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("y.a.OneArgConstraint", "y.types.Integer");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("a.b.c.OneArgConstraint", "java.lang.Integer");
  }
  
  @Test
  public void testCreateTwoArgsConstraint() {
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.TwoArgsConstraint", "a.b.c.TwoArgsConstraint");
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(2);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    ctx.resolve(refReg);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@TwoArgsConstraint(min = 1, max = 100)");
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("y.a.TwoArgsConstraint", "y.types.Integer");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("a.b.c.TwoArgsConstraint", "java.lang.Integer");
  }
  
  private DomainModel createModel() {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context y {");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace a {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("import y.types.*");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("constraint NoArgConstraint on String {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("message \"NoArgConstraint message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("constraint OneArgConstraint on String {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("Integer expected");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("message \"OneArgConstraint message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("constraint TwoArgsConstraint on String {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("Integer min");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("Integer max");
      _builder.newLine();
      _builder.append("\t        ");
      _builder.append("message \"TwoArgsConstraint message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String strNoArgConstraint invariants NoArgConstraint");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String strOneArgConstraint invariants OneArgConstraint(50)");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String strTwoArgsConstraint invariants TwoArgsConstraint(1, 100)");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace types {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("type String");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("type Integer");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      return this.parser.parse(_builder);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
