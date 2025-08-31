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
import jakarta.xml.bind.annotation.XmlRootElement;
import org.fuin.ddd4j.core.EntityIdPath;
import org.fuin.ddd4j.core.EventType;
import org.fuin.ddd4j.jsonb.AbstractDomainEvent;
import org.fuin.objects4j.core.KeyValue;

/**
 * Aggregate event A.
 */
@XmlRootElement(name = "event-a")
public final class EventA extends AbstractDomainEvent<CustomerId> {

	private static final long serialVersionUID = 1000L;

	/** Unique name used to store the event. */
	public static final EventType EVENT_TYPE = new EventType("EventA");
	

	/**
	 * Protected default constructor for deserialization.
	 */
	protected EventA() {
		super();
	}
	
	/**
	 * Aggregate event A.
	 *
	 * @param entityIdPath Path from the aggregate root (first) to the entity that raised the event (last). 
	*/
	public EventA(@NotNull final EntityIdPath entityIdPath) {
		super(entityIdPath);
	}

	@Override
	public final EventType getEventType() {
		return EVENT_TYPE;
	}


	@Override
	public final String toString() {
		return KeyValue.replace("Event A [${#entityIdPath}]",
			new KeyValue("#entityIdPath", getEntityIdPath())
		);
	}
	
}
