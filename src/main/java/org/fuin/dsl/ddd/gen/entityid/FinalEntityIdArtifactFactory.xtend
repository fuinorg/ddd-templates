package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalEntityIdArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entityId.name
		val abstractClassName = entityId.abstractName
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
			create(ctx, entityId, pkg, className, abstractClassName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, EntityId entityId) {
		if (entityId.base !== null) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")			
		}
		ctx.requiresImport("javax.annotation.concurrent.Immutable")
	}

	def addReferences(CodeSnippetContext ctx, EntityId entityId) {
		if (entityId.base !== null) {
			ctx.requiresReference(entityId.uniqueName + "Converter")			
		}
		ctx.requiresReference(entityId.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, EntityId id, String pkg, String className, String abstractClassName) {
		val String src = ''' 
			«new SrcJavaDocType(id)»
			@Immutable
			«IF id.base !== null»
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			«ENDIF»
			public final class «className» extends «abstractClassName» {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcConstructorsWithParamsAssignment(ctx, id, false, true)»
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
