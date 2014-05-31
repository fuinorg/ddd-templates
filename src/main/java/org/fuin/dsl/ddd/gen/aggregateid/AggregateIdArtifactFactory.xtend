package org.fuin.dsl.ddd.gen.aggregateid

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AggregateId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AggregateIdArtifactFactory extends AbstractSource<AggregateId> {

	override getModelType() {
		typeof(AggregateId)
	}

	override create(AggregateId entityId) throws GenerateException {
		val Namespace ns = entityId.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + entityId.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(entityId, ns).toString().getBytes("UTF-8"));
	}
	
	def create(AggregateId id, Namespace ns) {
		''' 
		«copyrightHeader»
		package «ns.asPackage»;
		
		«_imports(id)»
		
		«_typeDoc(id)»
		@Immutable
		@XmlJavaTypeAdapter(«id.name»Converter.class)
		public final class «id.name» «optionalExtendsForBase(id.name, id.base)»implements AggregateRootId, ValueObject {
		
			private static final long serialVersionUID = 1000L;
		
			/** Name that identifies the aggregate uniquely within the context. */	
			public static final EntityType TYPE = new StringBasedEntityType("«id.entity.name»");
		
			«_varsDecl(id)»
		
			«_optionalDeserializationConstructor(id)»
		
			«_constructorsDecl(id)»
		
			«_getters("public final", id.variables)»
		
			@Override
			public final EntityType getType() {
				return TYPE;
			}
			
			@Override
			public final String asTypedString() {
				return TYPE + " " + asString();
			}
		
			«_optionalBaseMethods(id.name, id.base)»
		}
		'''	
	}
	
}