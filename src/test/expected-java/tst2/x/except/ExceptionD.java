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
package tst2.x.except;

import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.KeyValue;

/**
 * Exception D - No CID - Multiple variables
 */
public final class ExceptionD extends Exception {

	private static final long serialVersionUID = 1000L;

	@NotNull
	private String a;
	
	@NotNull
	private Integer b;
	
	/**
	 * Constructs a new instance of the exception.
	 *
	 * @param a A.
	 * @param b B.
	 */
	public ExceptionD(@NotNull final String a, @NotNull final Integer b) {
		super(KeyValue.replace("Exception D: ${a} / ${b}",  new KeyValue("a", a), new KeyValue("b", b)));
		Contract.requireArgNotNull("a", a);
		Contract.requireArgNotNull("b", b);
		
		this.a = a;
		this.b = b;
	}

	/**
	 * Returns: A.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getA() {
		return a;
	}
	
	/**
	 * Returns: B.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final Integer getB() {
		return b;
	}
	
}
