package org.fuin.dsl.ddd.gen.base;

import java.util.ArrayList;
import java.util.Set;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment;
import org.fuin.dsl.ddd.gen.extensions.DomainDrivenDesignDslFactoryExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;

@SuppressWarnings("all")
public class SrcParamsAssignmentTest {
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    final SimpleCodeSnippetContext codeSnippetContext = new SimpleCodeSnippetContext(refReg);
    final ArrayList<Variable> vars = new ArrayList<Variable>();
    Variable _createVariable = DomainDrivenDesignDslFactoryExtensions.createVariable(DomainDrivenDesignDslFactory.eINSTANCE, "a");
    vars.add(_createVariable);
    Variable _createVariable_1 = DomainDrivenDesignDslFactoryExtensions.createVariable(DomainDrivenDesignDslFactory.eINSTANCE, "b");
    vars.add(_createVariable_1);
    Variable _createVariable_2 = DomainDrivenDesignDslFactoryExtensions.createVariable(DomainDrivenDesignDslFactory.eINSTANCE, "c", true);
    vars.add(_createVariable_2);
    final SrcParamsAssignment testee = new SrcParamsAssignment(codeSnippetContext, vars);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("Contract.requireArgNotNull(\"a\", a);");
    _builder.newLine();
    _builder.append("Contract.requireArgNotNull(\"b\", b);");
    _builder.newLine();
    _builder.newLine();
    _builder.append("this.a = a;");
    _builder.newLine();
    _builder.append("this.b = b;");
    _builder.newLine();
    _builder.append("this.c = c;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = codeSnippetContext.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("org.fuin.objects4j.common.Contract");
  }
}
