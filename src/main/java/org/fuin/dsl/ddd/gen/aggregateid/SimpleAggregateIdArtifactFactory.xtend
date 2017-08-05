package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import java.util.UUID
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddAggregateIdExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class SimpleAggregateIdArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		if (aggregateId.base === null || aggregateId.base.name != "UUID") {
			// Do not generate anything
			return null
		}

		val className = aggregateId.getName()
		val Namespace ns = aggregateId.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregateId.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(aggregateId)
		ctx.addReferences(aggregateId)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregateId, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, AggregateId aggregateId) {
		ctx.requiresImport("javax.validation.constraints.NotNull")
		ctx.requiresImport("org.fuin.ddd4j.ddd.AggregateRootUuid")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.StringBasedEntityType")
		ctx.requiresImport("org.fuin.objects4j.common.Immutable")
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObjectConverter")		
		ctx.requiresImport(UUID.name);
		if (jsonb) {
			ctx.requiresImport("javax.json.bind.adapter.JsonbAdapter")		
		}
		if (jpa) {
			ctx.requiresImport("javax.persistence.AttributeConverter")		
		}		
		if (jaxb) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")		
		}
	}

	def addReferences(CodeSnippetContext ctx, AggregateId entityId) {
		// Do nothing
	}

	def create(SimpleCodeSnippetContext ctx, AggregateId id, String pkg, String className) {
		val src = '''
			«new SrcJavaDocType(id)»
			@Immutable
			public final class «className» extends AggregateRootUuid {
			
				private static final long serialVersionUID = 1000L;
			
				/** Unique name of the aggregate this identifier refers to. */
				public static final EntityType TYPE = new StringBasedEntityType(
						"«id.aggregateNullsafe.name»");
			
				/**
				 * Default constructor.
				 */
				protected «className»() {
					super(TYPE);
				}
			
				/**
				 * Constructor with all data.
				 *
				 * @param value
				 *            Persistent value.
				 */
				public «className»(@NotNull final UUID value) {
					super(TYPE, value);
				}
			
				/**
				 * Parses a given string and returns a new instance of «className».
				 * 
				 * @param value
				 *            String with valid UUID to convert. A <code>null</code> value
				 *            returns <code>null</code>.
				 * 
				 * @return Converted value.
				 */
				public static «className» valueOf(final String value) {
					if (value == null) {
						return null;
					}
					requireArgValid("value", value);
					return new «className»(UUID.fromString(value));
				}
			
				/**
				 * Converts the value object from/to UUID.
				 */
				public static final class Converter «IF jaxb»extends XmlAdapter<UUID, «className»>«ENDIF»
						implements ValueObjectConverter<UUID, «className»>
						«IF jpa», AttributeConverter<«className», UUID>«ENDIF»
						«IF jsonb», JsonbAdapter<«className», UUID>«ENDIF» {

					// Attribute Converter

					@Override
					public final Class<UUID> getBaseTypeClass() {
						return UUID.class;
					}

					@Override
					public final Class<«className»> getValueObjectClass() {
						return «className».class;
					}

					@Override
					public boolean isValid(final UUID value) {
						return true;
					}

					@Override
					public final «className» toVO(final UUID value) {
						if (value == null) {
							return null;
						}
						return new «className»(value);
					}

					@Override
					public final UUID fromVO(final «className» value) {
						if (value == null) {
							return null;
						}
						return value.asBaseType();
					}

					«IF jaxb»
					// JAXB XML Adapter

					@Override
					public final «className» unmarshal(final UUID value)
							throws Exception {
						return toVO(value);
					}

					@Override
					public final UUID marshal(final «className» obj)
							throws Exception {
						return fromVO(obj);
					}

					«ENDIF»
					«IF jpa»
					// JPA Attribute Converter

					@Override
					public final UUID convertToDatabaseColumn(
							final «className» obj) {
						return fromVO(obj);
					}

					@Override
					public final «className» convertToEntityAttribute(
							final UUID value) {
						return toVO(value);
					}

					«ENDIF»
					«IF jsonb»
					// JSONB Adapter

					@Override
					public final UUID adaptToJson(final «className» obj)
							throws Exception {
						return fromVO(obj);
					}

					@Override
					public final «className» adaptFromJson(
							final UUID value) throws Exception {
						return toVO(value);
					}

					«ENDIF»
				}
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
