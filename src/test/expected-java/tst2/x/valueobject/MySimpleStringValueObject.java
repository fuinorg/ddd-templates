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

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.json.bind.adapter.JsonbAdapter;
import javax.persistence.AttributeConverter;
import javax.validation.Constraint;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import javax.validation.Payload;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.fuin.objects4j.common.ConstraintViolationException;
import org.fuin.objects4j.vo.AbstractStringValueObject;
import org.fuin.objects4j.vo.ValueObjectConverter;

/**
 * Simple value object single attribute and base.
 */
public final class MySimpleStringValueObject extends AbstractStringValueObject {

	private static final long serialVersionUID = 1000L;

	private static final int MAX_LENGTH = 100;

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
	public static @interface MySimpleStringValueObjectStr {

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
		public final void initialize(
				final MySimpleStringValueObjectStr annotation) {
			// Not used
		}

		@Override
		public final boolean isValid(final String value,
				final ConstraintValidatorContext context) {
			return MySimpleStringValueObject.isValid(value);
		}

	}

	/**
	 * Converts the value object from/to string.
	 */
	public static final class Converter extends XmlAdapter<String, MySimpleStringValueObject>
			implements ValueObjectConverter<String, MySimpleStringValueObject>
			, AttributeConverter<MySimpleStringValueObject, String>
			, JsonbAdapter<MySimpleStringValueObject, String> {

		// Attribute Converter

		@Override
		public final Class<String> getBaseTypeClass() {
			return String.class;
		}

		@Override
		public final Class<MySimpleStringValueObject> getValueObjectClass() {
			return MySimpleStringValueObject.class;
		}

		@Override
		public boolean isValid(final String value) {
			return MySimpleStringValueObject.isValid(value);
		}

		@Override
		public final MySimpleStringValueObject toVO(final String value) {
			if (value == null) {
				return null;
			}
			return new MySimpleStringValueObject(value);
		}

		@Override
		public final String fromVO(final MySimpleStringValueObject value) {
			if (value == null) {
				return null;
			}
			return value.asBaseType();
		}

		// JAXB XML Adapter

		@Override
		public final MySimpleStringValueObject unmarshal(final String str)
				throws Exception {
			return toVO(str);
		}

		@Override
		public final String marshal(final MySimpleStringValueObject obj)
				throws Exception {
			return fromVO(obj);
		}

		// JPA Attribute Converter

		@Override
		public final String convertToDatabaseColumn(
				final MySimpleStringValueObject obj) {
			return fromVO(obj);
		}

		@Override
		public final MySimpleStringValueObject convertToEntityAttribute(
				final String str) {
			return toVO(str);
		}

		// JSONB Adapter

		@Override
		public final String adaptToJson(final MySimpleStringValueObject obj)
				throws Exception {
			return fromVO(obj);
		}

		@Override
		public final MySimpleStringValueObject adaptFromJson(
				final String str) throws Exception {
			return toVO(str);
		}

	}

}
