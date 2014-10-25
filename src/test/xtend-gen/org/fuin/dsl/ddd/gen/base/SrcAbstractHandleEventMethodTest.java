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
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.gen.base.SrcAbstractHandleEventMethod;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions;
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;
import org.junit.Test;
import org.junit.runner.RunWith;

@InjectWith(DomainDrivenDesignDslInjectorProvider.class)
@RunWith(XtextRunner.class)
@SuppressWarnings("all")
public class SrcAbstractHandleEventMethodTest {
  @Inject
  private ParseHelper<DomainModel> parser;
  
  @Test
  public void testCreate() {
    final SimpleCodeReferenceRegistry refReg = new SimpleCodeReferenceRegistry();
    refReg.putReference("x.a.DidSomethingEvent", "a.b.c.DidSomethingEvent");
    final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg);
    DomainModel _createModel = this.createModel();
    final Aggregate aggregate = DomainModelExtensions.<Aggregate>find(_createModel, Aggregate.class, "MyAggregate");
    EList<Event> _events = aggregate.getEvents();
    final Event event = _events.get(0);
    final SrcAbstractHandleEventMethod testee = new SrcAbstractHandleEventMethod(ctx, event);
    final String result = testee.toString();
    StringAssert _assertThat = Assertions.assertThat(result);
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* Handles: DidSomethingEvent.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param event Event to handle.");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("protected abstract void handle(@NotNull final DidSomethingEvent event);");
    _builder.newLine();
    _assertThat.isEqualTo(_builder.toString());
    Set<String> _imports = ctx.getImports();
    CollectionAssert _assertThat_1 = Assertions.assertThat(_imports);
    _assertThat_1.containsOnly("javax.validation.constraints.NotNull", "a.b.c.DidSomethingEvent");
  }
  
  private DomainModel createModel() {
    try {
      Class<? extends SrcAbstractHandleEventMethodTest> _class = this.getClass();
      URL _resource = _class.getResource("/example1.ddd");
      String _readAsString = Utils.readAsString(_resource);
      return this.parser.parse(_readAsString);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
