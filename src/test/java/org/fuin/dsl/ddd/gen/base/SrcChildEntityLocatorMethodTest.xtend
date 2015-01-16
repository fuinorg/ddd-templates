package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcChildEntityLocatorMethodTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.MyEntity", "a.b.c.MyEntity")
		refReg.putReference("x.a.MyEntityId", "a.b.c.MyEntityId")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val Entity entity = model().find(Entity, "MyEntity")
		val SrcChildEntityLocatorMethod testee = new SrcChildEntityLocatorMethod(ctx, entity)

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
			''')
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull",
			"org.fuin.ddd4j.ddd.ChildEntityLocator", "a.b.c.MyEntity", "a.b.c.MyEntityId")

	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
