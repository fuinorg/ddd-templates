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
class SrcConstructorWithParamsAssignmentTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.a.MyEntityId", "a.b.c.MyEntityId")
		refReg.putReference("x.a.MyValueObject", "a.b.c.MyValueObject")
		refReg.putReference("x.a.ConstraintViolatedException", "a.b.c.ConstraintViolatedException")
		val ctx = new SimpleCodeSnippetContext(refReg)
		val Entity entity = model().find(Entity, "MyEntity")
		val constructor = entity.constructors.get(0)
		val SrcConstructorWithParamsAssignment testee = new SrcConstructorWithParamsAssignment(ctx, "public",
			entity.getName(), constructor)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * Creates the entity.
				 *
				 * @param id Unique entity identifier.
				 * @param vo Example value object.
				 *
				 * @throws ConstraintViolatedException The constraint was violated.
				 */
				public MyEntity(@NotNull final MyEntityId id, final MyValueObject vo) throws ConstraintViolatedException {
					super();
					Contract.requireArgNotNull("id", id);
					
					this.id = id;
					this.vo = vo;
				}
			''')
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "a.b.c.MyEntityId",
			"a.b.c.MyValueObject", "a.b.c.ConstraintViolatedException", "org.fuin.objects4j.common.Contract")

	}

	private def model() {
		val DomainModel model = parser.parse(Utils.readAsString(class.getResource("/example1.ddd")))
		validationTester.assertNoIssues(model)
		return model
	}

}
