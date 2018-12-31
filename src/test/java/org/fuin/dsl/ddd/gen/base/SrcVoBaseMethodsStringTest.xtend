package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcVoBaseMethodsStringTest {

	@Inject
	ParseHelper<DomainModel> parser

	@Inject 
	ValidationTestHelper validationTester

	@Test
	def void testString() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.a.MyAggregateId", "a.b.c.MyAggregateId")
		val AggregateId aggregateId = createModel().find(AggregateId, "MyAggregateId")

		val testee = new SrcVoBaseMethodsString(ctx, aggregateId)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
		'''	
			/**
			 * Returns the information if a given string can be converted into
			 * an instance of MyAggregateId. A <code>null</code> value returns <code>true</code>.
			 * 
			 * @param value
			 *            Value to check.
			 * 
			 * @return TRUE if it's a valid string, else FALSE.
			 */
			public static boolean isValid(final String value) {
				if (value == null) {
					return true;
				}
				// TODO Verify the value is valid!
				return true;
			}
			
			/**
			 * Parses a given string and returns a new instance of MyAggregateId.
			 * 
			 * @param value
			 *            Value to convert. A <code>null</code> value returns
			 *            <code>null</code>.
			 * 
			 * @return Converted value.
			 */
			public static MyAggregateId valueOf(final String value) {
				if (value == null) {
					return null;
				}
				// TODO Parse string value and return new instance! 
				// return new MyAggregateId(value);
				return null;
			}
			
		'''.toString
		)
		assertThat(ctx.imports).containsOnly("a.b.c.MyAggregateId", "java.lang.String")

	}

	def DomainModel createModel() {
		val DomainModel model = parser.parse(
			'''
				context y {
				
					namespace types {
						type String
					}
					
					namespace a {
						
						import y.types.*
						
						aggregate-id MyAggregateId identifies MyAggregate base String {}
							
						aggregate MyAggregate identifier MyAggregateId {}
							
					}
					
				}
			'''
		)
		validationTester.assertNoIssues(model)
		return model
	}

}
