package org.fuin.dsl.ddd.gen.service

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Service
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class ServiceArtifactFactory extends AbstractSource<Service> {

	override getModelType() {
		typeof(Service)
	}

	override create(Service service, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		if (!(service.eContainer instanceof Namespace)) {
			// Do not create separate interface file 
			// for services in constructors or methods
			return null
		}

		val className = service.name
		val Namespace ns = service.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(service.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(service)
		ctx.addReferences(service)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, service, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, Service service) {
		// Nothing to do
	}

	def addReferences(CodeSnippetContext ctx, Service service) {
		// Nothing to do
	}

	def create(SimpleCodeSnippetContext ctx, Service service, String pkg, String className) {
		val String src = ''' 
			«new SrcService(ctx, service)»
			'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
