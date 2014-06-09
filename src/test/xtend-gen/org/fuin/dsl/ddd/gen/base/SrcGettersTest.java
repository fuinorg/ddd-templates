package org.fuin.dsl.ddd.gen.base;

import java.util.List;
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
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcGettersTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    refReg.putReference("ctx.types.Locale", "java.util.Locale");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final SrcGetters testee = this.createTestee(ctx);
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
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Returns: Language the name is in.");
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
    _builder.append("public Locale getLocale() {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("return locale;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _references = ctx.getReferences();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_references);
    _assertThat_1.containsOnly("ctx.types.String", "ctx.types.Locale");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_2 = Assertions.assertThat(_imports);
    _assertThat_2.containsOnly("java.lang.String", "java.util.Locale", 
      "org.fuin.objects4j.common.NeverNull");
  }
  
  private SrcGetters createTestee(final CodeSnippetContext codeSnippetContext) {
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
      _builder.append("\t\t\t");
      _builder.append("/** Language the name is in. */");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("nullable Locale locale");
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
      _builder.append("\t\t");
      _builder.append("type Locale");
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
      final List<Variable> variables = valueObject.getVariables();
      return new SrcGetters(codeSnippetContext, "public", variables);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
