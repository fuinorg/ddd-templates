package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcXmlAttributeOrElement;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcXmlAttributeOrElementTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreateAggregateId() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Aggregate aggregate = DomainModelExtensions.<Aggregate>find(_createModel, Aggregate.class, "MyAggregate");
    EList<Variable> _variables = aggregate.getVariables();
    final Variable idVar = _variables.get(0);
    final SrcXmlAttributeOrElement testeeId = new SrcXmlAttributeOrElement(ctx, idVar);
    final String resultId = testeeId.toString();
    StringAssert _assertThat = Assertions.assertThat(resultId);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlAttribute(name = \"id\")");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.xml.bind.annotation.XmlAttribute");
  }
  
  @Test
  public void testCreateValueObject() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.types.String", "java.lang.String");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Aggregate aggregate = DomainModelExtensions.<Aggregate>find(_createModel, Aggregate.class, "MyAggregate");
    EList<Variable> _variables = aggregate.getVariables();
    final Variable voVar = _variables.get(1);
    final SrcXmlAttributeOrElement testeeVo = new SrcXmlAttributeOrElement(ctx, voVar);
    final String resultVo = testeeVo.toString();
    StringAssert _assertThat = Assertions.assertThat(resultVo);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("@XmlElement(name = \"vo\")");
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.xml.bind.annotation.XmlElement");
  }
  
  private DomainModel createModel() {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved");
  }
}
