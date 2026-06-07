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
package tst2.x.ev;

import jakarta.json.bind.annotation.JsonbProperty;
import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.time.ZonedDateTime;
import org.fuin.ddd4j.core.EventId;
import org.fuin.ddd4j.core.EventType;
import org.fuin.ddd4j.jsonb.AbstractDomainEvent;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.core.KeyValue;
import org.fuin.objects4j.ui.Examples;

/**
 * Aggregate event B.
 */
public final class EventB extends AbstractDomainEvent<CustomerId> {

    @Serial
    private static final long serialVersionUID = 1000L;

    /** Unique name used to store the event. */
    public static final EventType EVENT_TYPE = new EventType("EventB");
    
    @NotNull
    @JsonbProperty("a")
    @Examples(value = { "Abc" })
    private String a;
    

    @Override
    public EventType getEventType() {
        return EVENT_TYPE;
    }

    /**
     * Returns: A.
     *
     * @return Current value.
     */
    @NotNull
    public String getA() {
        return a;
    }
    

    @Override
    public String toString() {
        return KeyValue.replace("Event B: ${a} [${#entityIdPath}]",
            new KeyValue("#entityIdPath", getEntityIdPath())
            , new KeyValue("a", a)
        );
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
    public static final class Builder extends AbstractDomainEvent.Builder<CustomerId, EventB, Builder> {
    
        private EventB delegate;
    
        private Builder() {
            super(new EventB());
            delegate = delegate();
        }
    
        /**
         * Sets: A.
         *
         * @param a Value to set.
         * @return This builder.
         */
        public Builder a(@NotNull final String a) {
            Contract.requireArgNotNull("a", a);
            delegate.a = a;
            return this;
        }
        
    
        /**
         * Creates the event and clears the builder.
         *
         * @return New instance.
         */
        public EventB build() {
            ensureBuildableAbstractDomainEvent();
            if (delegate.getEventId() == null) {
                this.eventId(new EventId());
            }
            if (delegate.getEventTimestamp() == null) {
                this.timestamp(ZonedDateTime.now());
            }
            
        	ensureNotNull("a", delegate.a);
            
            final EventB result = delegate;
            delegate = new EventB();
            resetAbstractDomainEvent(delegate);
            return result;
        }
    
    }
}

