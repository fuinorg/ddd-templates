package org.fuin.dsl.ddd.gen.constraint

import org.fuin.dsl.ddd.gen.base.AbstractSource
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractElement
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintTarget
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValidatorArtifactFactory extends AbstractSource<Constraint> {

	override getModelType() {
		typeof(Constraint)
	}

	override create(Constraint constraint) throws GenerateException {
		if (constraint.target == null) {
			return null;
		}
		val Namespace ns = constraint.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + constraint.getName() + "Validator").replace('.', '/') +
			".java";
		return new GeneratedArtifact(artifactName, filename, create(constraint, ns).toString().getBytes("UTF-8"));
	}

	def create(Constraint c, Namespace ns) {
		var ConstraintTarget target = c.target;

		// TODO The following code is not nice... 
		// Don't know why ConstraintTarget has no "getName()" method...
		var Set<String> imports = new HashSet<String>();
		imports.addAll(createImportSet(c));
		var String targetName;
		var List<Variable> variables;
		if (target instanceof ValueObject) {
			var ValueObject vo = target as ValueObject
			targetName = vo.name;
			imports.addAll(createImportSet((target as AbstractElement)));
			variables = vo.variables 			
		} else if (target instanceof ExternalType) {
			var type = target as ExternalType
			targetName = type.name;
			variables = new ArrayList<Variable>();
		} else {
			targetName = target.toString;
			variables = new ArrayList<Variable>();
		}

		''' 
		«copyrightHeader» 
		package «ns.asPackage»;
		
		import javax.validation.Validator;
		import javax.validation.ConstraintValidator;
		import javax.validation.ConstraintValidatorContext;
		«FOR imp : imports»
			import «imp»;
		«ENDFOR»
		
		/** «c.doc.text» */
		// CHECKSTYLE:OFF:LineLength
		public final class «c.name»Validator implements ConstraintValidator<«c.name», «targetName»> {
			// CHECKSTYLE:ON:LineLength
		
		    @Override
		    public final void initialize(final «c.name» annotation) {
		        // TODO Implement!
		    }
		
		    @Override
		    public final boolean isValid(final «targetName» object, final ConstraintValidatorContext ctx) {
		        // TODO Implement!
				return true;
			}
		
			«IF c.exception != null»
			/**
			 * Verifies if the argument is valid an throws an exception otherwise.
			 * 
			 * @param validator Validator to use.
			 * @param obj Object to validate.
			 * 
			 * @throws «c.exception.name» The constraint was violated.
			 */
			public static void requireValid(final Validator validator, final «targetName» obj) throws «c.exception.name» {
				if (validator .validate(obj).size() > 0) {
					throw new «c.exception.name»(«FOR v : variables SEPARATOR ', '»«_get("obj", v)»«ENDFOR»);
				}
			}
			
			«ENDIF»
		}
		
		'''
	}

}
