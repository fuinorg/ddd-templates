package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*

class AggregateIdStreamFactoryArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		if (aggregateId.entity == null) {
			return null;
		}

		val className = aggregateId.getName() + "StreamFactory"
		val Namespace ns = aggregateId.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + aggregateId.getName()
		val filename = fqn.replace('.', '/') + ".java";
		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(aggregateId.uniqueName + "StreamFactory", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext()
		ctx.addImports
		ctx.addReferences(aggregateId)
		ctx.resolve(refReg)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, aggregateId, pkg, className).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
	}

	def addReferences(CodeSnippetContext ctx, AggregateId entityId) {
	}

	def create(SimpleCodeSnippetContext ctx, AggregateId id, String pkg, String className) {
		val src = ''' 
			/**
			 * Creates a «id.entity.name»Stream based on a AggregateStreamId.
			 */
			public class «id.name»StreamFactory implements IdStreamFactory {
			
			    @Override
			    public final Stream createStream(final StreamId streamId) {
					final String id = streamId.getSingleParamValue();
					return new «id.entity.name»Stream(«id.name».valueOf(id));
			  }
			
			    @Override
				public boolean containsType(final StreamId streamId) {
				return streamId.getName().equals(«id.name».TYPE.asString());
			  }
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString
		
	}

}
