package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcValueObjectConverter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static org.fuin.dsl.ddd.gen.base.Utils.*

class ValueObjectConverterArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (valueObject.base == null) {
			return null;
		}
		val className = valueObject.getName() + "Converter"
		val Namespace ns = valueObject.eContainer() as Namespace;
		val fqn = ns.asPackage + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		
		val CodeReferenceRegistry refReg = getCodeReferenceRegistry(context)
		refReg.putReference(valueObject.uniqueName + "Converter", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		return new GeneratedArtifact(
			artifactName,
			filename,
			new SrcValueObjectConverter(refReg, copyrightHeader, ns.asPackage, valueObject, valueObject.base, false).
				toString().getBytes("UTF-8")
		);
	}

}
