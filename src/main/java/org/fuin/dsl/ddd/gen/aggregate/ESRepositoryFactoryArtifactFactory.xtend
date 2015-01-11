package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class ESRepositoryFactoryArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val repositoryName = aggregate.name + "Repository"
		val className = repositoryName + "Factory"
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		val eventRegistryName = aggregate.context.name.toFirstUpper + "EventRegistry"

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(aggregate.uniqueName + "RepositoryFactory", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(aggregate, eventRegistryName)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregate, pkg, className, repositoryName, eventRegistryName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.ddd4j.eventstore.intf.EventStore")
		ctx.requiresImport("javax.enterprise.context.Dependent")
		ctx.requiresImport("javax.enterprise.inject.Produces")
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate, String eventRegistryName) {
		ctx.requiresReference(aggregate.uniqueName + "Repository")
		ctx.requiresReference(eventRegistryName)
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className, String repositoryName,
		String eventRegistryName) {
		val String src = ''' 
			/**
			 * Creates a «repositoryName».
			 */
			@Dependent
			public class «className» {
			
				/**
				 * Produces a «repositoryName».
				 * 
				 * @param eventStore The event store to use for construction.
				 * @param eventRegistry Registry with all events to use for construction.
				 *
				 * @return The new repository instance.
				 */
				@Produces
				public «repositoryName» create(final EventStore eventStore, final «eventRegistryName» eventRegistry) {
					return new «repositoryName»(eventStore, eventRegistry, eventRegistry);
				}
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
