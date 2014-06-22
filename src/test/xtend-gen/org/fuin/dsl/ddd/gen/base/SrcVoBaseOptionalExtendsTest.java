package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType;
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcVoBaseOptionalExtendsTest {
  @Test
  public void testString() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ExternalType base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType();
    base.setName("String");
    final SrcVoBaseOptionalExtends testee = new SrcVoBaseOptionalExtends(ctx, base);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("extends AbstractStringValueObject ");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("org.fuin.objects4j.vo.AbstractStringValueObject");
  }
  
  @Test
  public void testUUID() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ExternalType base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType();
    base.setName("UUID");
    final SrcVoBaseOptionalExtends testee = new SrcVoBaseOptionalExtends(ctx, base);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("extends AbstractUUIDVO ");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("org.fuin.ddd4j.ddd.AbstractUUIDVO");
  }
  
  @Test
  public void testInteger() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ExternalType base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType();
    base.setName("Integer");
    final SrcVoBaseOptionalExtends testee = new SrcVoBaseOptionalExtends(ctx, base);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("extends AbstractIntegerValueObject ");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("org.fuin.objects4j.vo.AbstractIntegerValueObject");
  }
  
  @Test
  public void testLong() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    final ExternalType base = DomainDrivenDesignDslFactory.eINSTANCE.createExternalType();
    base.setName("Long");
    final SrcVoBaseOptionalExtends testee = new SrcVoBaseOptionalExtends(ctx, base);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    _assertThat.isEqualTo("extends AbstractLongValueObject ");
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.contains("org.fuin.objects4j.vo.AbstractLongValueObject");
  }
}
