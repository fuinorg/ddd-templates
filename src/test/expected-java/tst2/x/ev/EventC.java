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

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import org.fuin.ddd4j.ddd.AbstractDomainEvent;
import org.fuin.ddd4j.ddd.EntityIdPath;
import org.fuin.ddd4j.ddd.EventType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.KeyValue;

/**
 * Aggregate event C.
 */
@XmlRootElement(name = "event-c")
public final class EventC extends AbstractDomainEvent<CustomerId> {

	private static final long serialVersionUID = 1000L;

	/** Unique name used to store the event. */
	public static final EventType EVENT_TYPE = new EventType("EventC");
	
	@NotNull
	@XmlAttribute(name = "a")
	private String a;
	
	@NotNull
	@XmlAttribute(name = "b")
	private Integer b;
	

	/**
	 * Protected default constructor for deserialization.
	 */
	protected EventC() {
		super();
	}
	
	/**
	 * Aggregate event C.
	 *
	 * @param entityIdPath Path from the aggregate root (first) to the entity that raised the event (last). 
	* @param a A. 
	* @param b B. 
	*/
	public EventC(@NotNull final EntityIdPath entityIdPath, @NotNull final String a, @NotNull final Integer b) {
		super(entityIdPath);
		Contract.requireArgNotNull("a", a);
		Contract.requireArgNotNull("b", b);
		
		this.a = a;
		this.b = b;
	}

	@Override
	public final EventType getEventType() {
		return EVENT_TYPE;
	}

	/**
	 * Returns: A.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getA() {
		return a;
	}
	
	/**
	 * Returns: B.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final Integer getB() {
		return b;
	}
	

	@Override
	public final String toString() {
		return KeyValue.replace("Event C: ${a} / ${b} [${#entityIdPath}]",
			new KeyValue("#entityIdPath", getEntityIdPath())
			, new KeyValue("a", a)
			, new KeyValue("b", b)
		);
	}
	
}
