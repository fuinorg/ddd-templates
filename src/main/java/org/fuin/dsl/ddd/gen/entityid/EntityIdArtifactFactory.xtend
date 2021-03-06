package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcEntityIdTypeMethods
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.dsl.ddd.gen.base.SrcVoBaseOptionalExtends
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEntityIdExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class EntityIdArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entityId.name
		val Namespace ns = entityId.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(entityId.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(entityId)
		ctx.addReferences(entityId)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, entityId, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, EntityId entityId) {
		if (entityId.base !== null) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")		
		}
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityId")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.StringBasedEntityType")
		ctx.requiresImport("javax.annotation.concurrent.Immutable")
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObject")
	}

	def addReferences(CodeSnippetContext ctx, EntityId entityId) {
		if (entityId.base !== null) {
			ctx.requiresReference(entityId.uniqueName + "Converter")		
		}
	}

	def create(SimpleCodeSnippetContext ctx, EntityId id, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDocType(id)»
			@Immutable
			«IF id.base !== null»
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			«ENDIF»
			public final class «className» «new SrcVoBaseOptionalExtends(ctx, id.base)»implements EntityId, ValueObject {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVarsDecl(ctx, "private", GenerateOptions.empty(), id)»
				«new SrcConstructorsWithParamsAssignment(ctx, GenerateOptions.empty(), id, false)»
				«new SrcGetters(ctx, GenerateOptions.empty(), "public final", id.attributes)»
				«new SrcEntityIdTypeMethods(ctx, id.entityNullsafe.name, id.base)»
				«IF id.base === null»
				@Override
				public final String asString() {
					«IF (id.attributes.nullSafe.size == 1)»
					return "" + get«id.attributes.first.name.toFirstUpper»();
					«ELSE»
					// TODO Implement!
					return null;
					«ENDIF»
				}

				«ENDIF»
				«new SrcVoBaseMethods(ctx, id)»
			}
			'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
