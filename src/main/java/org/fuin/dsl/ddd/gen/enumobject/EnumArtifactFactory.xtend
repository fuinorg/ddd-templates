package org.fuin.dsl.ddd.gen.enumobject

import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class EnumArtifactFactory extends AbstractSource implements ArtifactFactory<EnumObject> {
	
	override getModelType() {
		typeof(EnumObject)
	}
	
	override init(ArtifactFactoryConfig config) {
		// Not used
	}
	
	override isIncremental() {
		true
	}
	
	override create(EnumObject enu) throws GenerateException {
        val Namespace ns = enu.eContainer() as Namespace;
        var String filename = (ns.getName() + "." + enu.getName()).replace('.', '/') + ".java";
        return new GeneratedArtifact("Enum", filename, create(enu, ns).toString());
	}
	
	def create(EnumObject vo, Namespace ns) {
		''' 
		package «ns.name»;
		
		«_imports(vo)»
		
		/** «vo.doc.text» */
		public enum «vo.name» {
		
		«FOR in : vo.instances SEPARATOR ','»
			«in.doc»
			«in.name»(«_methodCall(vo.variables, in.params)»)
		«ENDFOR»;
		
			«_varsDecl(vo.variables)»
		
			private «vo.name»(«_paramsDecl(vo.variables)») {
				«_paramsAssignment(vo.variables)»
			}
		
		}
		'''	
	}
	
}