package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.gen.extensions.DomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcVarDeclTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Test
	def void testCreateWithConstraint() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(0)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

		// VERIFY
		assertThat(result).isEqualTo('''
		@AnyConstraint
		@NotNull
		private String str;
		''')
		assertThat(ctx.references).containsOnly("a.types.String", "a.b.AnyConstraint")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "x.y.z.AnyConstraint")

	}

	@Test
	def void testCreateWithoutConstraint() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(1)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

		// VERIFY
		assertThat(result).isEqualTo('''
		@NotNull
		private String str2;
		''')
		assertThat(ctx.references).containsOnly("a.types.String")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull")

	}

	@Test
	def void testCreateWithoutConstraintNullable() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(2)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", false, variable)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

		// VERIFY
		assertThat(result).isEqualTo('''
		private String str3;
		''')
		assertThat(ctx.references).containsOnly("a.types.String")
		assertThat(ctx.imports).isEmpty()

	}

	@Test
	def void testCreateWithXml() {

		// PREPARE
		val ctx = new SimpleCodeSnippetContext()
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val Variable variable = valueObject.variables.get(3)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", true, variable)

		// TEST
		val result = testee.toString
		ctx.resolve(refReg)

		// VERIFY
		assertThat(result).isEqualTo('''
		@NotNull
		@XmlElement(name = "abc-def-ghi")
		private String abcDefGhi;
		''')
		assertThat(ctx.references).containsOnly("a.types.String")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "javax.xml.bind.annotation.XmlElement")

	}
	
	private def DomainModel createModel() {
		parser.parse(
			'''
			context a {
				
				namespace b {
					
					import a.types.*
			
					constraint AnyConstraint on String {
						message "message"
					}
			
					value-object MyValueObject {
						String str invariants AnyConstraint
						String str2
						nullable String str3
						String abcDefGhi
					}
			
				}
			
				namespace types {
					type String
				}
					
			}
			'''
		)
	}

}
