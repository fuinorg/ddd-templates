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

/**
 * Entity A.
 */
public abstract class AbstractEntityA extends AbstractEntity<AggregateXId, AggregateX, EntityAId> {

	@NotNull
	private EntityAId id;

	/**
	 * Constructor with mandatory data.
	 *
	 * @param rootAggregate The root aggregate of this entity.
	 * @param id Unique entity identifier.
	 */
	protected AbstractEntityA(@NotNull final AggregateX rootAggregate, @NotNull final EntityAId id) {
		super(rootAggregate);
		Contract.requireArgNotNull("id", id);
		
		this.id = id;
	}
	
	@Override
	public final EntityType getType() {
		return EntityAId.TYPE;
	}

	@Override
	public final EntityAId getId() {
		return id;
	}

}
