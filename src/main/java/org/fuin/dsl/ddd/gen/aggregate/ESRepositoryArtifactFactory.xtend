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

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*

class ESRepositoryArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}

	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = aggregate.getName() + "Repository"
		val Namespace ns = aggregate.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(aggregate.uniqueName + "Event", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(aggregate)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregate, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("org.fuin.ddd4j.ddd.DeserializerRegistry")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityType")
		ctx.requiresImport("org.fuin.ddd4j.ddd.SerializerRegistry")
		ctx.requiresImport("org.fuin.ddd4j.esrepo.EventStoreRepository")
		ctx.requiresImport("org.fuin.ddd4j.eventstore.intf.EventStore")
	}

	def addReferences(CodeSnippetContext ctx, Aggregate aggregate) {
		ctx.requiresReference(aggregate.uniqueName)
		ctx.requiresReference(aggregate.idType.uniqueName)
	}

	def create(SimpleCodeSnippetContext ctx, Aggregate aggregate, String pkg, String className) {
		val String src = ''' 
			/**
			 * Repository that is capable of storing a {@link «aggregate.name»}.
			 */
			public final class «aggregate.name»Repository extends EventStoreRepository<«aggregate.idType.name», «aggregate.name»> {
			
				/**
				 * Constructor with event store to use as storage.
				 * 
				 * @param eventStore Event store.
				 * @param serRegistry Registry used to locate serializers.
				 * @param desRegistry Registry used to locate deserializers.
				 */
				public «className»(final EventStore eventStore,
						final SerializerRegistry serRegistry, final DeserializerRegistry desRegistry) {
				super(eventStore, serRegistry, desRegistry);
				}
			
				@Override
				public Class<«aggregate.name»> getAggregateClass() {
					return «aggregate.name».class;
				}
			
				@Override
				public final EntityType getAggregateType() {
					return «aggregate.idType.name».TYPE;
				}
			
				@Override
				public final «aggregate.name» create() {
					return new «aggregate.name»();
				}
			
				@Override
				protected final String getIdParamName() {
					return "«aggregate.idType.name.toFirstLower»";
				}
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
