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

import java.io.Serializable;
import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.vo.AbstractStringValueObject;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Value object multiple attributes and base.
 */
public final class MyValueObject3 extends AbstractStringValueObject implements ValueObject, Serializable {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	private String a;
	
	@NotNull
	private String b;
	
	/**
	 * Default constructor.
	 */
	protected MyValueObject3() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param a Persistent value A.
	 * @param b Persistent value B.
	 */
	public MyValueObject3(@NotNull final String a, @NotNull final String b) {
		super();
		Contract.requireArgNotNull("a", a);
		Contract.requireArgNotNull("b", b);
		
		this.a = a;
		this.b = b;
	}
	
	/**
	 * Returns: Persistent value A.
	 *
	 * @return Current value.
	 */
	@NotNull
	public final String getA() {
		return a;
	}
	
	/**
	 * Returns: Persistent value B.
	 *
	 * @return Current value.
	 */
	@NotNull
	public final String getB() {
		return b;
	}
	
	@Override
	public final String asBaseType() {
		// TODO Implement!
		return null;
	}
	
	/**
	 * Returns the information if a given string can be converted into
	 * an instance of MyValueObject3. A <code>null</code> value returns <code>true</code>.
	 * 
	 * @param value
	 *            Value to check.
	 * 
	 * @return TRUE if it's a valid string, else FALSE.
	 */
	public static boolean isValid(final String value) {
		if (value == null) {
			return true;
		}
		// TODO Verify the value is valid!
		return true;
	}
	
	/**
	 * Parses a given string and returns a new instance of MyValueObject3.
	 * 
	 * @param value
	 *            Value to convert. A <code>null</code> value returns
	 *            <code>null</code>.
	 * 
	 * @return Converted value.
	 */
	public static MyValueObject3 valueOf(final String value) {
		if (value == null) {
			return null;
		}
		// TODO Parse string value and return new instance! 
		// return new MyValueObject3(value);
		return null;
	}
	
}
