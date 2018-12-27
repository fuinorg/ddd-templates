package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
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
import static extension org.fuin.dsl.ddd.extensions.DddAggregateIdExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class AggregateIdArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

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
		if (aggregateId.base !== null) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")
		}
		ctx.requiresImport("org.fuin.ddd4j.ddd.AggregateRootId")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.StringBasedEntityType")
		ctx.requiresImport("javax.annotation.concurrent.Immutable")
		ctx.requiresImport("org.fuin.objects4j.vo.ValueObject")
	}

	def addReferences(CodeSnippetContext ctx, AggregateId entityId) {
		if (entityId.base !== null) {
			ctx.requiresReference(entityId.uniqueName + "Converter")
		}
	}

	def create(SimpleCodeSnippetContext ctx, AggregateId id, String pkg, String className) {
		val src = '''
			«new SrcJavaDocType(id)»
			@Immutable
			«IF id.base !== null»
				@XmlJavaTypeAdapter(«id.name»Converter.class)
			«ENDIF»
			public final class «className» «new SrcVoBaseOptionalExtends(ctx, id.base)»implements AggregateRootId, ValueObject {
			
			private static final long serialVersionUID = 1000L;
			
				«new SrcVarsDecl(ctx, "private", new GenerateOptions(), id)»
				«new SrcConstructorsWithParamsAssignment(ctx, id, false)»
				«new SrcGetters(ctx, "public final", id.attributes)»
				«new SrcEntityIdTypeMethods(ctx, id.aggregateNullsafe.name, id.base)»
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
