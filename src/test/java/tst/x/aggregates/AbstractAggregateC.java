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
package tst.x.aggregates;

import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AbstractAggregateRoot;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;

/**
 * Aggregate C - With constructor, constraint and event.
 */
public abstract class AbstractAggregateC extends AbstractAggregateRoot<AggregateCId> {

	@NotNull
	private AggregateCId id;

	@NotNull
	private String a;
	
	@NotNull
	private Integer b;
	
	@Override
	public final EntityType getType() {
		return AggregateCId.TYPE;
	}

	@Override
	public final AggregateCId getId() {
		return id;
	}

	/**
	 * Sets the aggregate identifier.
	 * 
	 * @param id Unique aggregate identifier.
	 */
	protected final void setId(@NotNull final AggregateCId id) {
		Contract.requireArgNotNull("id", id);
		this.id = id;
	}
	
	/**
	 * Returns: Variable A.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	protected final String getA() {
		return a;
	}
	
	/**
	 * Returns: Variable B.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	protected final Integer getB() {
		return b;
	}
	
	/**
	 * Sets: Variable A.
	 *
	 * @param a Value to set.
	 */
	protected final void setA(@NotNull final String a) {
		Contract.requireArgNotNull("a", a);
		this.a = a;
	}
	
	/**
	 * Sets: Variable B.
	 *
	 * @param b Value to set.
	 */
	protected final void setB(@NotNull final Integer b) {
		Contract.requireArgNotNull("b", b);
		this.b = b;
	}
	
	/**
	 * Handles: AggregateCCreatedEvent.
	 *
	 * @param event Event to handle.
	 */
	protected abstract void handle(@NotNull final AggregateCCreatedEvent event);
	
}
