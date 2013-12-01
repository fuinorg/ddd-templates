package org.fuin.dsl.ddd.gen.valueobject

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValueObjectArtifactFactory extends AbstractSource implements ArtifactFactory<ValueObject> {
	
	override getModelType() {
		typeof(ValueObject)
	}

	override init(ArtifactFactoryConfig config) {
		// Not used
	}

	override isIncremental() {
		true
	}

	override create(ValueObject valueObject) throws GenerateException {
		val Namespace ns = valueObject.eContainer() as Namespace;
        val String filename = (ns.getName() + "." + valueObject.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact("ValueObject", filename, create(valueObject, ns).toString());
	}
	
	def create(ValueObject vo, Namespace ns) {
		''' 
		package «ns.name»;
		
		«_imports(vo)»
		
		/** «vo.doc.text» */
		public class «vo.name» extends Abstract«vo.name» {
		
			public «vo.name»(«_paramsDecl(vo.variables)») {
				«_superCall(vo.variables)»
			}
			
		}
		'''	
	}
	
}