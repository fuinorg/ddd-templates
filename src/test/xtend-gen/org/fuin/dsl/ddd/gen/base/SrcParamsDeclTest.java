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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcParamsDeclTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("y.types.String", "java.lang.String");
    refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final SrcParamsDecl testee = new SrcParamsDecl(ctx, _variables);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo(
      "@NoArgConstraint @NotNull final String a, @NoArgConstraint final String b, @NotNull final String c, final String d");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("a.b.c.NoArgConstraint", "java.lang.String", 
      "javax.validation.constraints.NotNull");
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
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String a invariants NoArgConstraint");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("nullable String b invariants NoArgConstraint");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String c");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("nullable String d\t\t\t\t\t\t");
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
