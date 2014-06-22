package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcValueObjectConverter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.base.Utils.*

class EntityIdConverterArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		if (entityId.base == null) {
			return null;
		}
		val className = entityId.getName() + "Converter"
		val Namespace ns = entityId.eContainer() as Namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";
		
		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(entityId.uniqueName + "Converter", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}
		
		return new GeneratedArtifact(
			artifactName,
			filename,
			new SrcValueObjectConverter(refReg, copyrightHeader, pkg, entityId, entityId.base, true).
				toString().getBytes("UTF-8")			
		);
	}

}
