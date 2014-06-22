package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.gen.base.SrcGetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcGetterTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreateNoMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcGetter testee = this.createTesteeNoMultiplicity(ctx);
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
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("org.fuin.objects4j.common.NeverNull", "java.lang.String");
  }
  
  @Test
  public void testCreateWithMultiplicity() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("ctx.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcGetter testee = this.createTesteeWithMultiplicity(ctx);
    final String result = testee.toString();
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
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("org.fuin.objects4j.common.NeverNull", "java.util.List", "java.lang.String");
  }
  
  private SrcGetter createTesteeNoMultiplicity(final CodeSnippetContext codeSnippetContext) {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved"
      + "\ncontexts cannot be resolved"
      + "\nget cannot be resolved"
      + "\nnamespaces cannot be resolved"
      + "\nget cannot be resolved"
      + "\nelements cannot be resolved"
      + "\nget cannot be resolved");
  }
  
  private SrcGetter createTesteeWithMultiplicity(final CodeSnippetContext codeSnippetContext) {
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
