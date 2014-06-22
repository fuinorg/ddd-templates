package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.gen.base.SrcSetters;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcSettersTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    refReg.putReference("ctx.types.Locale", "java.util.Locale");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcSetters testee = this.createTestee(ctx);
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
    _builder.newLine();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Sets: Language the name is in.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param locale Value to set.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public void setLocale(final Locale locale) {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("this.locale = locale;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("java.lang.String", "java.util.Locale", 
      "javax.validation.constraints.NotNull", "org.fuin.objects4j.common.Contract");
  }
  
  private SrcSetters createTestee(final CodeSnippetContext codeSnippetContext) {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved"
      + "\ncontexts cannot be resolved"
      + "\nget cannot be resolved"
      + "\nnamespaces cannot be resolved"
      + "\nget cannot be resolved"
      + "\nelements cannot be resolved"
      + "\nget cannot be resolved");
  }
}
