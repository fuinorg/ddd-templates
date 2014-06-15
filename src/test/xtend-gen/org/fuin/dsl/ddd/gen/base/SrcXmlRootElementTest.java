package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.gen.base.SrcXmlRootElement;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcXmlRootElementTest {
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final SrcXmlRootElement testee = new SrcXmlRootElement(ctx, "AbcDefGhi");
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlRootElement(name = \"abc-def-ghi\")");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("javax.xml.bind.annotation.XmlRootElement");
  }
}
