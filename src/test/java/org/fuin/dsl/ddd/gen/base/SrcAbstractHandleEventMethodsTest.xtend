package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddAbstractEntityExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcAbstractHandleEventMethodsTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.DidSomethingEvent", "a.b.c.DidSomethingEvent")
		refReg.putReference("x.a.SomethingHappenedEvent", "a.b.c.SomethingHappenedEvent")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val Aggregate aggregate = model().find(Aggregate, "MyAggregate")
		val SrcAbstractHandleEventMethods testee = new SrcAbstractHandleEventMethods(ctx, aggregate.allEvents)

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
			
			/**
			 * Handles: SomethingHappenedEvent.
			 *
			 * @param event Event to handle.
			 */
			protected abstract void handle(@NotNull final SomethingHappenedEvent event);
			
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "a.b.c.DidSomethingEvent", "a.b.c.SomethingHappenedEvent")

	}

	def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
