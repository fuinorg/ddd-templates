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

import org.fuin.ddd4j.core.EventType;
import org.fuin.ddd4j.jsonb.AbstractEvent;

/**
 * Event D - Independent of an aggregate.
 */
public final class EventD extends AbstractEvent {

    private static final long serialVersionUID = 1000L;

    /** Unique name used to store the event. */
    public static final EventType EVENT_TYPE = new EventType("EventD");
    

    /**
     * Event D - Independent of an aggregate.
     *
    */
    public EventD() {
        super();
    }

    @Override
    public EventType getEventType() {
        return EVENT_TYPE;
    }


    @Override
    public String toString() {
        return "Something interesting happened!";
    }
    
}
