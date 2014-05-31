package org.fuin.dsl.ddd.gen.constraint

import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class ValidatorAnnotationArtifactFactory extends AbstractSource<Constraint> {
	
	override getModelType() {
		typeof(Constraint)
	}

	override create(Constraint constraint) throws GenerateException {
		if (constraint.target == null) {
			return null;
		}
		val Namespace ns = constraint.eContainer() as Namespace;
        val filename = (ns.asPackage + "." + "." + constraint.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact(artifactName, filename, create(constraint, ns).toString().getBytes("UTF-8"));
	}
	
	def String replaceValidatedValue(String msg) {
		var String newMsg = msg.replace("${vv_", "${validatedValue.");
		return newMsg.replace("${vv}", "${validatedValue}");
	}
	
	def create(Constraint c, Namespace ns) { 
		''' 
		«copyrightHeader»
		package «ns.asPackage»;
		
		import static java.lang.annotation.ElementType.*;
		import static java.lang.annotation.RetentionPolicy.*;
		
		import java.lang.annotation.Documented;
		import java.lang.annotation.Retention;
		import java.lang.annotation.Target;
		
		import javax.validation.Constraint;
		import javax.validation.Payload;
		
		/**
		 * «c.doc.text»
		 */
		@Target({ TYPE, METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })
		@Retention(RUNTIME)
		@Constraint(validatedBy = «c.name»Validator.class)
		@Documented
		// CHECKSTYLE:OFF:LineLength
		public @interface «c.name» {
		
			/** Used to create an error message. */
		    String message() default "«c.message.replaceValidatedValue»";

			/** Processing groups with which the constraint declaration is associated. */		
		    Class<?>[] groups() default {};
		
			/** Payload with which the the constraint declaration is associated. */
		    Class<? extends Payload>[] payload() default {};
		
			«IF c.variables.size == 1»
				«c.variables.last.doc»
				«asJavaPrimitive(c.variables.last)» value();
				
			«ELSEIF c.variables.size > 1»
			«FOR v:c.variables»	
				«v.doc»
				«asJavaPrimitive(v)» «v.name»();
				
			«ENDFOR»
			«ENDIF»
		}
		//CHECKSTYLE:ON:LineLength
		'''	
	}
	
}