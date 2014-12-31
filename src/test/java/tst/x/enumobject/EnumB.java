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
package tst.x.enumobject;

import javax.validation.constraints.NotNull;

/** Enumeration type B - With variables. */
public final class EnumB extends AbstractEnumB {
	
	/** First. */
	public static final EnumB A = new EnumB(1, "a", "First");
	
	/** Second. */
	public static final EnumB B = new EnumB(2, "b", "Second");
	
	/** Third. */
	public static final EnumB C = new EnumB(3, "c", "Third");
	
	/** All valid instances. */
	public static final EnumB[] VALUES = new EnumB[] {
	    A, B, C
	};
	
	/**
	 * Enumeration type B - With variables.
	 *
	 * @param id Integer
	 * @param shortName String
	 * @param longName String
	 *
	 */
	private EnumB(@NotNull final Integer id, @NotNull final String shortName, @NotNull final String longName) {
		super(id, shortName, longName);
	}
	
}
