package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcVoBaseMethodsNumberTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testString() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)
		refReg.putReference("y.types.Long", "java.lang.Long")
		refReg.putReference("y.a.MyEntityId", "a.b.c.MyEntityId")
		val EntityId entityId = createModel().find(EntityId, "MyEntityId")

		val testee = new SrcVoBaseMethodsNumber(ctx, entityId)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''	
				/**
				 * Returns the information if a given Long can be converted into
				 * an instance of MyEntityId. A <code>null</code> value returns <code>true</code>.
				 * 
				 * @param value
				 *            Value to check.
				 * 
				 * @return TRUE if it's a valid Long, else FALSE.
				 */
				public static boolean isValid(final Long value) {
					if (value == null) {
						return true;
					}
					try {
						Long.valueOf(value);
					} catch (final NumberFormatException ex) {
						return false;
					}
					return true;
				}
				
				/**
				 * Parses a given Long and returns a new instance of MyEntityId.
				 * 
				 * @param value
				 *            Value to convert. A <code>null</code> value returns
				 *            <code>null</code>.
				 * 
				 * @return Converted value.
				 */
				public static MyEntityId valueOf(final Long value) {
					if (value == null) {
						return null;
					}
					return new MyEntityId(value);
				}
				
				/**
				 * Parses a given String and returns a new instance of MyEntityId.
				 * 
				 * @param value
				 *            Value to convert. A <code>null</code> value returns
				 *            <code>null</code>.
				 * 
				 * @return Converted value.
				 */
				public static MyEntityId valueOf(final String value) {
					if (value == null) {
						return null;
					}
					return new MyEntityId(Long.valueOf(value));
				}
				
			'''
		)
		assertThat(ctx.imports).containsOnly("a.b.c.MyEntityId", "java.lang.Long")

	}

	private def DomainModel createModel() {
		val DomainModel model = parser.parse(
			'''
				context y {
				
					namespace types {
						type Long
						type UUID
					}
					
					namespace a {
						
						import y.types.*
						
						entity-id MyEntityId identifies MyEntity base Long {}
						
						entity MyEntity identifier MyEntityId root MyAggregate {}
				
						aggregate-id MyAggregateId identifies MyAggregate base UUID {}
							
						aggregate MyAggregate identifier MyAggregateId {}
							
					}
					
				}
			'''
		)
		validationTester.assertNoIssues(model)
		return model
	}

}
