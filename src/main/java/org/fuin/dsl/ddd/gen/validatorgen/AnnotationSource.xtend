package org.fuin.dsl.ddd.gen.validatorgen

import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

class AnnotationSource extends AbstractSource implements ArtifactFactory<Constraint> {
	
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
        val String filename = (ns.getName() + "." + constraint.getName()).replace('.', '/') + ".java";
		return new GeneratedArtifact("ValidatorAnnotation", filename, create(constraint, ns).toString());
	}
	
	def create(Constraint c, Namespace ns) { 
		''' 
		package «ns.name»;
		
		import static java.lang.annotation.ElementType.*;
		import static java.lang.annotation.RetentionPolicy.*;
		
		import java.lang.annotation.Documented;
		import java.lang.annotation.Retention;
		import java.lang.annotation.Target;
		
		import javax.validation.Constraint;
		import javax.validation.Payload;
		
		/** «c.doc.text» */
		@Target( { METHOD, FIELD, ANNOTATION_TYPE, PARAMETER })
		@Retention(RUNTIME)
		@Constraint(validatedBy = «c.name»Validator.class)
		@Documented
		public @interface «c.name» {
		
		    String message() default "«c.message.text»";
		
		    Class<?>[] groups() default {};
		
		    Class<? extends Payload>[] payload() default {};
		
			«IF c.variables.size == 1»
				«asJavaPrimitive(c.variables.last)» value();
			«ELSEIF c.variables.size > 1»
			«FOR v:c.variables»	
				«asJavaPrimitive(v)» «v.name»();
			«ENDFOR»
			«ENDIF»
		}
		'''	
	}
	
}