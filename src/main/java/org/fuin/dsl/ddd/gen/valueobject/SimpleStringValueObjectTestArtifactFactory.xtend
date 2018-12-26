package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddLiteralExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

class SimpleStringValueObjectTestArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		
		if (valueObject.base === null || valueObject.base.name != "String") {
			// Do not generate anything
			return null
		}
		
		val className = valueObject.name + "Test"
		val Namespace ns = valueObject.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(valueObject.uniqueName + "Test", fqn)

		if (preparationRun) {
			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports()
		ctx.addReferences(valueObject)

		var String src = createStandardEventTest(ctx, valueObject, pkg, className).toString();

		return new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("static org.assertj.core.api.Assertions.*")
		ctx.requiresImport("org.junit.Test")
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")
		ctx.requiresImport("nl.jqno.equalsverifier.EqualsVerifier")
		ctx.requiresImport("nl.jqno.equalsverifier.Warning")
		ctx.requiresImport("static org.fuin.utils4j.Utils4J.serialize")
		ctx.requiresImport("static org.fuin.utils4j.Utils4J.deserialize")
		ctx.requiresImport("static org.fuin.utils4j.JaxbUtils.marshal")
		ctx.requiresImport("static org.fuin.utils4j.JaxbUtils.unmarshal")
	}

	def addReferences(CodeSnippetContext ctx, ValueObject vo) {
		ctx.requiresReference(vo.uniqueName)
		for (v : vo.attributes.nullSafe) {
			addRequiredReferences(v, ctx)
		}
	}

	def createStandardEventTest(SimpleCodeSnippetContext ctx, ValueObject vo, String pkg, String className) {
		
		var example = "xxxxxxx"
		if (vo.metaInfo !== null && vo.metaInfo.examples.size > 0) {
			example = vo.metaInfo.examples.first.str
		}
		
		val String src = ''' 
			// CHECKSTYLE:OFF
			public final class «vo.name»Test {
			
				@Test
				public void testSerialize() {
					final «vo.name» original = new «vo.name»("«example»");
					final «vo.name» copy = Utils4J.deserialize(Utils4J.serialize(original));
					assertThat(original).isEqualTo(copy);
				}

				@Test
				public void testHashCodeEquals() {
					EqualsVerifier.forClass(«vo.name».class).suppress(Warning.NULL_FIELDS).withRedefinedSuperclass().verify();
				}

				@Test
				public void testMarshalJson() throws Exception {

					// PREPARE
					final String str = "«example»";
					final «vo.name» testee = new «vo.name»(str);

					// TEST & VERIFY
					assertThat(new «vo.name».Converter().adaptToJson(testee)).isEqualTo(str);
					assertThat(new «vo.name».Converter().adaptToJson(null)).isNull();

				}

				@Test
				public void testUnmarshalJson() throws Exception {

					// PREPARE
					final String str = "«example»";
					final «vo.name» testee = new «vo.name»(str);

					// TEST & VERIFY
					assertThat(new «vo.name».Converter().adaptFromJson(str)).isEqualTo(testee);
					assertThat(new «vo.name».Converter().adaptFromJson(null)).isNull();

				}

				@Test
				public void testMarshalXml() throws Exception {

					// PREPARE
					final String str = "«example»";
					final «vo.name» testee = new «vo.name»(str);

					// TEST & VERIFY
					assertThat(new «vo.name».Converter().marshal(testee)).isEqualTo(str);
					assertThat(new «vo.name».Converter().marshal(null)).isNull();

				}

				@Test
				public void testUnmarshalXml() throws Exception {

					// PREPARE
					final String str = "«example»";
					final «vo.name» testee = new «vo.name»(str);

					// TEST & VERIFY
					assertThat(new «vo.name».Converter().unmarshal(str)).isEqualTo(testee);
					assertThat(new «vo.name».Converter().unmarshal(null)).isNull();

				}

				@Test
				public void testIsValid() {

					assertThat(«vo.name».isValid(null)).isTrue();
					assertThat(«vo.name».isValid("«example»")).isTrue();

					fail("Implement assertions with some invalid values!");
					/*
					assertThat(«vo.name».isValid("")).isFalse();
					assertThat(«vo.name».isValid("Invalid value xhjgahgjhsgd")).isFalse();
					*/

				}

				@Test
				public void testRequireArgValid() {

					«vo.name».requireArgValid("a", "«example»");
					«vo.name».requireArgValid("b", null);

					fail("Implement assertions with some invalid values!");
					/*
					try {
						«vo.name».requireArgValid("c", "");
						Assert.fail();
					} catch (final ConstraintViolationException ex) {
						assertThat(ex.getMessage()).isEqualTo("The argument 'c' is not valid: ''");
					}

					try {
						«vo.name».requireArgValid("d", "Invalid value xhjgahgjhsgd");
						Assert.fail();
					} catch (final ConstraintViolationException ex) {
						assertThat(ex.getMessage()).isEqualTo("The argument 'd' is not valid: 'Invalid value xhjgahgjhsgd'");
					}
					*/

				}

				@Test
				public void testValidator() {

					assertThat(new «vo.name».Validator().isValid(null, null)).isTrue();
					assertThat(new «vo.name».Validator().isValid("«example»", null)).isTrue();

					fail("Implement assertions with some invalid values!");
					/*
					assertThat(new «vo.name».Validator().isValid("", null)).isFalse();
					assertThat(new «vo.name».Validator().isValid("Invalid value xhjgahgjhsgd", null)).isFalse();
					*/

				}

				@Test
				public void testValueObjectConverter() {

					assertThat(new «vo.name».Converter().getBaseTypeClass()).isEqualTo(String.class);
					assertThat(new «vo.name».Converter().getValueObjectClass()).isEqualTo(«vo.name».class);
					assertThat(new «vo.name».Converter().isValid(null)).isTrue();
					assertThat(new «vo.name».Converter().isValid("«example»")).isTrue();
					fail("Implement assertions with some invalid values!");
					/*
					assertThat(new «vo.name».Converter().isValid("Invalid value xhjgahgjhsgd")).isFalse();
					*/

				}
			
			}
			
			// CHECKSTYLE:ON
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
