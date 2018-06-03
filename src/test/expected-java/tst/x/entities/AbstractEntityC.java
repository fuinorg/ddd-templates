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
package tst.x.entities;

import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AbstractEntity;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.objects4j.common.Contract;

/**
 * Entity C - With constructor, constraint and event.
 */
public abstract class AbstractEntityC extends AbstractEntity<AggregateXId, AggregateX, EntityCId> {

	@NotNull
	private EntityCId id;

	@NotNull
	private String a;
	
	@NotNull
	private Integer b;
	
	/**
	 * Creates the entity.
	 *
	 * @param rootAggregate The root aggregate of this entity.
	 * @param id Unique entity identifier.
	 * @param a Variable A.
	 * @param b Variable B.
	 *
	 * @throws AnyConstraintViolatedException The constraint was violated.
	 */
	public AbstractEntityC(@NotNull final AggregateX rootAggregate, @NotNull final EntityCId id, @NotNull final String a, @NotNull final Integer b) throws AnyConstraintViolatedException {
		super(rootAggregate);
		Contract.requireArgNotNull("id", id);
		Contract.requireArgNotNull("a", a);
		Contract.requireArgNotNull("b", b);
		
		this.id = id;
		this.a = a;
		this.b = b;
	}
	
	@Override
	public final EntityType getType() {
		return EntityCId.TYPE;
	}

	@Override
	public final EntityCId getId() {
		return id;
	}

	/**
	 * Returns: Variable A.
	 *
	 * @return Current value.
	 */
	 @NotNull
	protected final String getA() {
		return a;
	}
	
	/**
	 * Returns: Variable B.
	 *
	 * @return Current value.
	 */
	 @NotNull
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
	 * Handles: EntityCCreatedEvent.
	 *
	 * @param event Event to handle.
	 */
	protected abstract void handle(@NotNull final EntityCCreatedEvent event);
	
}
