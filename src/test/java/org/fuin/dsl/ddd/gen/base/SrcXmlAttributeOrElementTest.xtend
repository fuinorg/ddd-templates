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
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testCreateAggregateIdAttribute() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val idVar = aggregate.attributes.get(0)
		val SrcXmlAttributeOrElement testeeId = new SrcXmlAttributeOrElement(ctx, idVar, false)

		// TEST
		val resultId = testeeId.toString


		// VERIFY
		assertThat(resultId).isEqualTo('''@XmlAttribute(name = "id")'''.toString)
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlAttribute")

	}

	@Test
	def void testCreateAggregateIdElement() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val idVar = aggregate.attributes.get(0)
		val SrcXmlAttributeOrElement testeeId = new SrcXmlAttributeOrElement(ctx, idVar, true)

		// TEST
		val resultId = testeeId.toString


		// VERIFY
		assertThat(resultId).isEqualTo('''@XmlElement(name = "id")'''.toString)
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlElement")

	}
	
	@Test
	def void testCreateValueObject() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val voVar = aggregate.attributes.get(1)
		val SrcXmlAttributeOrElement testeeVo = new SrcXmlAttributeOrElement(ctx, voVar, false)

		// TEST
		val resultVo = testeeVo.toString

		// VERIFY
		assertThat(resultVo).isEqualTo('''@XmlElement(name = "vo")'''.toString)
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlElement")

	}

	def DomainModel createModel() {
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
