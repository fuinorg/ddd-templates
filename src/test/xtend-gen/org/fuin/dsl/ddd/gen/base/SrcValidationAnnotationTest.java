package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
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

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcValidationAnnotationTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreateNoArgConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(0);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@NoArgConstraint");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.NoArgConstraint");
  }
  
  @Test
  public void testCreateOneArgConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.OneArgConstraint", "a.b.c.OneArgConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(1);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@OneArgConstraint(50)");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.OneArgConstraint", "java.lang.Integer");
  }
  
  @Test
  public void testCreateTwoArgsConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.types.Integer", "java.lang.Integer");
    refReg.putReference("y.a.TwoArgsConstraint", "a.b.c.TwoArgsConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(2);
    Invariants _invariants = variable.getInvariants();
    EList<ConstraintCall> _calls = _invariants.getCalls();
    final ConstraintCall constraintCall = _calls.get(0);
    final SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintCall);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@TwoArgsConstraint(min = 1, max = 100)");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.TwoArgsConstraint", "java.lang.Integer");
  }
  
  private DomainModel createModel() {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved");
  }
}
