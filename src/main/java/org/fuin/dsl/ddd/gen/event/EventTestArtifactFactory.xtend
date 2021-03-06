package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAggregateExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAttributeExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEventExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddLiteralExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddTypeExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddVariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*

class EventTestArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		val AbstractEntity entity = event.entity;
		val className = event.getName() + "Test"
		var Namespace ns;
		if (entity === null) {
			ns = event.namespace;
		} else {
			ns = entity.namespace;
		}
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(event.uniqueName + "Test", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(entity)
		ctx.addReferences(entity, event)

		var String src;
		if (entity === null) {
			src = createStandardEventTest(ctx, event, pkg, className).toString();
		} else {
			src = createDomainEventTest(ctx, event, pkg, className).toString();
		}

		return new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, AbstractEntity entity) {
		ctx.requiresImport("static org.assertj.core.api.Assertions.*")
		ctx.requiresImport("org.junit.Test")
		if (options.jaxb) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")			
		}
		if (entity !== null) {
			ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPathConverter")
			ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPath")
		}
		if (options.jsonb) {
			ctx.requiresImport("org.fuin.ddd4j.ddd.EventIdConverter");
			ctx.requiresImport("javax.json.bind.Jsonb");
			ctx.requiresImport("javax.json.bind.JsonbBuilder");
			ctx.requiresImport("javax.json.bind.JsonbConfig");
			ctx.requiresImport("org.eclipse.yasson.FieldAccessStrategy");
		}
		ctx.requiresImport("static org.fuin.utils4j.Utils4J.serialize")
		ctx.requiresImport("static org.fuin.utils4j.Utils4J.deserialize")
		ctx.requiresImport("static org.fuin.utils4j.JaxbUtils.marshal")
		ctx.requiresImport("static org.fuin.utils4j.JaxbUtils.unmarshal")		
	}

	def addReferences(CodeSnippetContext ctx, AbstractEntity entity, Event event) {
		ctx.requiresReference(event.uniqueName)
		if (entity !== null) {
			ctx.requiresReference(event.aggregate.idTypeNullsafe.uniqueName)
			ctx.requiresReference(event.context.name.toFirstUpper + "EntityIdFactory")
		}
		for (v : event.attributes.nullSafe) {
			addRequiredReferences(v, ctx)
		}
	}

	def createDomainEventTest(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			// CHECKSTYLE:OFF
			public final class «event.name»Test {
			
				@Test
				public final void testSerializeDeserialize() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final «event.name» copy = deserialize(serialize(original));
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«IF options.jaxb»
				@Test
				public final void testMarshalUnmarshalXml() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final String xml = marshal(original, createAdapter(), «event.name».class);
					final «event.name» copy = unmarshal(xml, createAdapter(), «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«ENDIF»			
			«IF options.jsonb»
				@Test
				public final void testMarshalUnmarshalJson() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					final JsonbConfig config = new JsonbConfig()
							.withAdapters(new EventIdConverter(), new ZonedDateTimeJsonbAdapter())
							.withPropertyVisibilityStrategy(new FieldAccessStrategy());
					final Jsonb jsonb = JsonbBuilder.create(config);
			
					// TEST
					final String json = jsonb.toJson(original, «event.name».class);
					final «event.name» copy = jsonb.fromJson(json, «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«ENDIF»			
				private «event.name» createTestee() {
					// TODO Set test values
					final «event.aggregate.idTypeNullsafe.name» entityId = new «event.aggregate.idTypeNullsafe.name»(«event.aggregate.idTypeNullsafe.firstExample.str»);
					«FOR v : event.attributes.nullSafe»
						final «v.type(ctx)» «v.name» = «v.firstExample.str»;
					«ENDFOR»
					return new «new SrcInvokeMethod(ctx, event.name, union("new EntityIdPath(entityId)", event.attributes.asNames))»
				}
			
				protected final XmlAdapter<?, ?>[] createAdapter() {
					final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new «event.context.name.toFirstUpper»EntityIdFactory());
					return new XmlAdapter[] { entityIdPathConverter };
				}
			
			}
			// CHECKSTYLE:ON
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def createStandardEventTest(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			// CHECKSTYLE:OFF
			public final class «event.name»Test {
			
				@Test
				public final void testSerializeDeserialize() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final «event.name» copy = deserialize(serialize(original));
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«IF options.jaxb»
				@Test
				public final void testMarshalUnmarshalXml() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final String xml = marshal(original, createAdapter(), «event.name».class);
					final «event.name» copy = unmarshal(xml, createAdapter(), «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«ENDIF»			
			«IF options.jsonb»
				@Test
				public final void testMarshalUnmarshalJson() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					final JsonbConfig config = new JsonbConfig()
							.withAdapters(new EventIdConverter())
							.withPropertyVisibilityStrategy(new FieldAccessStrategy());
					final Jsonb jsonb = JsonbBuilder.create(config);
			
					// TEST
					final String json = jsonb.toJson(original, «event.name».class);
					final «event.name» copy = jsonb.fromJson(json, «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
					«FOR v : event.attributes.nullSafe»
						assertThat(original.get«v.name.toFirstUpper»()).isEqualTo(copy.get«v.name.toFirstUpper»());
					«ENDFOR»
			
				}
			
			«ENDIF»			
				private «event.name» createTestee() {
					«IF event.attributes.nullSafe.size > 0»
						// TODO Set test values
						«FOR v : event.attributes.nullSafe»
							final «v.type(ctx)» «v.name» = new «v.type(ctx)»(«v.firstExample.str»);
						«ENDFOR»
					«ENDIF»
					return new «new SrcInvokeMethod(ctx, event.name, event.attributes.asNames)»
				}
			
				protected final XmlAdapter<?, ?>[] createAdapter() {
					return new XmlAdapter[] { };
				}
			
			}
			// CHECKSTYLE:ON
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
