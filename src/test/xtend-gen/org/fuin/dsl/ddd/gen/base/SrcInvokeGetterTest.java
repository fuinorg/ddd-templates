package org.fuin.dsl.ddd.gen.base;

import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.junit4.InjectWith;
import org.eclipse.xtext.junit4.XtextRunner;
import org.eclipse.xtext.junit4.util.ParseHelper;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Context;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcInvokeGetterTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
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
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context ");
      _builder.append(ctx, "");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.append("namespace ");
      _builder.append(ns, "\t");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("value-object ");
      _builder.append(type, "\t\t");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}\t ");
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      final DomainModel model = this.parser.parse(_builder);
      EList<Context> _contexts = model.getContexts();
      Context _get = _contexts.get(0);
      EList<Namespace> _namespaces = _get.getNamespaces();
      Namespace _get_1 = _namespaces.get(0);
      EList<AbstractElement> _elements = _get_1.getElements();
      AbstractElement _get_2 = _elements.get(0);
      final ValueObject valueObject = ((ValueObject) _get_2);
      final Variable variable = DomainDrivenDesignDslFactory.eINSTANCE.createVariable();
      variable.setName(varName);
      variable.setType(valueObject);
      return new SrcInvokeGetter(codeSnippetContext, objName, variable);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
