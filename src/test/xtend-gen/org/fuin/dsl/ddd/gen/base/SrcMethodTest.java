package org.fuin.dsl.ddd.gen.base;

import com.google.common.collect.Lists;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import javax.inject.Inject;
import org.eclipse.emf.common.util.EList;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fest.assertions.Assertions;
import org.fest.assertions.CollectionAssert;
import org.fest.assertions.StringAssert;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method;
import org.fuin.dsl.ddd.gen.base.SrcMethod;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

/* @InjectWith(DomainDrivenDesignDslInjectorProvider.class) */@RunWith(void.class)
@SuppressWarnings("all")
public class SrcMethodTest {
  @Inject
  private /* ParseHelper<DomainModel> */Object parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.a.MyAggregateId", "a.b.c.MyAggregateId");
    refReg.putReference("x.a.MyValueObject", "a.b.c.MyValueObject");
    refReg.putReference("x.a.ConstraintViolatedException", "a.b.c.ConstraintViolatedException");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Aggregate aggregate = DomainModelExtensions.<Aggregate>find(_createModel, Aggregate.class, "MyAggregate");
    EList<Method> _methods = aggregate.getMethods();
    final Method method = _methods.get(0);
    final List<String> annotations = Collections.<String>unmodifiableList(Lists.<String>newArrayList("@One", "@Two(\"2\")"));
    final SrcMethod testee = new SrcMethod(ctx, annotations, "public", false, method);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Does some cool things.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param id Unique aggregate identifier.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param vo Example value object.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @throws ConstraintViolatedException The constraint was violated.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("@One");
    _builder.newLine();
    _builder.append("@Two(\"2\")");
    _builder.newLine();
    _builder.append("public void doSomething(@NotNull final MyAggregateId id, final MyValueObject vo) throws ConstraintViolatedException {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("// TODO Implement!");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "a.b.c.MyAggregateId", 
      "a.b.c.MyValueObject", "a.b.c.ConstraintViolatedException");
  }
  
  @Test
  public void testCreateAbstract() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.a.MyAggregateId", "a.b.c.MyAggregateId");
    refReg.putReference("x.a.MyValueObject", "a.b.c.MyValueObject");
    refReg.putReference("x.a.ConstraintViolatedException", "a.b.c.ConstraintViolatedException");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Aggregate aggregate = DomainModelExtensions.<Aggregate>find(_createModel, Aggregate.class, "MyAggregate");
    EList<Method> _methods = aggregate.getMethods();
    final Method method = _methods.get(0);
    final SrcMethod testee = new SrcMethod(ctx, null, "public", true, method);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Does some cool things.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param id Unique aggregate identifier.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param vo Example value object.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @throws ConstraintViolatedException The constraint was violated.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public abstract void doSomething(@NotNull final MyAggregateId id, final MyValueObject vo) throws ConstraintViolatedException;");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "a.b.c.MyAggregateId", 
      "a.b.c.MyValueObject", "a.b.c.ConstraintViolatedException");
  }
  
  private DomainModel createModel() {
    throw new Error("Unresolved compilation problems:"
      + "\nparse cannot be resolved");
  }
}
