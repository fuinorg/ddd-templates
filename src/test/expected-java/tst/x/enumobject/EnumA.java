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
package tst.x.enumobject;


/** Enumeration type A - No variables. */
public final class EnumA {
	
	/** First. */
	public static final EnumA A = new EnumA();
	
	/** Second. */
	public static final EnumA B = new EnumA();
	
	/** Third. */
	public static final EnumA C = new EnumA();
	
	/** All instances. */
	public static final EnumA[] ALL = new EnumA[] {
		A, B, C
	};
	
	/** Valid instances. */
	public static final EnumA[] VALID = new EnumA[] {
		A, B, C
	};
	
	/** Deprecated instances. */
	public static final EnumA[] DEPRECTAED = new EnumA[] {
	};
	
}
