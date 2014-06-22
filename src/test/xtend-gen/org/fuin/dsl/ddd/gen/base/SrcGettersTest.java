package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.gen.base.SrcGetters;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcGettersTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    refReg.putReference("ctx.types.Locale", "java.util.Locale");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcGetters testee = this.createTestee(ctx);
    final String result = testee.toString();
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
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("java.lang.String", "java.util.Locale", 
      "org.fuin.objects4j.common.NeverNull");
  }
  
  private SrcGetters createTestee(final CodeSnippetContext codeSnippetContext) {
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
