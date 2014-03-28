package org.fuin.dsl.ddd.gen.constraint

import java.util.HashSet
import java.util.Set
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValidatorArtifactFactory extends AbstractSource implements ArtifactFactory<Constraint> {

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
		val String filename = (ns.getName() + "." + constraint.getName() + "Validator").replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(constraint, ns).toString().getBytes("UTF-8"));
	}

	def create(Constraint c, Namespace ns) {
		var ConstraintTarget target = c.target;

		// TODO The following code is not nice... 
		// Don't know why ConstraintTarget has no "getName()" method...
		var Set<String> imports = new HashSet<String>();
		imports.addAll(createImportSet(c));
		var String targetName;
		if (target instanceof ExternalType) {
			targetName = (target as ExternalType).name;
			imports.addAll(createImportSet((target as ExternalType)));
		} else if (target instanceof ValueObject) {
			targetName = (target as ValueObject).name;
			imports.addAll(createImportSet((target as ValueObject)));
		} else {
			targetName = target.toString;
		}

		''' 
			package «ns.name»;
			
			import javax.validation.ConstraintValidator;
			import javax.validation.ConstraintValidatorContext;
			«FOR imp : imports»
				import «imp»;
			«ENDFOR»
			
			/** «c.doc.text» */
			public class «c.name»Validator extends Abstract«c.name»Validator {
			
			    public void initialize(«c.name» annotation) {
			        // TODO Implement!
			    }
			
			    public boolean isValid(«targetName» object, ConstraintValidatorContext ctx) {
			        // TODO Implement!
					return true;
			  }
			
			}
		'''
	}

}