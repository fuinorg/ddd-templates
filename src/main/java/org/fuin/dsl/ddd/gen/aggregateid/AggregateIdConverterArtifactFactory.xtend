package org.fuin.dsl.ddd.gen.aggregateid

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateIdConverterArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId aggregateId) throws GenerateException {
		if (aggregateId.base == null) {
			return null;
		}
		val Namespace ns = aggregateId.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + aggregateId.getName() + "Converter").replace('.', '/') + ".java";
		return new GeneratedArtifact(
			artifactName,
			filename,
			_valueObjectConverterSource(ns, aggregateId.name, aggregateId.base.name, true).getBytes("UTF-8")
		);
	}

}
