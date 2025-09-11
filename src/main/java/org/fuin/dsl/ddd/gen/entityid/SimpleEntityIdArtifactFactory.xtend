package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.cqrs.cqrsDsl.EntityId
import org.fuin.dsl.cqrs.cqrsDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDocType
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEntityIdExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import java.util.List
import org.fuin.dsl.ddd.gen.base.SrcMetaAnnotations

class SimpleEntityIdArtifactFactory extends AbstractSource<EntityId> {

    override getModelType() {
        typeof(EntityId)
    }

    override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

        if (entityId.base === null || entityId.base.name != "Integer") {
            // Do not generate anything
            return null
        }

        val className = entityId.getName()
        val Namespace ns = entityId.eContainer() as Namespace;
        val pkg = ns.asPackage
        val fqn = pkg + "." + className
        val filename = fqn.replace('.', '/') + ".java";
        val CodeReferenceRegistry refReg = context.codeReferenceRegistry
        refReg.putReference(entityId.uniqueName, fqn)

        if (preparationRun) {

            // No code generation during preparation phase
            return null
        }

        val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
        ctx.addImports(entityId)
        ctx.addReferences(entityId)

        return List.of(new GeneratedArtifact(artifactName, filename,
            create(ctx, ns, entityId, pkg, className).toString().getBytes("UTF-8")));
    }

    def addImports(CodeSnippetContext ctx, EntityId aggregateId) {
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
        ctx.requiresImport("java.text.NumberFormat")
        ctx.requiresImport("java.text.ParsePosition")        
        ctx.requiresImport("org.fuin.ddd4j.core.IntegerEntityId")
        ctx.requiresImport("org.fuin.ddd4j.core.EntityType")
        ctx.requiresImport("org.fuin.ddd4j.core.StringBasedEntityType")
        ctx.requiresImport("org.fuin.ddd4j.core.HasEntityTypeConstant")
        ctx.requiresImport("org.fuin.objects4j.common.HasPublicStaticIsValidMethod")
        ctx.requiresImport("org.fuin.objects4j.common.HasPublicStaticValueOfMethod")
        ctx.requiresImport("org.fuin.objects4j.common.ConstraintViolationException");
        ctx.requiresImport("javax.annotation.concurrent.Immutable")
        if (options.jsonb) {
            ctx.requiresImport("jakarta.json.bind.adapter.JsonbAdapter")        
        }
        if (options.jpa) {
            ctx.requiresImport("jakarta.persistence.AttributeConverter")        
        }        
        if (options.jaxb) {
            ctx.requiresImport("jakarta.xml.bind.annotation.adapters.XmlAdapter")        
        }
    }

    def addReferences(CodeSnippetContext ctx, EntityId entityId) {
        // Do nothing
    }

    def create(SimpleCodeSnippetContext ctx, Namespace ns, EntityId id, String pkg, String className) {
        val src = '''
            «new SrcJavaDocType(id)»
            «new SrcMetaAnnotations(ctx, id.metaInfo, ns.name.toFirstUpper, className)»
            @Generated("Generated class - Manual changes will be overwritten")
            @Immutable
            @HasEntityTypeConstant
            @HasPublicStaticIsValidMethod
            @HasPublicStaticValueOfMethod
            public final class «className» extends IntegerEntityId {
            
                @Serial
                private static final long serialVersionUID = 1000L;

                /** Unique name of the aggregate this identifier refers to. */
                public static final EntityType TYPE = new StringBasedEntityType("«id.entityNullsafe.name»");
            
                private static final int MIN = 1;
            
                /**
                 * Constructor with mandatory data.
                 *
                 * @param value
                 *            Persistent value.
                 */
                public «className»(@NotNull final Integer value) {
                    this(value, true);
                }
            
                private «className»(@NotNull final Integer value, final boolean strict) {
                    super(TYPE, value);
                    if (strict & !isValid(value)) {
                        throw new ConstraintViolationException("The argument 'value' is not valid: '" + value + "'");            
                    }
                }
            
                /**
                 * Parses a given string and returns a new instance of «className».
                 * 
                 * @param value
                 *            String with valid Integer to convert. A {@literal null} value
                 *            returns {@literal null}.
                 * 
                 * @return Converted value.
                 */
                public static «className» valueOf(final String value) {
                    if (value == null) {
                        return null;
                    }
                    requireArgValid("value", value);
                    return new «className»(Integer.valueOf(value));
                }

                /**
                 * Verifies that a given integer can be converted into the type.
                 * 
                 * @param value
                 *            Value to validate.
                 * 
                 * @return Returns {@literal true}     if it's a valid type else {@literal false}    .
                 */
                public static boolean isValid(final Integer value) {
                    if (value == null) {
                        return true;
                    }
                    return value >= MIN;
                }
    
                /**
                 * Verifies that a given string can be converted into the type.
                 * 
                 * @param value
                 *            Value to validate.
                 * 
                 * @return Returns {@literal true}     if it's a valid type else {@literal false}    .
                 */
                public static boolean isValid(final String value) {
                    if (value == null) {
                        return true;
                    }
                    final ParsePosition pp = new ParsePosition(0);
                    final NumberFormat nf = NumberFormat.getInstance();
                    nf.setParseIntegerOnly(true);
                    final Number num = nf.parse(value, pp);
                    if (pp.getErrorIndex() != -1 || pp.getIndex() < value.length()) {
                        return false;
                    }
                    if (num instanceof Integer v) {
                        return isValid(v);
                    }
                    if (num instanceof Long v && v <= Integer.MAX_VALUE) {
                        return isValid(v.intValue());
                    }
                    return false;
                }

                /**
                 * Verifies if the argument is valid and throws an exception if this is not the case.
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
                        throw new ConstraintViolationException("The argument '" + name + "' is not valid: '" + value + "'");
                    }
                }

                /**
                 * Ensures that the string can be converted into the type.
                 */
                @Target({ ElementType.METHOD, ElementType.PARAMETER, ElementType.FIELD, ElementType.ANNOTATION_TYPE })
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
                public static final class Validator implements ConstraintValidator<«className»Str, String> {
            
                    @Override
                    public void initialize(final «className»Str annotation) {
                        // Not used
                    }
            
                    @Override
                    public boolean isValid(final String value, final ConstraintValidatorContext context) {
                        return «className».isValid(value);
                    }
            
                }
                
            
                «IF options.jaxb || options.jsonb || options.jpa»
                /**
                 * Converts the value object from/to Integer.
                 */
                public static final class Converter «IF options.jaxb»extends XmlAdapter<Integer, «className»> «ENDIF»«IF options.jpa && options.jsonb»implements AttributeConverter<«className», Integer>, JsonbAdapter<«className», Integer>«ELSE»«IF options.jsonb»implements JsonbAdapter<«className», Integer>«ENDIF»«IF options.jpa»implements AttributeConverter<«className», Integer>«ENDIF»«ENDIF» {

                    // General methods

                    /**
                     * Converts the Integer into a «className». A {@literal null} parameter will return {@literal null}.
                     * 
                     * @param value
                     *            Integer to convert into a «className».
                     * 
                     * @return Value object of type «className».
                     */
                    public «className» toVO(final Integer value) {
                        if (value == null) {
                            return null;
                        }
                        return new «className»(value);
                    }

                    /**
                     * Converts a «className» into a Integer. A {@literal null} parameter will return {@literal null}.
                     * 
                     * @param value
                     *            Value object of type «className».
                     * 
                     * @return Integer.
                     */
                    public Integer fromVO(final «className» value) {
                        if (value == null) {
                            return null;
                        }
                        return value.asBaseType();
                    }

                    «IF options.jaxb»
                    // JAXB XML Adapter

                    @Override
                    public «className» unmarshal(final Integer value) throws Exception {
                        return toVO(value);
                    }

                    @Override
                    public Integer marshal(final «className» obj) throws Exception {
                        return fromVO(obj);
                    }

                    «ENDIF»
                    «IF options.jpa»
                    // JPA Attribute Converter

                    @Override
                    public Integer convertToDatabaseColumn(final «className» obj) {
                        return fromVO(obj);
                    }

                    @Override
                    public «className» convertToEntityAttribute(final Integer value) {
                        return toVO(value);
                    }

                    «ENDIF»
                    «IF options.jsonb»
                    // JSONB Adapter

                    @Override
                    public Integer adaptToJson(final «className» obj) throws Exception {
                        return fromVO(obj);
                    }

                    @Override
                    public «className» adaptFromJson(final Integer value) throws Exception {
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
