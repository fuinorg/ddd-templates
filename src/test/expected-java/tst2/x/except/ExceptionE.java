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
import org.fuin.objects4j.common.UniquelyNumberedException;
import org.fuin.objects4j.vo.KeyValue;

/**
 * Exception E - With CID - Single variable
 */
public final class ExceptionE extends UniquelyNumberedException {

	private static final long serialVersionUID = 1000L;

	@NotNull
	private String a;
	
	/**
	 * Constructs a new instance of the exception.
	 *
	 * @param a A.
	 */
	public ExceptionE(@NotNull final String a) {
		super(124, KeyValue.replace("Exception C: ${a}",  new KeyValue("a", a)));
		Contract.requireArgNotNull("a", a);
		
		this.a = a;
	}

	/**
	 * Returns: A.
	 *
	 * @return Current value.
	 */
	 @NotNull
	public final String getA() {
		return a;
	}
	
}
