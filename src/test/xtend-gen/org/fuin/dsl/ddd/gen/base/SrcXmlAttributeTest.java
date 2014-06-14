package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcXmlAttribute;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcXmlAttributeTest {
  @Test
  public void testCreate() {
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
    final Variable variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
    variable.setName("AbcDefGhi");
    final SrcXmlAttribute testee = new SrcXmlAttribute(ctx, variable);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlAttribute(name = \"abc-def-ghi\")");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("javax.xml.bind.annotation.XmlAttribute");
  }
}
