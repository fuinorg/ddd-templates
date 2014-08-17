package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcValueObjectConverterTest {
	
	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testNullObjName() {
		
		// TODO Implement!
		
		
	}	
	
}
