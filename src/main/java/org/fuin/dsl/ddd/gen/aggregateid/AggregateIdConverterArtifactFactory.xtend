package org.fuin.dsl.ddd.gen.aggregateid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcValueObjectConverter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static org.fuin.dsl.ddd.gen.base.Utils.*

class AggregateIdConverterArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (aggregateId.base == null) {
			return null;
		}
		val className = aggregateId.getName() + "Converter"
		val Namespace ns = aggregateId.eContainer() as Namespace;
		val String fqn = ns.asPackage + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		
		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(aggregateId.uniqueName + "Converter", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}
		
		return new GeneratedArtifact(
			artifactName,
			filename,
			new SrcValueObjectConverter(refReg, copyrightHeader, ns.asPackage, aggregateId, aggregateId.base, true).
				toString().getBytes("UTF-8")
		);
	}

}
