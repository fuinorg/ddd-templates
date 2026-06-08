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
import org.fuin.ddd4j.core.ApplyEvent;
import org.fuin.objects4j.common.Contract;

/**
 * Entity C - With constructor, constraint and event.
 */
public final class EntityC extends AbstractEntityC {

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
    public EntityC(@NotNull final AggregateX rootAggregate, @NotNull final EntityCId id, @NotNull final String a, @NotNull final Integer b) throws AnyConstraintViolatedException {
        super(rootAggregate, id, a, b);
    }
    
    /**
     * Handles: EntityCCreatedEvent.
     *
     * @param event Event to handle.
     */
    @Override
    @ApplyEvent
    protected final void handle(@NotNull final EntityCCreatedEvent event) {
        // TODO Handle event!
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
    public static final class Builder extends AbstractEntity.Builder<AggregateXId, AggregateX, EntityCId, EntityC, Builder> {
    
        @NotNull
        private String a;
        
        @NotNull
        private Integer b;
        
        private Builder() {
            super();
        }
    
        /**
         * Sets: Variable A.
         *
         * @param a Value to set.
         * @return This builder.
         */
        public Builder a(@NotNull final String a) {
            Contract.requireArgNotNull("a", a);
            this.a = a;
            return this;
        }
    
        /**
         * Sets: Variable B.
         *
         * @param b Value to set.
         * @return This builder.
         */
        public Builder b(@NotNull final Integer b) {
            Contract.requireArgNotNull("b", b);
            this.b = b;
            return this;
        }
    
        /**
         * Creates the entity and clears the builder.
         *
         * @return New instance.
         */
        @Override
        public EntityC build() throws AnyConstraintViolatedException {
            ensureBuildableAbstractEntity();
            ensureNotNull("a", a);
            ensureNotNull("b", b);
    
            final EntityC result = new EntityC(getRootAggregate(), getEntityId(), a, b);
    
            resetAbstractEntity();
            this.a = null;
            this.b = null;
            return result;
        }
    
    }
}
