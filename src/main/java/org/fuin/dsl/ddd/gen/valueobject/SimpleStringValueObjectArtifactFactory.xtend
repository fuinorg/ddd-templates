package org.fuin.dsl.ddd.gen.valueobject

import java.lang.annotation.Documented
import java.lang.annotation.ElementType
import java.lang.annotation.Retention
import java.lang.annotation.RetentionPolicy
import java.lang.annotation.Target
import java.util.Map
import javax.validation.Constraint
import javax.validation.ConstraintValidator
import javax.validation.ConstraintValidatorContext
import javax.validation.Payload
import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.objects4j.common.ConstraintViolationException
import org.fuin.objects4j.vo.AbstractStringValueObject
import org.fuin.objects4j.vo.ValueObjectConverter
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class SimpleStringValueObjectArtifactFactory extends AbstractSource<ValueObject> {

	override getModelType() {
		typeof(ValueObject)
	}

	override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		if (valueObject.base === null || valueObject.base.name != "String") {
			// Do not generate anything
			return null
		}

		val className = valueObject.name
		val Namespace ns = valueObject.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(valueObject.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports(valueObject, jpa, jaxb, jsonb)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, ns, valueObject, pkg, className, jpa, jaxb, jsonb).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx, ValueObject vo, boolean jpa, boolean jaxb, boolean jsonb) {
		ctx.requiresImport(Documented.name)
		ctx.requiresImport(ElementType.name)
		ctx.requiresImport(Retention.name)
		ctx.requiresImport(RetentionPolicy.name)
		ctx.requiresImport(Target.name)
		if (jaxb) {
			ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")		
		}
		if (jsonb) {
			ctx.requiresImport("javax.json.bind.adapter.JsonbAdapter")		
		}
		if (jpa) {
			ctx.requiresImport("javax.persistence.AttributeConverter")		
		}		
		ctx.requiresImport(Constraint.name)
		ctx.requiresImport(ConstraintValidator.name)
		ctx.requiresImport(ConstraintValidatorContext.name)
		ctx.requiresImport(Payload.name)
		ctx.requiresImport(NotNull.name)
		ctx.requiresImport(ConstraintViolationException.name)
		ctx.requiresImport(AbstractStringValueObject.name)
		ctx.requiresImport(ValueObjectConverter.name)
		
	}

	def create(SimpleCodeSnippetContext ctx, Namespace ns, ValueObject vo, String pkg, String className, boolean jpa, boolean jaxb, boolean jsonb) {
		val String src = ''' 
			«new SrcJavaDocType(vo)»
			public final class «className» extends AbstractStringValueObject {
			
				private static final long serialVersionUID = 1000L;
			
				private static final int MAX_LENGTH = 100;
			
				private final String value;
			
				/**
				 * Constructor with mandatory data.
				 * 
				 * @param value
				 *            Value.
				 */
				public «className»(final String value) {
					super();
					requireArgValid("value", value);
					this.value = value;
				}
			
				@Override
				public final String asBaseType() {
					return value;
				}
			
				/**
				 * Verifies that a given string can be converted into the type.
				 * 
				 * @param value
				 *            Value to validate.
				 * 
				 * @return Returns <code>true</code> if it's a valid type else
				 *         <code>false</code>.
				 */
				public static boolean isValid(final String value) {
					if (value == null) {
						return true;
					}
					if (value.length() == 0) {
						return false;
					}
					final String trimmed = value.trim();
					if (trimmed.length() > MAX_LENGTH) {
						return false;
					}
					return true;
				}
			
				/**
				 * Verifies if the argument is valid and throws an exception if this is not
				 * the case.
				 * 
				 * @param name
				 *            Name of the value for a possible error message.
				 * @param value
				 *            Value to check.
				 * 
				 * @throws ConstraintViolationException
				 *             The value was not valid.
				 */
				public static void requireArgValid(@NotNull final String name,
						@NotNull final String value) throws ConstraintViolationException {
			
					if (!isValid(value)) {
						throw new ConstraintViolationException("The argument '" + name
								+ "' is not valid: '" + value + "'");
					}
			
				}
			
				/**
				 * Ensures that the string can be converted into the type.
				 */
				@Target({ ElementType.METHOD, ElementType.PARAMETER, ElementType.FIELD,
						ElementType.ANNOTATION_TYPE })
				@Retention(RetentionPolicy.RUNTIME)
				@Constraint(validatedBy = { Validator.class })
				@Documented
				public static @interface «className»Str {
			
					String message()
			
					default "{«pkg».«className».message}";
			
					Class<?>[] groups() default {};
			
					Class<? extends Payload>[] payload() default {};
			
				}
			
				/**
				 * Validates if a string is compliant with the type.
				 */
				public static final class Validator implements
						ConstraintValidator<«className»Str, String> {
			
					@Override
					public final void initialize(
							final «className»Str annotation) {
						// Not used
					}
			
					@Override
					public final boolean isValid(final String value,
							final ConstraintValidatorContext context) {
						return «className».isValid(value);
					}
			
				}
			
				/**
				 * Converts the value object from/to string.
				 */
				public static final class Converter «IF jaxb»extends XmlAdapter<String, «className»>«ENDIF»
						implements ValueObjectConverter<String, «className»>
						«IF jpa», AttributeConverter<«className», String>«ENDIF»
						«IF jsonb», JsonbAdapter<«className», String>«ENDIF» {
			
					// Attribute Converter
			
					@Override
					public final Class<String> getBaseTypeClass() {
						return String.class;
					}
			
					@Override
					public final Class<«className»> getValueObjectClass() {
						return «className».class;
					}
			
					@Override
					public boolean isValid(final String value) {
						return «className».isValid(value);
					}
			
					@Override
					public final «className» toVO(final String value) {
						if (value == null) {
							return null;
						}
						return new «className»(value);
					}
			
					@Override
					public final String fromVO(final «className» value) {
						if (value == null) {
							return null;
						}
						return value.asBaseType();
					}
			
					«IF jaxb»
					// JAXB XML Adapter

					@Override
					public final «className» unmarshal(final String str)
							throws Exception {
						return toVO(str);
					}

					@Override
					public final String marshal(final «className» obj)
							throws Exception {
						return fromVO(obj);
					}

					«ENDIF»
					«IF jpa»
					// JPA Attribute Converter

					@Override
					public final String convertToDatabaseColumn(
							final «className» obj) {
						return fromVO(obj);
					}

					@Override
					public final «className» convertToEntityAttribute(
							final String str) {
						return toVO(str);
					}

					«ENDIF»
					«IF jsonb»
					// JSONB Adapter

					@Override
					public final String adaptToJson(final «className» obj)
							throws Exception {
						return fromVO(obj);
					}

					@Override
					public final «className» adaptFromJson(
							final String str) throws Exception {
						return toVO(str);
					}

					«ENDIF»
				}
			
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
