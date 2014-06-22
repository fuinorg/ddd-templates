package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamDecl;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcParamDeclTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreateNotNullWithConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(0);
    final SrcParamDecl testee = new SrcParamDecl(ctx, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@NoArgConstraint @NotNull final String a");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.NoArgConstraint", "java.lang.String", "javax.validation.constraints.NotNull");
  }
  
  @Test
  public void testCreateNullableWithConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(1);
    final SrcParamDecl testee = new SrcParamDecl(ctx, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@NoArgConstraint final String b");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.NoArgConstraint", "java.lang.String");
  }
  
  @Test
  public void testCreateNotNullWithoutConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(2);
    final SrcParamDecl testee = new SrcParamDecl(ctx, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("@NotNull final String c");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("java.lang.String", "javax.validation.constraints.NotNull");
  }
  
  @Test
  public void testCreateNullableWithoutConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(3);
    final SrcParamDecl testee = new SrcParamDecl(ctx, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("final String d");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("java.lang.String");
  }
  
  private DomainModel createModel() {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved");
  }
}
