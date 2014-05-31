package org.fuin.dsl.ddd.gen.entityid

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class EntityIdConverterArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId) throws GenerateException {
		if (entityId.base == null) {
			return null;
		}
		val Namespace ns = entityId.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + entityId.getName() + "Converter").replace('.', '/') + ".java";
		return new GeneratedArtifact(
			artifactName,
			filename,
			_valueObjectConverterSource(ns, entityId.name, entityId.base.name, true).getBytes("UTF-8")
		);
	}

}
