/**
 * Copyright (C) 2015 Michael Schnell. All rights
 * reserved. <http://www.fuin.org/>
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
 * along with this library. If not, see <http://www.gnu.org/licenses/>.
 */
package tst.x.entityid;

import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import org.fuin.objects4j.common.Immutable;
import tst2.x.entityid.MyEntity3IdConverter;

/**
 * Entity ID multiple attributes and base.
 */
@Immutable
@XmlJavaTypeAdapter(MyEntity3IdConverter.class)
public final class MyEntity3Id extends AbstractMyEntity3Id {

	private static final long serialVersionUID = 1000L;
	
	@Override
	public final String asString() {
		// TODO Implement!
		return null;
	}

	@Override
	public final String asBaseType() {
		// TODO Implement!
		return null;
	}
	
	/**
	 * Returns the information if a given string can be converted into
	 * an instance of MyEntity3Id. A <code>null</code> value returns <code>true</code>.
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
	 * Parses a given string and returns a new instance of MyEntity3Id.
	 * 
	 * @param value
	 *            Value to convert. A <code>null</code> value returns
	 *            <code>null</code>.
	 * 
	 * @return Converted value.
	 */
	public static MyEntity3Id valueOf(final String value) {
		if (value == null) {
			return null;
		}
		// TODO Parse string value and return new instance! 
		// return new MyEntity3Id(value);
		return null;
	}
	
}
