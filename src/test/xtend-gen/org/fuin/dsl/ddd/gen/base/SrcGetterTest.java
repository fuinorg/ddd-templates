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
import org.fuin.dsl.ddd.gen.base.SrcGetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcGetterTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreateNoMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SrcGetter testee = this.createTesteeNoMultiplicity(ctx);
    final String result = testee.toString();
    ctx.resolve(refReg);
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns: Human readable name.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Current value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("@NeverNull");
    _builder.newLine();
    _builder.append("public String getName() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return name;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("ctx.types.String");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("org.fuin.objects4j.common.NeverNull", "java.lang.String");
  }
  
  @Test
  public void testCreateWithMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SrcGetter testee = this.createTesteeWithMultiplicity(ctx);
    final String result = testee.toString();
    ctx.resolve(refReg);
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns: List of human readable names.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @return Current value.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("@NeverNull");
    _builder.newLine();
    _builder.append("public List<String> getNames() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return names;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("ctx.types.String");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("org.fuin.objects4j.common.NeverNull", "java.util.List", "java.lang.String");
  }
  
  private SrcGetter createTesteeNoMultiplicity(final CodeSnippetContext codeSnippetContext) {
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
      return new SrcGetter(codeSnippetContext, "public", variable);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  private SrcGetter createTesteeWithMultiplicity(final CodeSnippetContext codeSnippetContext) {
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
      return new SrcGetter(codeSnippetContext, "public", variable);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
