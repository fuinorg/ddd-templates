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

import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;

/** Enumeration type D - With integer base type. */
public abstract class AbstractEnumD {
	
	@NotNull
	private Integer id;
	
	/**
	 * Enumeration type D - With integer base type.
	 *
	 * @param id Identifier.
	 */
	protected AbstractEnumD(@NotNull final Integer id) {
		Contract.requireArgNotNull("id", id);
		
		this.id = id;
	}

	/**
	 * Returns: Identifier.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final Integer getId() {
		return id;
	}
	
}
