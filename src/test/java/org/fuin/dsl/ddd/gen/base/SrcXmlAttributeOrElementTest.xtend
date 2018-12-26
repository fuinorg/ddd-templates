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

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcXmlAttributeOrElementTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateAggregateId() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val idVar = aggregate.attributes.get(0)
		val SrcXmlAttributeOrElement testeeId = new SrcXmlAttributeOrElement(ctx, idVar)

		// TEST
		val resultId = testeeId.toString


		// VERIFY
		assertThat(resultId).isEqualTo('''@XmlAttribute(name = "id")'''.toString)
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlAttribute")

	}

	@Test
	def void testCreateValueObject() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val voVar = aggregate.attributes.get(1)
		val SrcXmlAttributeOrElement testeeVo = new SrcXmlAttributeOrElement(ctx, voVar)

		// TEST
		val resultVo = testeeVo.toString

		// VERIFY
		assertThat(resultVo).isEqualTo('''@XmlElement(name = "vo")'''.toString)
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlElement")

	}

	private def DomainModel createModel() {
		val DomainModel model =parser.parse(
			'''
				context x {
					
					namespace a {
						
						import x.types.*
				
						value-object MyValueObject {}
				
						aggregate MyAggregate identifier MyAggregateId {
							MyAggregateId id
							MyValueObject vo
						}
				
						aggregate-id MyAggregateId identifies MyAggregate base String {}
				
					}
				
					namespace types {
						type String
					}
						
				}
			'''
		)
		validationTester.assertNoIssues(model)
		return model
	}

}
