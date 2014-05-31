package org.fuin.dsl.ddd.gen.valueobject

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValueObjectConverterArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject) throws GenerateException {
		if (valueObject.base == null) {
			return null;
		}
		val Namespace ns = valueObject.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + valueObject.getName() + "Converter").replace('.', '/') + ".java";
		return new GeneratedArtifact(
			artifactName,
			filename,
			_valueObjectConverterSource(ns, valueObject.name, valueObject.base.name, false).getBytes("UTF-8")
		);
	}

}
