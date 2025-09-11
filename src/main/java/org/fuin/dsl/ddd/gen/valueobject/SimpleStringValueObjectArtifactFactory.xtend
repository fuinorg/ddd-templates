package org.fuin.dsl.ddd.gen.valueobject

import java.util.Map
import org.fuin.dsl.cqrs.cqrsDsl.Namespace
import org.fuin.dsl.cqrs.cqrsDsl.ValueObject
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.dsl.ddd.gen.base.SrcMetaAnnotations
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import java.util.List

class SimpleStringValueObjectArtifactFactory extends AbstractSource<ValueObject> {

    override getModelType() {
        typeof(ValueObject)
    }

    override create(ValueObject valueObject, Map<String, Object> context, boolean preparationRun) throws GenerateException {

        if (valueObject.base === null || valueObject.base.name != "String" || valueObject.attributes.size < 1) {
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
        ctx.addImports(valueObject)

        return List.of(new GeneratedArtifact(artifactName, filename,
            create(ctx, ns, valueObject, pkg, className).toString().getBytes("UTF-8")));
    }

    def addImports(CodeSnippetContext ctx, ValueObject vo) {
        ctx.requiresImport("jakarta.validation.constraints.NotNull")
        ctx.requiresImport("jakarta.validation.Constraint")
        ctx.requiresImport("jakarta.validation.ConstraintValidator")
        ctx.requiresImport("jakarta.validation.ConstraintValidatorContext")
        ctx.requiresImport("jakarta.validation.Payload")
        ctx.requiresImport("jakarta.validation.constraints.NotNull")
        ctx.requiresImport("java.io.Serial");
        ctx.requiresImport("java.lang.annotation.Documented")
        ctx.requiresImport("java.lang.annotation.ElementType")
        ctx.requiresImport("jakarta.annotation.Generated")
        ctx.requiresImport("java.lang.annotation.Retention")
        ctx.requiresImport("java.lang.annotation.RetentionPolicy")
        ctx.requiresImport("java.lang.annotation.Target")
        ctx.requiresImport("org.fuin.objects4j.common.AsStringCapable")
        ctx.requiresImport("org.fuin.objects4j.common.HasPublicStaticIsValidMethod")
        ctx.requiresImport("org.fuin.objects4j.common.HasPublicStaticValueOfMethod")
        ctx.requiresImport("org.fuin.objects4j.common.ConstraintViolationException")
        ctx.requiresImport("org.fuin.objects4j.common.ValueObjectWithBaseType")
        ctx.requiresImport("javax.annotation.concurrent.Immutable")
        ctx.requiresImport("java.util.Objects")
        ctx.requiresImport("java.io.Serializable")
        if (options.jaxb) {
            ctx.requiresImport("jakarta.xml.bind.annotation.adapters.XmlAdapter")        
        }
        if (options.jsonb) {
            ctx.requiresImport("jakarta.json.bind.adapter.JsonbAdapter")        
        }
        if (options.jpa) {
            ctx.requiresImport("jakarta.persistence.AttributeConverter")        
        }        
        
    }
    
    def create(SimpleCodeSnippetContext ctx, Namespace ns, ValueObject vo, String pkg, String className) {
        val String src = ''' 
            «new SrcJavaDocType(vo)»
            «new SrcMetaAnnotations(ctx, vo.metaInfo, ns.name.toFirstUpper, className)»
            @Immutable
            @Generated("Generated class - Manual changes will be overwritten")
            @HasPublicStaticIsValidMethod
            @HasPublicStaticValueOfMethod
            public final class «className» implements ValueObjectWithBaseType<String>, Comparable<«className»>, Serializable, AsStringCapable {
            
                @Serial
                private static final long serialVersionUID = 1000L;
            
                private static final int MAX_LENGTH = 100;
            
                «IF vo.attributes.iterator.next.nullable === null»
                @NotNull
                «ELSE»
                @Nullable
                «ENDIF»
                @«className»Str
                private String value;
            
                /**
                 * Protected default constructor for deserialization.
                 */
                protected «className»() {
                    super();
                }
            
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
                public String asBaseType() {
                    return value;
                }

                @Override
                public String toString() {
                    return value;
                }

                @Override
                public String asString() {
                    return value;
                }

                @Override
                public int hashCode() {
                    return Objects.hash(value);
                }

                @Override
                public boolean equals(Object obj) {
                    if (this == obj) {
                        return true;
                    }
                    if (obj == null) {
                        return false;
                    }
                    if (getClass() != obj.getClass()) {
                        return false;
                    }
                    final «className» other = («className») obj;
                    return Objects.equals(value, other.value);
                }

                @Override
                public int compareTo(final «className» other) {
                    return value.compareTo(other.value);
                }

                @Override
                @NotNull
                public Class<String> getBaseType() {
                    return String.class;
                }
            
                /**
                 * Verifies that a given string can be converted into the type.
                 * 
                 * @param value
                 *            Value to validate.
                 * 
                 * @return Returns {@literal true} if it's a valid type else {@literal false}.
                 */
                public static boolean isValid(final String value) {
                    if (value == null) {
                        return true;
                    }
                    if (value.isEmpty()) {
                        return false;
                    }
                    final String trimmed = value.trim();
                    return trimmed.length() <= MAX_LENGTH;
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
                public static void requireArgValid(@NotNull final String name, @NotNull final String value) throws ConstraintViolationException {
            
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
                public @interface «className»Str {
            
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
                    public void initialize(
                            final «className»Str annotation) {
                        // Not used
                    }
            
                    @Override
                    public boolean isValid(final String value,
                            final ConstraintValidatorContext context) {
                        return «className».isValid(value);
                    }
            
                }
            
                «IF options.jaxb || options.jsonb || options.jpa»
                /**
                 * Converts the value object from/to String.
                 */
                public static final class Converter «IF options.jaxb»extends XmlAdapter<String, «className»> «ENDIF»«IF options.jpa && options.jsonb»implements AttributeConverter<«className», String>, JsonbAdapter<«className», String>«ELSE»«IF options.jsonb»implements JsonbAdapter<«className», String>«ENDIF»«IF options.jpa»implements AttributeConverter<«className», String>«ENDIF»«ENDIF» {

                    // General methods

                    /**
                     * Converts the String into a «className». A {@literal null} parameter will return {@literal null}.
                     * 
                     * @param value
                     *            String to convert into a «className».
                     * 
                     * @return Value object of type «className».
                     */
                    public «className» toVO(final String value) {
                        if (value == null) {
                            return null;
                        }
                        return new «className»(value);
                    }

                    /**
                     * Converts a «className» into a String. A {@literal null} parameter will return {@literal null}.
                     * 
                     * @param value
                     *            Value object of type «className».
                     * 
                     * @return String.
                     */
                    public String fromVO(final «className» value) {
                        if (value == null) {
                            return null;
                        }
                        return value.asBaseType();
                    }

                    «IF options.jaxb»
                    // JAXB XML Adapter

                    @Override
                    public «className» unmarshal(final String value) throws Exception {
                        return toVO(value);
                    }

                    @Override
                    public String marshal(final «className» obj) throws Exception {
                        return fromVO(obj);
                    }

                    «ENDIF»
                    «IF options.jpa»
                    // JPA Attribute Converter

                    @Override
                    public String convertToDatabaseColumn(final «className» obj) {
                        return fromVO(obj);
                    }

                    @Override
                    public «className» convertToEntityAttribute(final String value) {
                        return toVO(value);
                    }

                    «ENDIF»
                    «IF options.jsonb»
                    // JSONB Adapter

                    @Override
                    public String adaptToJson(final «className» obj) throws Exception {
                        return fromVO(obj);
                    }

                    @Override
                    public «className» adaptFromJson(final String value) throws Exception {
                        return toVO(value);
                    }

                    «ENDIF»
                }
                «ENDIF»
            
            }
        '''

        new SrcAll(ctx, copyrightHeader, pkg, ctx.imports, src).toString

    }

}
