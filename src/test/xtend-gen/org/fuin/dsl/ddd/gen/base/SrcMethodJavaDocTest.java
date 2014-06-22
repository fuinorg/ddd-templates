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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.gen.base.SrcMethodJavaDoc;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcMethodJavaDocTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final ValueObject valueObject = DomainModelExtensions.<ValueObject>find(_createModel, ValueObject.class, "MyValueObject");
    EList<Method> _methods = valueObject.getMethods();
    final Method method = _methods.get(0);
    final SrcMethodJavaDoc testee = new SrcMethodJavaDoc(ctx, method);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* This method does cool things.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param a Abc.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param b Def.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @throws WhateverException Argh...");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.isEmpty();
  }
  
  private DomainModel createModel() {
    try {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("context a {");
      _builder.newLine();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      _builder.append("namespace b {");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("type String");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("type Integer");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("value-object MyValueObject {");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("/**");
      _builder.newLine();
      _builder.append("\t\t\t ");
      _builder.append("* This method does cool things.");
      _builder.newLine();
      _builder.append("\t\t\t ");
      _builder.append("*/");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("method whatever {");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("/** Abc. */");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("String a");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("/** Def. */");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("Integer b");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("constraints {");
      _builder.newLine();
      _builder.append("\t\t\t\t\t");
      _builder.append("WhateverConstraint");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.append("\t\t\t\t");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("/** Makes sure that this is compliant. */");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("constraint WhateverConstraint exception WhateverException {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("message \"WhateverConstraint message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("/** Argh... */");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("exception WhateverException {");
      _builder.newLine();
      _builder.append("\t\t\t");
      _builder.append("message \"WhateverException message\"");
      _builder.newLine();
      _builder.append("\t\t");
      _builder.append("}\t\t");
      _builder.newLine();
      _builder.newLine();
      _builder.append("\t");
      _builder.append("}");
      _builder.newLine();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      return this.parser.parse(_builder);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
