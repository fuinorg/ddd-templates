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
package tst.x.aggregateid;

import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import org.fuin.objects4j.common.Immutable;
import tst2.x.aggregateid.MyAggregateIdConverter;

/**
 * Aggregate ID single attribute and base.
 */
@Immutable
@XmlJavaTypeAdapter(MyAggregateIdConverter.class)
public final class MyAggregateId extends AbstractMyAggregateId {

	private static final long serialVersionUID = 1000L;
	
	@Override
	public final String asBaseType() {
		return getValue();
	}
	
	@Override
	public final String asString() {
		return "" + getValue();
	}
	
	/**
	 * Returns the information if a given string can be converted into
	 * an instance of MyAggregateId. A <code>null</code> value returns <code>true</code>.
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
	 * Parses a given string and returns a new instance of MyAggregateId.
	 * 
	 * @param value
	 *            Value to convert. A <code>null</code> value returns
	 *            <code>null</code>.
	 * 
	 * @return Converted value.
	 */
	public static MyAggregateId valueOf(final String value) {
		if (value == null) {
			return null;
		}
		// TODO Parse string value and return new instance! 
		// return new MyAggregateId(value);
		return null;
	}
	
}
