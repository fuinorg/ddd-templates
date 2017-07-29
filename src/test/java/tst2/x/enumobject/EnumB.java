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
package tst2.x.enumobject;

import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Contract;

/** Enumeration type B - With variables. */
public enum EnumB {

	/** First. */
	A(1, "a", "First"),
	
		/** Second. */
	B(2, "b", "Second"),
	
		/** Third. */
	C(3, "c", "Third")
	
	;
	
	@NotNull
	private Integer id;
	
	@NotNull
	private String shortName;
	
	@NotNull
	private String longName;
	
	/** All instances. */
	public static final EnumB[] ALL = new EnumB[] {
		A, B, C
	};
	
	/** Valid instances. */
	public static final EnumB[] VALID = new EnumB[] {
		A, B, C
	};
	
	/** Deprecated instances. */
	public static final EnumB[] DEPRECTAED = new EnumB[] {
	};
	
	private EnumB(@NotNull final Integer id, @NotNull final String shortName, @NotNull final String longName) {
		Contract.requireArgNotNull("id", id);
		Contract.requireArgNotNull("shortName", shortName);
		Contract.requireArgNotNull("longName", longName);
		
		this.id = id;
		this.shortName = shortName;
		this.longName = longName;
	}

}
