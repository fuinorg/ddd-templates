package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcInvokeGetterTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testNullObjName() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext codeSnippetContext = new SimpleCodeSnippetContext(refReg);
    final SrcInvokeGetter testee = this.createTestee(codeSnippetContext, "ctx", "ns", "MyValueObject", null, "a");
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("getA()");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = codeSnippetContext.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.isEmpty();
  }
  
  @Test
  public void testWithObjName() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext codeSnippetContext = new SimpleCodeSnippetContext(refReg);
    final SrcInvokeGetter testee = this.createTestee(codeSnippetContext, "ctx", "ns", "MyValueObject", "x", "a");
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("x.getA()");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = codeSnippetContext.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.isEmpty();
  }
  
  private SrcInvokeGetter createTestee(final CodeSnippetContext codeSnippetContext, final String ctx, final String ns, final String type, final String objName, final String varName) {
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
