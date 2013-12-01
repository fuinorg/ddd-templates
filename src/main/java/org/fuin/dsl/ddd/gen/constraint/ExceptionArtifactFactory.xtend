package org.fuin.dsl.ddd.gen.constraint

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ExceptionArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {
	
	override getModelType() {
		typeof(Constraint)
	}

	override init(ArtifactFactoryConfig config) {
		// Not used
	}

	override isIncremental() {
		true
	}

	override create(Constraint constraint) throws GenerateException {
		val Namespace ns = constraint.eContainer() as Namespace;
        val String filename = (ns.getName() + "." + constraint.getException()).replace('.', '/') + ".java";
		return new GeneratedArtifact("Exception", filename, create(constraint, ns).toString());
	}
		
	def create(Constraint constr, Namespace ns) {
		''' 
		package «ns.name»;
		
		«_imports(constr)»
		
		/** «constr.doc.text» */
		public final class «constr.exception» extends Abstract«constr.exception» {
		
			private static final long serialVersionUID = 1L;
		
			public «constr.exception»(«_paramsDecl(allVariables(constr))») {
				«_superCall(allVariables(constr))»
			}
		
		}
		'''	
	}

}