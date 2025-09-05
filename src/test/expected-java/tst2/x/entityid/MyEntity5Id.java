/**
 * Copyright (C) 2015 Michael Schnell. All rights reserved. 
 * http://www.fuin.org/
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option) any
 * later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library. If not, see http://www.gnu.org/licenses/.
 */
package tst2.x.entityid;

import jakarta.annotation.Generated;
import jakarta.json.bind.adapter.JsonbAdapter;
import jakarta.persistence.AttributeConverter;
import jakarta.validation.Constraint;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import jakarta.validation.Payload;
import jakarta.validation.constraints.NotNull;
import jakarta.xml.bind.annotation.adapters.XmlAdapter;
import java.io.Serial;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.text.NumberFormat;
import java.text.ParsePosition;
import javax.annotation.concurrent.Immutable;
import org.fuin.ddd4j.core.EntityType;
import org.fuin.ddd4j.core.HasEntityTypeConstant;
import org.fuin.ddd4j.core.IntegerEntityId;
import org.fuin.ddd4j.core.StringBasedEntityType;
import org.fuin.objects4j.common.ConstraintViolationException;
import org.fuin.objects4j.common.HasPublicStaticIsValidMethod;
import org.fuin.objects4j.common.HasPublicStaticValueOfMethod;

/**
 * Entity ID no attribute and base Integer.
 */
@Generated("Generated class - Manual changes will be overwritten")
@Immutable
@HasEntityTypeConstant
@HasPublicStaticIsValidMethod
@HasPublicStaticValueOfMethod
public final class MyEntity5Id extends IntegerEntityId {

    @Serial
    private static final long serialVersionUID = 1000L;

    /** Unique name of the aggregate this identifier refers to. */
    public static final EntityType TYPE = new StringBasedEntityType("MyEntity5");

    private static final int MIN = 1;

    /**
     * Constructor with mandatory data.
     *
     * @param value
     *            Persistent value.
     */
    public MyEntity5Id(@NotNull final Integer value) {
        this(value, true);
    }

    private MyEntity5Id(@NotNull final Integer value, final boolean strict) {
        super(TYPE, value);
        if (strict & !isValid(value)) {
            throw new ConstraintViolationException("The argument 'value' is not valid: '" + value + "'");            
        }
    }

    /**
     * Parses a given string and returns a new instance of MyEntity5Id.
     * 
     * @param value
     *            String with valid Integer to convert. A {@literal null} value
     *            returns {@literal null}.
     * 
     * @return Converted value.
     */
    public static MyEntity5Id valueOf(final String value) {
        if (value == null) {
            return null;
        }
        requireArgValid("value", value);
        return new MyEntity5Id(Integer.valueOf(value));
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
    public @interface MyEntity5IdStr {

        String message()

        default "{tst2.x.entityid.MyEntity5Id.message}";

        Class<?>[] groups() default {};

        Class<? extends Payload>[] payload() default {};

    }

    /**
     * Validates if a string is compliant with the type.
     */
    public static final class Validator implements ConstraintValidator<MyEntity5IdStr, String> {

        @Override
        public void initialize(final MyEntity5IdStr annotation) {
            // Not used
        }

        @Override
        public boolean isValid(final String value, final ConstraintValidatorContext context) {
            return MyEntity5Id.isValid(value);
        }

    }
    

    /**
     * Converts the value object from/to Integer.
     */
    public static final class Converter extends XmlAdapter<Integer, MyEntity5Id> implements AttributeConverter<MyEntity5Id, Integer>, JsonbAdapter<MyEntity5Id, Integer> {

        // General methods

        /**
         * Converts the Integer into a MyEntity5Id. A {@literal null} parameter will return {@literal null}.
         * 
         * @param value
         *            Integer to convert into a MyEntity5Id.
         * 
         * @return Value object of type MyEntity5Id.
         */
        public MyEntity5Id toVO(final Integer value) {
            if (value == null) {
                return null;
            }
            return new MyEntity5Id(value);
        }

        /**
         * Converts a MyEntity5Id into a Integer. A {@literal null} parameter will return {@literal null}.
         * 
         * @param value
         *            Value object of type MyEntity5Id.
         * 
         * @return Integer.
         */
        public Integer fromVO(final MyEntity5Id value) {
            if (value == null) {
                return null;
            }
            return value.asBaseType();
        }

        // JAXB XML Adapter

        @Override
        public MyEntity5Id unmarshal(final Integer value) throws Exception {
            return toVO(value);
        }

        @Override
        public Integer marshal(final MyEntity5Id obj) throws Exception {
            return fromVO(obj);
        }

        // JPA Attribute Converter

        @Override
        public Integer convertToDatabaseColumn(final MyEntity5Id obj) {
            return fromVO(obj);
        }

        @Override
        public MyEntity5Id convertToEntityAttribute(final Integer value) {
            return toVO(value);
        }

        // JSONB Adapter

        @Override
        public Integer adaptToJson(final MyEntity5Id obj) throws Exception {
            return fromVO(obj);
        }

        @Override
        public MyEntity5Id adaptFromJson(final Integer value) throws Exception {
            return toVO(value);
        }

    }

}