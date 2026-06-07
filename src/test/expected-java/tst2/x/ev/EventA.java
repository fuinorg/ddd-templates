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

import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.time.ZonedDateTime;
import org.fuin.ddd4j.core.EventId;
import org.fuin.ddd4j.core.EventType;
import org.fuin.ddd4j.jsonb.AbstractDomainEvent;
import org.fuin.objects4j.core.KeyValue;

/**
 * Aggregate event A.
 */
public final class EventA extends AbstractDomainEvent<CustomerId> {

    @Serial
    private static final long serialVersionUID = 1000L;

    /** Unique name used to store the event. */
    public static final EventType EVENT_TYPE = new EventType("EventA");
    

    @Override
    public EventType getEventType() {
        return EVENT_TYPE;
    }


    @Override
    public String toString() {
        return KeyValue.replace("Event A [${#entityIdPath}]",
            new KeyValue("#entityIdPath", getEntityIdPath())
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
    public static final class Builder extends AbstractDomainEvent.Builder<CustomerId, EventA, Builder> {
    
        private EventA delegate;
    
        private Builder() {
            super(new EventA());
            delegate = delegate();
        }
    
    
        /**
         * Creates the event and clears the builder.
         *
         * @return New instance.
         */
        public EventA build() {
            ensureBuildableAbstractDomainEvent();
            if (delegate.getEventId() == null) {
                this.eventId(new EventId());
            }
            if (delegate.getEventTimestamp() == null) {
                this.timestamp(ZonedDateTime.now());
            }
            
            
            final EventA result = delegate;
            delegate = new EventA();
            resetAbstractDomainEvent(delegate);
            return result;
        }
    
    }
}

