package org.fuin.dsl.ddd.gen.base;

import java.net.URL;
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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.gen.base.SrcConstructorWithParamsAssignment;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcConstructorWithParamsAssignmentTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.a.MyEntityId", "a.b.c.MyEntityId");
    refReg.putReference("x.a.MyValueObject", "a.b.c.MyValueObject");
    refReg.putReference("x.a.ConstraintViolatedException", "a.b.c.ConstraintViolatedException");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Entity entity = DomainModelExtensions.<Entity>find(_createModel, Entity.class, "MyEntity");
    EList<Constructor> _constructors = entity.getConstructors();
    final Constructor constructor = _constructors.get(0);
    String _name = entity.getName();
    final SrcConstructorWithParamsAssignment testee = new SrcConstructorWithParamsAssignment(ctx, "public", _name, constructor);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Creates the entity.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param id Unique entity identifier.");
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
    _builder.append("public MyEntity(@NotNull final MyEntityId id, final MyValueObject vo) throws ConstraintViolatedException {");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("Contract.requireArgNotNull(\"id\", id);");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("this.id = id;");
    _builder.newLine();
    _builder.append("\t");
    _builder.append("this.vo = vo;");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "a.b.c.MyEntityId", 
      "a.b.c.MyValueObject", "a.b.c.ConstraintViolatedException", "org.fuin.objects4j.common.Contract");
  }
  
  private DomainModel createModel() {
    try {
      Class<? extends SrcConstructorWithParamsAssignmentTest> _class = this.getClass();
      URL _resource = _class.getResource("/example1.ddd");
      String _readAsString = Utils.readAsString(_resource);
      return this.parser.parse(_readAsString);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}