package org.fuin.dsl.ddd.gen.base

import jakarta.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.cqrs.tests.CqrsDslInjectorProvider
import org.fuin.dsl.cqrs.cqrsDsl.DomainModel
import org.fuin.dsl.cqrs.cqrsDsl.Event
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.cqrs.extensions.CqrsDomainModelExtensions.*

@InjectWith(typeof(CqrsDslInjectorProvider))
@ExtendWith(InjectionExtension) 
class SrcHandleEventMethodTest {

    @Inject
    ParseHelper<DomainModel> parser

    @Inject 
    ValidationTestHelper validationTester

    @Test
    def void testCreate() {

        // PREPARE
        val refReg = new SimpleCodeReferenceRegistry()
        refReg.putReference("x.a.DidSomethingEvent", "a.b.c.DidSomethingEvent")
        val ctx = new SimpleCodeSnippetContext(refReg)
        val event = model().find(Event, "DidSomethingEvent")
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
                @ApplyEvent
                protected final void handle(@NotNull final DidSomethingEvent event) {
                    // TODO Handle event!
                }
            '''.toString)
        assertThat(ctx.imports).containsOnly("jakarta.validation.constraints.NotNull",
            "org.fuin.ddd4j.core.ApplyEvent", "a.b.c.DidSomethingEvent")

    }

    def model() {
        val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/example1.cqrs")))
        validationTester.assertNoIssues(model)
        return model
    }

}
