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
package tst2.x.aggregateid;

import javax.annotation.concurrent.Immutable;
import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Aggregate ID single attribute and without base.
 */
@Immutable
public final class MyAggregate2Id implements AggregateRootId, ValueObject {

private static final long serialVersionUID = 1000L;

	@NotNull
	private String id;
	
	/**
	 * Default constructor.
	 */
	protected MyAggregate2Id() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param id Persistent value.
	 */
	public MyAggregate2Id(@NotNull final String id) {
		super();
		Contract.requireArgNotNull("id", id);
		
		this.id = id;
	}
	
	/**
	 * Returns: Persistent value.
	 *
	 * @return Current value.
	 */
	@NotNull
	public final String getId() {
		return id;
	}
	
	/** Name that identifies the entity uniquely within the context. */	
	public static final EntityType TYPE = new StringBasedEntityType("MyAggregate2");
	
	@Override
	public final EntityType getType() {
		return TYPE;
	}
	
	@Override
	public final String asTypedString() {
		return TYPE + " " + asString();
	}
	
	@Override
	public final String asString() {
		return "" + getId();
	}

}
