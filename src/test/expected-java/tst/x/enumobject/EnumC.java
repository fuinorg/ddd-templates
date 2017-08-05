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


/** Enumeration type C - With deprecated instance. */
public final class EnumC {
	
	/** First. */
	public static final EnumC A = new EnumC();
	
	/** Second - Only kept for backward compatibility. */
	public static final EnumC B = new EnumC();
	
	/** Third. */
	public static final EnumC C = new EnumC();
	
	/** All instances. */
	public static final EnumC[] ALL = new EnumC[] {
		A, B, C
	};
	
	/** Valid instances. */
	public static final EnumC[] VALID = new EnumC[] {
		A, C
	};
	
	/** Deprecated instances. */
	public static final EnumC[] DEPRECTAED = new EnumC[] {
		B
	};
	
}
