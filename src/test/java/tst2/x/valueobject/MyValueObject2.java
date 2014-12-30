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
package tst2.x.valueobject;

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Value object single attribute and without base.
 */
@XmlRootElement(name = "my-value-object2")
public final class MyValueObject2 implements ValueObject {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	@XmlElement(name = "id")
	private String id;
	

	/**
	 * Default constructor.
	 *
	 *
	 */
	protected MyValueObject2() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param id Persistent value.
	 *
	 */
	public MyValueObject2(@NotNull final String id) {
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
