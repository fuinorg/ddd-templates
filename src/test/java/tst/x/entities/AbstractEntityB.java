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
package tst.x.entities;

import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AbstractEntity;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;

/**
 * Entity B - With variables.
 */
public abstract class AbstractEntityB extends AbstractEntity<AggregateXId, AggregateX, EntityBId> {

	@NotNull
	private EntityBId id;

	@NotNull
	private String a;
	
	@NotNull
	private Integer b;
	
	/**
	 * Constructor with mandatory data.
	 *
	 * @param rootAggregate The root aggregate of this entity.
	 * @param id Unique entity identifier.
	 */
	protected AbstractEntityB(@NotNull final AggregateX rootAggregate, @NotNull final EntityBId id) {
		super(rootAggregate);
		Contract.requireArgNotNull("id", id);
		
		this.id = id;
	}
	
	@Override
	public final EntityType getType() {
		return EntityBId.TYPE;
	}

	@Override
	public final EntityBId getId() {
		return id;
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
	
}
