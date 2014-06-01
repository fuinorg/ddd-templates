package org.fuin.dsl.ddd.gen.except

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ExceptionArtifactFactory extends AbstractSource<Exception> {

	override getModelType() {
		typeof(Exception)
	}

	override create(Exception ex) throws GenerateException {
		val Namespace ns = ex.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + ex.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(ex, ns).toString().getBytes("UTF-8"));
	}

	def create(Exception ex, Namespace ns) {
		'''
			«copyrightHeader» 
			package «ns.asPackage»;
			
			import org.fuin.objects4j.vo.KeyValue;
			«_imports(ex)»
			
			/**
			 * «ex.doc.text»
			 */
			public final class «ex.name» extends «_uniquelyNumberedException(ex)» {
			
				private static final long serialVersionUID = 1000L;
			
				«_varsDecl(ex)»
			
				/**
				 * Constructs a new instance of the exception.
				 *
				«FOR v : ex.variables»
					* @param «v.name» «v.superDoc» 
				«ENDFOR»
				*/
				public «ex.name»(«_paramsDecl(ex.variables)») {
					super(«IF ex.cid > 0»«ex.cid», «ENDIF»
					    KeyValue.replace("«ex.message»",
						«FOR v : ex.variables SEPARATOR ','»
							new KeyValue("«v.name»", «v.name»)
						«ENDFOR» 
					));
					«_paramsAssignment(ex.variables)»
				}
			
				«_getters("public final", ex.variables)»
			
			}
		'''
	}

	def _varsDecl(Exception ex) {
		'''
		«FOR variable : ex.variables.nullSafe»
		«_varDecl(variable)»
		
		«ENDFOR»
		'''
	}

}
