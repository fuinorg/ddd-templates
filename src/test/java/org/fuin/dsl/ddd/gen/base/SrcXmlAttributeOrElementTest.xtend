package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcXmlAttributeOrElementTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateAggregateId() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val Variable idVar = aggregate.variables.get(0)
		val SrcXmlAttributeOrElement testeeId = new SrcXmlAttributeOrElement(ctx, idVar)

		ctx.resolve(refReg)

		// TEST
		val resultId = testeeId.toString

		// VERIFY
		assertThat(resultId).isEqualTo('''@XmlAttribute(name = "id")''')
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlAttribute")

	}

	@Test
	def void testCreateValueObject() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("x.types.String", "java.lang.String")

		val Aggregate aggregate = createModel().find(Aggregate, "MyAggregate")
		val Variable voVar = aggregate.variables.get(1)
		val SrcXmlAttributeOrElement testeeVo = new SrcXmlAttributeOrElement(ctx, voVar)

		ctx.resolve(refReg)

		// TEST
		val resultVo = testeeVo.toString

		// VERIFY
		assertThat(resultVo).isEqualTo('''@XmlElement(name = "vo")''')
		assertThat(ctx.imports).containsOnly("javax.xml.bind.annotation.XmlElement")

	}

	private def DomainModel createModel() {
		parser.parse(
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
	}

}
