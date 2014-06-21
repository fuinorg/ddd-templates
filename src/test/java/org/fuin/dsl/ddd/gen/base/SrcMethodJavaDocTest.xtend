package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcMethodJavaDocTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val method = valueObject.methods.get(0)
		val SrcMethodJavaDoc testee = new SrcMethodJavaDoc(ctx, method)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/*
				 * This method does cool things.
				 *
				 * @param a Abc.
				 * @param b Def.
				 *
				 * @throws WhateverException Argh...
				 */
			''')
		assertThat(ctx.imports).isEmpty()

	}

	private def DomainModel createModel() {
		parser.parse(
			'''
				context a {
					
					namespace b {
						
						type String
						type Integer
				
						value-object MyValueObject {
				
							/**
							 * This method does cool things.
							 */
							method whatever {
								
								/** Abc. */
								String a
								
								/** Def. */
								Integer b
								
								constraints {
									WhateverConstraint
								}
								
							}
				
						}
				
						/** Makes sure that this is compliant. */
						constraint WhateverConstraint exception WhateverException {
							message "WhateverConstraint message"
						}
				
						/** Argh... */
						exception WhateverException {
							message "WhateverException message"
						}		
				
					}
				
				}
			'''
		)
	}

}
