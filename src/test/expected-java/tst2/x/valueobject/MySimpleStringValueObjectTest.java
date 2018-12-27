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

import nl.jqno.equalsverifier.EqualsVerifier;
import nl.jqno.equalsverifier.Warning;
import org.fuin.utils4j.Utils4J;
import org.junit.Test;
import static org.assertj.core.api.Assertions.*;
import x.valueobject.MySimpleStringValueObject;

// CHECKSTYLE:OFF
public final class MySimpleStringValueObjectTest {

	@Test
	public void testSerialize() {
		final MySimpleStringValueObject original = new MySimpleStringValueObject("one");
		final MySimpleStringValueObject copy = Utils4J.deserialize(Utils4J.serialize(original));
		assertThat(original).isEqualTo(copy);
	}

	@Test
	public void testHashCodeEquals() {
		EqualsVerifier.forClass(MySimpleStringValueObject.class).suppress(Warning.NULL_FIELDS).withRedefinedSuperclass().verify();
	}

	@Test
	public void testMarshalJson() throws Exception {

		// PREPARE
		final String str = "one";
		final MySimpleStringValueObject testee = new MySimpleStringValueObject(str);

		// TEST & VERIFY
		assertThat(new MySimpleStringValueObject.Converter().adaptToJson(testee)).isEqualTo(str);
		assertThat(new MySimpleStringValueObject.Converter().adaptToJson(null)).isNull();

	}

	@Test
	public void testUnmarshalJson() throws Exception {

		// PREPARE
		final String str = "one";
		final MySimpleStringValueObject testee = new MySimpleStringValueObject(str);

		// TEST & VERIFY
		assertThat(new MySimpleStringValueObject.Converter().adaptFromJson(str)).isEqualTo(testee);
		assertThat(new MySimpleStringValueObject.Converter().adaptFromJson(null)).isNull();

	}

	@Test
	public void testMarshalXml() throws Exception {

		// PREPARE
		final String str = "one";
		final MySimpleStringValueObject testee = new MySimpleStringValueObject(str);

		// TEST & VERIFY
		assertThat(new MySimpleStringValueObject.Converter().marshal(testee)).isEqualTo(str);
		assertThat(new MySimpleStringValueObject.Converter().marshal(null)).isNull();

	}

	@Test
	public void testUnmarshalXml() throws Exception {

		// PREPARE
		final String str = "one";
		final MySimpleStringValueObject testee = new MySimpleStringValueObject(str);

		// TEST & VERIFY
		assertThat(new MySimpleStringValueObject.Converter().unmarshal(str)).isEqualTo(testee);
		assertThat(new MySimpleStringValueObject.Converter().unmarshal(null)).isNull();

	}

	@Test
	public void testIsValid() {

		assertThat(MySimpleStringValueObject.isValid(null)).isTrue();
		assertThat(MySimpleStringValueObject.isValid("one")).isTrue();

		fail("Implement assertions with some invalid values!");
		/*
		assertThat(MySimpleStringValueObject.isValid("")).isFalse();
		assertThat(MySimpleStringValueObject.isValid("Invalid value xhjgahgjhsgd")).isFalse();
		*/

	}

	@Test
	public void testRequireArgValid() {

		MySimpleStringValueObject.requireArgValid("a", "one");
		MySimpleStringValueObject.requireArgValid("b", null);

		fail("Implement assertions with some invalid values!");
		/*
		try {
			MySimpleStringValueObject.requireArgValid("c", "");
			Assert.fail();
		} catch (final ConstraintViolationException ex) {
			assertThat(ex.getMessage()).isEqualTo("The argument 'c' is not valid: ''");
		}

		try {
			MySimpleStringValueObject.requireArgValid("d", "Invalid value xhjgahgjhsgd");
			Assert.fail();
		} catch (final ConstraintViolationException ex) {
			assertThat(ex.getMessage()).isEqualTo("The argument 'd' is not valid: 'Invalid value xhjgahgjhsgd'");
		}
		*/

	}

	@Test
	public void testValidator() {

		assertThat(new MySimpleStringValueObject.Validator().isValid(null, null)).isTrue();
		assertThat(new MySimpleStringValueObject.Validator().isValid("one", null)).isTrue();

		fail("Implement assertions with some invalid values!");
		/*
		assertThat(new MySimpleStringValueObject.Validator().isValid("", null)).isFalse();
		assertThat(new MySimpleStringValueObject.Validator().isValid("Invalid value xhjgahgjhsgd", null)).isFalse();
		*/

	}

	@Test
	public void testValueObjectConverter() {

		assertThat(new MySimpleStringValueObject.Converter().getBaseTypeClass()).isEqualTo(String.class);
		assertThat(new MySimpleStringValueObject.Converter().getValueObjectClass()).isEqualTo(MySimpleStringValueObject.class);
		assertThat(new MySimpleStringValueObject.Converter().isValid(null)).isTrue();
		assertThat(new MySimpleStringValueObject.Converter().isValid("one")).isTrue();
		fail("Implement assertions with some invalid values!");
		/*
		assertThat(new MySimpleStringValueObject.Converter().isValid("Invalid value xhjgahgjhsgd")).isFalse();
		*/

	}

}

// CHECKSTYLE:ON
