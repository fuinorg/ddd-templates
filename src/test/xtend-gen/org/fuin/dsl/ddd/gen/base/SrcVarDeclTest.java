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
import org.fuin.dsl.ddd.gen.base.SrcVarDecl;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcVarDeclTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreateWithConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("a.types.String", "java.lang.String");
    refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(0);
    final SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@AnyConstraint");
    _builder.newLine();
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("private String str;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "x.y.z.AnyConstraint", 
      "java.lang.String");
  }
  
  @Test
  public void testCreateWithoutConstraint() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("a.types.String", "java.lang.String");
    refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(1);
    final SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("private String str2;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "java.lang.String");
  }
  
  @Test
  public void testCreateWithoutConstraintNullable() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("a.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(2);
    final SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("private String str3;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("java.lang.String");
  }
  
  @Test
  public void testCreateWithXml() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("a.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Variable> _variables = valueObject.getVariables();
    final Variable variable = _variables.get(3);
    final SrcVarDecl testee = new SrcVarDecl(ctx, "private", true, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@NotNull");
    _builder.newLine();
    _builder.append("@XmlElement(name = \"abc-def-ghi\")");
    _builder.newLine();
    _builder.append("private String abcDefGhi;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", 
      "javax.xml.bind.annotation.XmlElement", "java.lang.String");
  }
  
  private DomainModel createModel() {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context a {");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace b {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("import a.types.*");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("constraint AnyConstraint on String {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("message \"message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String str invariants AnyConstraint");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String str2");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("nullable String str3");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String abcDefGhi");
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
