package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.eclipse.xtext.testing.util.ParseHelper
import org.eclipse.xtext.testing.validation.ValidationTestHelper
import org.fuin.dsl.ddd.tests.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddInvariantsExtensions.*
import java.net.URL
import org.apache.commons.io.IOUtils
import org.eclipse.emf.common.util.EList
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Attribute

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcValidationAnnotationTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreateNoArgConstraint() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("y.types.String", "java.lang.String")
		refReg.putReference("y.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.NoArgConstraint", "a.b.c.NoArgConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strNoArgConstraint")
		val constraintInstance = attr.invariants.nullSafe.first
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintInstance)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NoArgConstraint")
		assertThat(ctx.imports).containsOnly("a.b.c.NoArgConstraint")

	}
	
	@Test
	def void testCreateOneArgConstraint() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("org.fuin.types.String", "java.lang.String")
		refReg.putReference("org.fuin.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.OneArgConstraint", "a.b.c.OneArgConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strOneArgConstraint")
		val constraintInstance = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintInstance)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@OneArgConstraint(50)")
		assertThat(ctx.imports).containsOnly("a.b.c.OneArgConstraint", "java.lang.Integer")

	}

	@Test
	def void testCreateTwoArgsConstraint() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		refReg.putReference("org.fuin.types.String", "java.lang.String")
		refReg.putReference("org.fuin.types.Integer", "java.lang.Integer")
		refReg.putReference("y.a.TwoArgsConstraint", "a.b.c.TwoArgsConstraint")
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strTwoArgsConstraint")
		val constraintInstance = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, constraintInstance)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@TwoArgsConstraint(min = 1, max = 100)")
		assertThat(ctx.imports).containsOnly("a.b.c.TwoArgsConstraint", "java.lang.Integer")

	}

	@Test
	def void testMinValue() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("minValueBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@DecimalMin(\"123.45\")")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.DecimalMin")

	}
	
	@Test
	def void testMaxValue() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("maxValueBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@DecimalMax(\"123.45\")")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.DecimalMax")

	}
	
	@Test
	def void testValueRange() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("valueRangeBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo('''
  									@DecimalMin("0")
  									@DecimalMax("100")
  									''')
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.DecimalMin", "javax.validation.constraints.DecimalMax")

	}
	
	@Test
	def void testNegative() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("negativeBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Negative")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Negative")

	}
	
	
	@Test
	def void testNegativeOrZero() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("negativeOrZeroBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NegativeOrZero")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NegativeOrZero")

	}
	
	@Test
	def void testPositive() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("positiveBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Positive")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Positive")

	}
	
	
	@Test
	def void testPositiveOrZero() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("positiveOrZeroBigDecimal")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@PositiveOrZero")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.PositiveOrZero")

	}
	
	@Test
	def void testMinLength() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strMinLength")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Size(min=1)")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Size")

	}
	
	@Test
	def void testMaxLength() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strMaxLength")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Size(max=2)")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Size")

	}
	
	@Test
	def void testExactLength() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strExactLength")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Size(min=3, max=3)")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Size")

	}

	@Test
	def void testLength() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strLength")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Size(min=1, max=100)")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Size")

	}
	
	@Test
	def void testNotNull() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strNotNull")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NotNull")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotNull")

	}

	@Test
	def void testNull() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strNull")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Null")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Null")

	}
				
	@Test
	def void testAssertTrue() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("booleanAssertTrue")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@AssertTrue")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.AssertTrue")

	}
				
	@Test
	def void testAssertFalse() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("booleanAssertFalse")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@AssertFalse")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.AssertFalse")

	}
				
	@Test
	def void testStringNotEmpty() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strNotEmpty")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NotEmpty")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotEmpty")

	}
				
	@Test
	def void testListNotEmpty() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("listNotEmpty")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NotEmpty")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotEmpty")

	}
	
//	String strPattern invariants Pattern("\d")
				
	@Test
	def void testNotBlank() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strNotBlank")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@NotBlank")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.NotBlank")

	}
	
	@Test
	def void testPattern() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val attr = valueObject.attributes.find("strPattern")
		val value = attr.invariants.nullSafe.get(0)
		val SrcValidationAnnotation testee = new SrcValidationAnnotation(ctx, value)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo("@Pattern(regexp=\"\\d\")")
		assertThat(ctx.imports).containsOnly("javax.validation.constraints.Pattern")

	}
	
	private def Attribute find(EList<Attribute> attrs, String nameToFind) {
		for (Attribute attr : attrs) {
			if (attr.name.equals(nameToFind)) {
				return attr
			}
		}
		return null
	}
	

	private def DomainModel createModel() {
		
		val URL url = class.classLoader.getResource("org/fuin/dsl/ddd/Basics.ddd")
		val basics = IOUtils.toString(url, "utf-8")
		
		val DomainModel model = parser.parse(
			basics +
			'''
			context y {
			
				namespace a {
					
					import org.fuin.types.*
					import org.fuin.constr.*
			
					constraint NoArgConstraint input String {
						message "NoArgConstraint message"
					}
			
					constraint OneArgConstraint input String {
						Integer expected
						message "OneArgConstraint message"
					}
			
					constraint TwoArgsConstraint input String {
						Integer min
						Integer max
				        message "TwoArgsConstraint message"
					}
			
					value-object MyValueObject {
			
						String strNoArgConstraint invariants NoArgConstraint
						String strOneArgConstraint invariants OneArgConstraint(50)
						String strTwoArgsConstraint invariants TwoArgsConstraint(1, 100)
			
						String strNotNull invariants NotNull
						String strNull invariants Null
						Boolean booleanAssertTrue invariants AssertTrue
						Boolean booleanAssertFalse invariants AssertFalse
			
						BigDecimal minValueBigDecimal invariants MinValue("123.45")
						BigInteger minValueBigInteger invariants MinValue("123")
						Integer minValueInteger invariants MinValue("234")
						Long minValueLong invariants MinValue("-345")
			
						BigDecimal maxValueBigDecimal invariants MaxValue("123.45")
						BigInteger maxValueBigInteger invariants MaxValue("123")
						Integer maxValueInteger invariants MaxValue("234")
						Long maxValueLong invariants MaxValue("-345")
			
						BigDecimal valueRangeBigDecimal invariants ValueRange("0", "100")
						BigInteger valueRangeBigInteger invariants ValueRange("1", "99")
						Integer valueRangeInteger invariants ValueRange("-2", "2")
						Long valueRangeLong invariants ValueRange("-1", "1")
			
						BigDecimal negativeBigDecimal invariants Negative
						BigInteger negativeBigInteger invariants Negative
						Integer negativeInteger invariants Negative
						Long negativeLong invariants Negative
						Float negativeFloat invariants Negative
						Double negativeDouble invariants Negative
			
						BigDecimal negativeOrZeroBigDecimal invariants NegativeOrZero
						BigInteger negativeOrZeroBigInteger invariants NegativeOrZero
						Integer negativeOrZeroInteger invariants NegativeOrZero
						Long negativeOrZeroLong invariants NegativeOrZero
						Float negativeOrZeroFloat invariants NegativeOrZero
						Double negativeOrZeroDouble invariants NegativeOrZero
			
						BigDecimal positiveBigDecimal invariants Positive
						BigInteger positiveBigInteger invariants Positive
						Integer positiveInteger invariants Positive
						Long positiveLong invariants Positive
						Float positiveFloat invariants Positive
						Double positiveDouble invariants Positive
			
						BigDecimal positiveOrZeroBigDecimal invariants PositiveOrZero
						BigInteger positiveOrZeroBigInteger invariants PositiveOrZero
						Integer positiveOrZeroInteger invariants PositiveOrZero
						Long positiveOrZeroLong invariants PositiveOrZero
						Float positiveOrZeroFloat invariants PositiveOrZero
						Double positiveOrZeroDouble invariants PositiveOrZero
			
						String strMinLength invariants MinLength(1)
						String strMaxLength invariants MaxLength(2)
						String strExactLength invariants ExactLength(3)
						String strLength invariants Length(1, 100)
			
						String strNotEmpty invariants NotEmpty
						List<String> listNotEmpty invariants NotEmpty
						String strNotBlank invariants NotBlank
						String strPattern invariants Pattern("\\d")
			
					}
			
				}
			
			}
			'''
		)
		validationTester.assertNoIssues(model)
		return model
	}

}
