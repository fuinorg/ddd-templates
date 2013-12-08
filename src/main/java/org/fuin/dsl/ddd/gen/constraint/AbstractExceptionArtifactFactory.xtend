package org.fuin.dsl.ddd.gen.constraint

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AbstractExceptionArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {

	String artifactName;

	override getModelType() {
		typeof(Constraint)
	}

	override init(ArtifactFactoryConfig config) {
		artifactName = config.getArtifact()
	}

	override isIncremental() {
		true
	}

	override create(Constraint constraint) throws GenerateException {
		val Namespace ns = constraint.eContainer() as Namespace;
		val String filename = (ns.getName() + ".Abstract" + constraint.getException()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(constraint, ns).toString().getBytes("UTF-8"));
	}

	def create(Constraint constr, Namespace ns) {
		'''
			package «ns.name»;
			
			«_imports(constr)»
			
			/** «constr.doc.text» */
			public abstract class Abstract«constr.exception» extends Exception {
			
				private static final long serialVersionUID = 1L;
			
				«_varsDecl(allVariables(constr))»
			
				public Abstract«constr.exception»(«_paramsDecl(allVariables(constr))») {
					super("«constr.message.text»");
					«_paramsAssignment(allVariables(constr))»
				}
			
				«_getters("public final", allVariables(constr))»
			
			}
		'''
	}

}
