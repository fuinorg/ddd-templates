package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.gen.base.SrcSetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcSetterTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
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
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved"
      + "\ncontexts cannot be resolved"
      + "\nget cannot be resolved"
      + "\nnamespaces cannot be resolved"
      + "\nget cannot be resolved"
      + "\nelements cannot be resolved"
      + "\nget cannot be resolved");
  }
  
  private SrcSetter createTesteeWithMultiplicity(final CodeSnippetContext codeSnippetContext) {
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
