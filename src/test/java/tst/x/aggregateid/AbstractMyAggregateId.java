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
package tst.x.aggregateid;

import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.AbstractStringValueObject;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Aggregate ID single attribute and base.
 */
public abstract class AbstractMyAggregateId extends AbstractStringValueObject implements AggregateRootId, ValueObject {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	private String value;
	
	/**
	 * Default constructor.
	 */
	protected AbstractMyAggregateId() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param value Persistent value.
	 */
	public AbstractMyAggregateId(@NotNull final String value) {
		super();
		Contract.requireArgNotNull("value", value);
		
		this.value = value;
	}
	
	/**
	 * Returns: Persistent value.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getValue() {
		return value;
	}
	
	/** Name that identifies the entity uniquely within the context. */	
	public static final EntityType TYPE = new StringBasedEntityType("MyAggregate");
	
	@Override
	public final EntityType getType() {
		return TYPE;
	}
	
	@Override
	public final String asTypedString() {
		return TYPE + " " + asString();
	}
	
}
