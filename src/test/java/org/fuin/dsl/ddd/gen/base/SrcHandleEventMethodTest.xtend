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

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcHandleEventMethodTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.DidSomethingEvent", "a.b.c.DidSomethingEvent")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val event = aggregate.methods.get(0).events.get(0)
		val SrcHandleEventMethod testee = new SrcHandleEventMethod(ctx, event)

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
				@Override
				@EventHandler
				protected final void handle(@NotNull final DidSomethingEvent event) {
					// TODO Handle event!
				}
			''')
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull",
			"org.fuin.ddd4j.ddd.EventHandler", "a.b.c.DidSomethingEvent")

	}

	private def DomainModel createModel() {
		return parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
	}

}
