package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcChildEntityLocatorMethodTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.MyEntity", "a.b.c.MyEntity")
		refReg.putReference("x.a.MyEntityId", "a.b.c.MyEntityId")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val Entity entity = model().find(Entity, "MyEntity")
		val SrcChildEntityLocatorMethod testee = new SrcChildEntityLocatorMethod(ctx, GenerateOptions.empty(), entity)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				@Override
				@ChildEntityLocator
				protected final MyEntity findMyEntity(@NotNull final MyEntityId myEntityId) {
					// TODO Implement!
					return null;
				}
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull",
			"org.fuin.ddd4j.ddd.ChildEntityLocator", "a.b.c.MyEntity", "a.b.c.MyEntityId")

	}

	def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
