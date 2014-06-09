package org.fuin.dsl.ddd.gen.enumobject

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class EnumArtifactFactory extends AbstractSource<EnumObject> {

	override getModelType() {
		typeof(EnumObject)
	}

	override create(EnumObject enu, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		val Namespace ns = enu.eContainer() as Namespace;
		val filename = (ns.asPackage + "." + enu.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(enu, ns).toString().getBytes("UTF-8"));
	}

	def create(EnumObject vo, Namespace ns) {
		''' 
			«copyrightHeader»
			package «ns.asPackage»;
			
			«_imports(vo)»
			
			/** «vo.doc.text» */
			public enum «vo.name» {
			
			«FOR in : vo.instances SEPARATOR ','»
				«in.doc»
				«in.name»(«_methodCall(vo.variables, in.params)»)
			«ENDFOR»;
			
				«_varsDecl(vo)»
			
				private «vo.name»(«_paramsDecl(vo.variables)») {
					«_paramsAssignment(vo.variables)»
				}
			
			}
		'''
	}

}
