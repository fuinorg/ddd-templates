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
package tst2.x.valueobject;

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
import java.io.Serializable;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.Objects;
import javax.annotation.concurrent.Immutable;
import org.fuin.objects4j.common.AsStringCapable;
import org.fuin.objects4j.common.ConstraintViolationException;
import org.fuin.objects4j.common.HasPublicStaticIsValidMethod;
import org.fuin.objects4j.common.HasPublicStaticValueOfMethod;
import org.fuin.objects4j.common.ValueObjectWithBaseType;
import org.fuin.objects4j.ui.Examples;

/**
 * Simple value object single attribute and base.
 */
@Examples(value = { "one","two","three" })
@Immutable
@Generated("Generated class - Manual changes will be overwritten")
@HasPublicStaticIsValidMethod
@HasPublicStaticValueOfMethod
public final class MySimpleStringValueObject implements ValueObjectWithBaseType<String>, Comparable<MySimpleStringValueObject>, Serializable, AsStringCapable {

    @Serial
    private static final long serialVersionUID = 1000L;

    private static final int MAX_LENGTH = 100;

    @NotNull
    @MySimpleStringValueObjectStr
    private String value;

    /**
     * Protected default constructor for deserialization.
     */
    protected MySimpleStringValueObject() {
        super();
    }

    /**
     * Constructor with mandatory data.
     * 
     * @param value
     *            Value.
     */
    public MySimpleStringValueObject(final String value) {
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
        final MySimpleStringValueObject other = (MySimpleStringValueObject) obj;
        return Objects.equals(value, other.value);
    }

    @Override
    public int compareTo(final MySimpleStringValueObject other) {
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
    public @interface MySimpleStringValueObjectStr {

        String message()

        default "{tst2.x.valueobject.MySimpleStringValueObject.message}";

        Class<?>[] groups() default {};

        Class<? extends Payload>[] payload() default {};

    }

    /**
     * Validates if a string is compliant with the type.
     */
    public static final class Validator implements
            ConstraintValidator<MySimpleStringValueObjectStr, String> {

        @Override
        public void initialize(
                final MySimpleStringValueObjectStr annotation) {
            // Not used
        }

        @Override
        public boolean isValid(final String value,
                final ConstraintValidatorContext context) {
            return MySimpleStringValueObject.isValid(value);
        }

    }

    /**
     * Converts the value object from/to String.
     */
    public static final class Converter extends XmlAdapter<String, MySimpleStringValueObject> implements AttributeConverter<MySimpleStringValueObject, String>, JsonbAdapter<MySimpleStringValueObject, String> {

        // General methods

        /**
         * Converts the String into a MySimpleStringValueObject. A {@literal null} parameter will return {@literal null}.
         * 
         * @param value
         *            String to convert into a MySimpleStringValueObject.
         * 
         * @return Value object of type MySimpleStringValueObject.
         */
        public MySimpleStringValueObject toVO(final String value) {
            if (value == null) {
                return null;
            }
            return new MySimpleStringValueObject(value);
        }

        /**
         * Converts a MySimpleStringValueObject into a String. A {@literal null} parameter will return {@literal null}.
         * 
         * @param value
         *            Value object of type MySimpleStringValueObject.
         * 
         * @return String.
         */
        public String fromVO(final MySimpleStringValueObject value) {
            if (value == null) {
                return null;
            }
            return value.asBaseType();
        }

        // JAXB XML Adapter

        @Override
        public MySimpleStringValueObject unmarshal(final String value) throws Exception {
            return toVO(value);
        }

        @Override
        public String marshal(final MySimpleStringValueObject obj) throws Exception {
            return fromVO(obj);
        }

        // JPA Attribute Converter

        @Override
        public String convertToDatabaseColumn(final MySimpleStringValueObject obj) {
            return fromVO(obj);
        }

        @Override
        public MySimpleStringValueObject convertToEntityAttribute(final String value) {
            return toVO(value);
        }

        // JSONB Adapter

        @Override
        public String adaptToJson(final MySimpleStringValueObject obj) throws Exception {
            return fromVO(obj);
        }

        @Override
        public MySimpleStringValueObject adaptFromJson(final String value) throws Exception {
            return toVO(value);
        }

    }

}
