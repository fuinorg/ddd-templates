package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalAggregateIdArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregateId.name
		val abstractClassName = aggregateId.abstractName
		val Namespace ns = aggregateId.namespace;
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
			create(ctx, aggregateId, pkg, className, abstractClassName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, AggregateId aggregateId) {
		if (aggregateId.base != null) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")			
		}
		ctx.requiresImport("org.fuin.objects4j.common.Immutable")
	}

	def addReferences(CodeSnippetContext ctx, AggregateId aggregateId) {
		if (aggregateId.base != null) {
			ctx.requiresReference(aggregateId.uniqueName + "Converter")			
		}
		ctx.requiresReference(aggregateId.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, AggregateId id, String pkg, String className, String abstractClassName) {
		val String src = ''' 
			«new SrcJavaDoc(id)»
			@Immutable
			«IF id.base != null»
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			«ENDIF»
			public final class «className» extends «abstractClassName» {
			
				private static final long serialVersionUID = 1000L;
				
				«new SrcVoBaseMethods(ctx, id)»
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
