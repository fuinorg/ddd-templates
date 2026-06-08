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

import jakarta.validation.constraints.NotNull;
import org.fuin.ddd4j.core.AbstractEntity;

/**
 * Entity A - No variables.
 */
public final class EntityA extends AbstractEntityA {

    /**
     * Constructor with mandatory data.
     *
     * @param rootAggregate The root aggregate of this entity.
     * @param id Unique entity identifier.
     */
    public EntityA(@NotNull final AggregateX rootAggregate, @NotNull final EntityAId id) {
        super(rootAggregate, id);
    }
    

    /**
     * Creates a new builder instance.
     *
     * @return New builder instance.
     */
    public static Builder builder() {
        return new Builder();
    }

    /**
     * Builds an instance of the outer class.
     */
    public static final class Builder extends AbstractEntity.Builder<AggregateXId, AggregateX, EntityAId, EntityA, Builder> {
    
        private Builder() {
            super();
        }
    
        /**
         * Creates the entity and clears the builder.
         *
         * @return New instance.
         */
        @Override
        public EntityA build() {
            ensureBuildableAbstractEntity();
    
            final EntityA result = new EntityA(getRootAggregate(), getEntityId());
    
            resetAbstractEntity();
            return result;
        }
    
    }
}
