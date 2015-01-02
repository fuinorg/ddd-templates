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
package tst.x.valueobject;

import java.io.Serializable;
import javax.validation.constraints.NotNull;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Value object single attribute and without base.
 */
public abstract class AbstractMyValueObject2 implements ValueObject, Serializable {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	private String id;
	
	
	/**
	 * Default constructor.
	 */
	protected AbstractMyValueObject2() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param id Persistent value.
	 */
	public AbstractMyValueObject2(@NotNull final String id) {
		super();
		Contract.requireArgNotNull("id", id);
		
		this.id = id;
	}
	

	/**
	 * Returns: Persistent value.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getId() {
		return id;
	}
	

}
