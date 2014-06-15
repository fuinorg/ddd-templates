package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamAssignment;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcParamAssignmentTest {
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext codeSnippetContext = new SimpleCodeSnippetContext(refReg);
    final Variable variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
    variable.setName("a");
    final SrcParamAssignment testee = new SrcParamAssignment(codeSnippetContext, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("this.a = a;");
    Set<String> _imports = codeSnippetContext.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.isEmpty();
  }
}
