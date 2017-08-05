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
package tst.x.valueobject;

import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Immutable;
import org.fuin.objects4j.ui.Label;
import org.fuin.objects4j.ui.ShortLabel;
import org.fuin.objects4j.ui.Tooltip;

/**
 * A person's full nomenclature, also known as a personal name.
 */
@Immutable
@ShortLabel(bundle = "x", key = "valueobject.FullName.slabel", value = "Name")
@Label(bundle = "x", key = "valueobject.FullName.label", value = "Full name")
@Tooltip(bundle = "x", key = "valueobject.FullName.tooltip", value = "A person's full nomenclature, also known as a personal name")
public final class FullName extends AbstractFullName {

	private static final long serialVersionUID = 1000L;
	
	/**
	 * Default constructor.
	 */
	protected FullName() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param firstName First name.
	 * @param lastName Last name.
	 */
	public FullName(@NotNull final String firstName, @NotNull final String lastName) {
		super(firstName, lastName);
	}
	
}
