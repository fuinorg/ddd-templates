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
package tst2.x.services;

import javax.validation.constraints.NotNull;

/**
 * Service B - Single method.
 */
public interface ServiceB {
	
	/**
	 * Finds something.
	 *
	 * @param a Key.
	 *
	 * @return Value.
	 *
	 * @throws AnyConstraintViolatedException The constraint was violated.
	 */
	public String find(@NotNull final Integer a) throws AnyConstraintViolatedException;
	
}
