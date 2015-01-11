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
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;

/** Enumeration type B - With variables. */
public abstract class AbstractEnumB {
	
	@NotNull
	private Integer id;
	
	@NotNull
	private String shortName;
	
	@NotNull
	private String longName;
	
	/**
	 * Enumeration type B - With variables.
	 *
	 * @param id Identifier.
	 * @param shortName Short name.
	 * @param longName Long name.
	 */
	protected AbstractEnumB(@NotNull final Integer id, @NotNull final String shortName, @NotNull final String longName) {
		Contract.requireArgNotNull("id", id);
		Contract.requireArgNotNull("shortName", shortName);
		Contract.requireArgNotNull("longName", longName);
		
		this.id = id;
		this.shortName = shortName;
		this.longName = longName;
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
	
	/**
	 * Returns: Short name.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getShortName() {
		return shortName;
	}
	
	/**
	 * Returns: Long name.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getLongName() {
		return longName;
	}
	
}
