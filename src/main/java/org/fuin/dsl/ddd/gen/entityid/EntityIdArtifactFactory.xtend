package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcGetters
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import org.fuin.dsl.ddd.gen.base.SrcConstructorsWithParamsAssignment

class EntityIdArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entityId.getName()
		val Namespace ns = entityId.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + entityId.getName()
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(entityId.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(entityId)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, entityId, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")
		ctx.requiresImport("org.fuin.ddd4j.ddd.AggregateRootId")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.StringBasedEntityType")
		ctx.requiresImport("org.fuin.objects4j.common.Immutable")
		ctx.requiresImport("org.fuin.objects4j.vo.AbstractStringValueObject")
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObject")
	}

	def addReferences(CodeSnippetContext ctx, EntityId entityId) {
		ctx.requiresReference(entityId.uniqueName + "Converter")
	}

	def create(SimpleCodeSnippetContext ctx, EntityId id, String pkg, String className) {
		val String src = ''' 
			«new SrcJavaDoc(id)»
			@Immutable
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			public final class «className» «optionalExtendsForBase(id.name, id.base)»implements EntityId, ValueObject {
			
				private static final long serialVersionUID = 1000L;
				
				/** Name that identifies the entity uniquely within the context. */	
				public static final EntityType TYPE = new StringBasedEntityType("«id.entity.name»");
			
				«new SrcVarsDecl(ctx, "private", false, id)»
				
				«_optionalDeserializationConstructor(id)»
			
				«new SrcConstructorsWithParamsAssignment(ctx, id)»
			
				«new SrcGetters(ctx, "public final", id.variables)»
			
				@Override
				public final EntityType getType() {
					return TYPE;
				}
				
				@Override
				public final String asTypedString() {
					return TYPE + " " + asString();
				}
				
				«_optionalBaseMethods(id.name, id.base)»
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
