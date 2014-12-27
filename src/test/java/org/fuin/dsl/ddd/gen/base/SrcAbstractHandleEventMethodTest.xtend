package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcAbstractHandleEventMethodTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.DidSomethingEvent", "a.b.c.DidSomethingEvent")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val event = createModel().find(Event, "DidSomethingEvent")
		val SrcAbstractHandleEventMethod testee = new SrcAbstractHandleEventMethod(ctx, event)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
			/**
			 * Handles: DidSomethingEvent.
			 *
			 * @param event Event to handle.
			 */
			protected abstract void handle(@NotNull final DidSomethingEvent event);
			''')
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "a.b.c.DidSomethingEvent")

	}

	private def DomainModel createModel() {
		return parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
	}

}
