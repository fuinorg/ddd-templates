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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcSetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcSetterTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreateNoMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcSetter testee = this.createTesteeNoMultiplicity(ctx);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Sets: Human readable name.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param name Value to set.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public void setName(@NotNull final String name) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("Contract.requireArgNotNull(\"name\", name);");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("this.name = name;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("javax.validation.constraints.NotNull", "java.lang.String", 
      "org.fuin.objects4j.common.Contract");
  }
  
  @Test
  public void testCreateWithMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcSetter testee = this.createTesteeWithMultiplicity(ctx);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Sets: List of human readable names.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param names Value to set.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public void setNames(@NotNull final List<String> names) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("Contract.requireArgNotNull(\"names\", names);");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("this.names = names;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "java.util.List", 
      "java.lang.String", "org.fuin.objects4j.common.Contract");
  }
  
  private SrcSetter createTesteeNoMultiplicity(final CodeSnippetContext codeSnippetContext) {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context ctx {");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace a.b {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("import ctx.types.*");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("/** Human readable name. */");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String name");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t");
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
      _builder.append("\t");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      final DomainModel model = this.parser.parse(_builder);
      EList<Context> _contexts = model.getContexts();
      Context _get = _contexts.get(0);
      EList<Namespace> _namespaces = _get.getNamespaces();
      Namespace _get_1 = _namespaces.get(0);
      EList<AbstractElement> _elements = _get_1.getElements();
      AbstractElement _get_2 = _elements.get(0);
      final ValueObject valueObject = ((ValueObject) _get_2);
      EList<Variable> _variables = valueObject.getVariables();
      final Variable variable = _variables.get(0);
      return new SrcSetter(codeSnippetContext, "public", variable);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  private SrcSetter createTesteeWithMultiplicity(final CodeSnippetContext codeSnippetContext) {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context ctx {");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace a.b {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("import ctx.types.*");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("/** List of human readable names. */");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("String* names");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t");
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
      _builder.append("\t");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      final DomainModel model = this.parser.parse(_builder);
      EList<Context> _contexts = model.getContexts();
      Context _get = _contexts.get(0);
      EList<Namespace> _namespaces = _get.getNamespaces();
      Namespace _get_1 = _namespaces.get(0);
      EList<AbstractElement> _elements = _get_1.getElements();
      AbstractElement _get_2 = _elements.get(0);
      final ValueObject valueObject = ((ValueObject) _get_2);
      EList<Variable> _variables = valueObject.getVariables();
      final Variable variable = _variables.get(0);
      return new SrcSetter(codeSnippetContext, "public", variable);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
