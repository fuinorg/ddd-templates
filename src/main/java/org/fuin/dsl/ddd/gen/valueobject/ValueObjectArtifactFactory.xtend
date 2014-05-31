package org.fuin.dsl.ddd.gen.valueobject

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject) throws GenerateException {
		val Namespace ns = valueObject.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + valueObject.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(valueObject, ns).toString().getBytes("UTF-8"));
	}
	
	def create(ValueObject vo, Namespace ns) {
		''' 
		«copyrightHeader»
		package «ns.asPackage»;
		
		«_imports(vo)»
		
		«_typeDoc(vo)»
		
		«IF vo.base == null»
		«_xmlRootElement(vo.name)»
		«ENDIF»
		public final class «vo.name» «optionalExtendsForBase(vo.name, vo.base)»implements ValueObject {
		
			private static final long serialVersionUID = 1000L;
			
			«_varsDecl(vo, (vo.base == null))»
		
			«_optionalDeserializationConstructor(vo)»
		
			«_constructorsDecl(vo)»
			
			«_getters("public final", vo.variables)»
			
			«_optionalBaseMethods(vo.name, vo.base)»
			
		}
		'''	
	}
	
}