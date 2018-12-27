package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.assertj.core.api.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcVarDeclTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateWithConstraint() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("a.types.String", "java.lang.String")
		refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.get(0)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", new GenerateOptions(), attr)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				@AnyConstraint
				@NotNull
				private String str;
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "x.y.z.AnyConstraint",
			"java.lang.String")

	}

	@Test
	def void testCreateWithoutConstraint() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("a.types.String", "java.lang.String")
		refReg.putReference("a.b.AnyConstraint", "x.y.z.AnyConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.get(1)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", new GenerateOptions(), attr)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				@NotNull
				private String str2;
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull", "java.lang.String")

	}

	@Test
	def void testCreateWithoutConstraintNullable() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("a.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.get(2)
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", new GenerateOptions(), attr)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''@Nullable
private String str3;
			'''.toString)
		assertThat(ctx.imports).containsOnly("java.lang.String", "javax.annotation.Nullable")

	}

	@Test
	def void testCreateWithXmlAttribute() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("a.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.get(3)
		val GenerateOptions options = new GenerateOptions.Builder().withJaxb().withJsonb().create();
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", options, attr)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				@NotNull
				@XmlAttribute(name = "abc-def-ghi")
				@JsonbProperty("abc-def-ghi")
				private String abcDefGhi;
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull",
			"javax.xml.bind.annotation.XmlAttribute", "javax.json.bind.annotation.JsonbProperty", 
			"java.lang.String")

	}

	@Test
	def void testCreateWithXmlElement() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("a.types.String", "java.lang.String")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.get(3)
		val GenerateOptions options = new GenerateOptions.Builder().withJaxb().withJaxbElements().withJsonb().create();
		val SrcVarDecl testee = new SrcVarDecl(ctx, "private", options, attr)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				@NotNull
				@XmlElement(name = "abc-def-ghi")
				@JsonbProperty("abc-def-ghi")
				private String abcDefGhi;
			'''.toString)
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull",
			"javax.xml.bind.annotation.XmlElement", "javax.json.bind.annotation.JsonbProperty", 
			"java.lang.String")

	}

	private def DomainModel createModel() {
		val DomainModel model = parser.parse(
			'''
				context a {
					
					namespace b {
						
						import a.types.*
				
						constraint AnyConstraint input String {
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
		validationTester.assertNoIssues(model)
		return model
	}

}
