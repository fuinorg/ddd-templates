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

import javax.json.bind.annotation.JsonbProperty;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import org.fuin.ddd4j.ddd.AbstractEvent;
import org.fuin.ddd4j.ddd.EventType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.vo.KeyValue;
import x.ev.MyString;

/**
 * Event E - Independent of an aggregate with value object reference.
 */
@XmlRootElement(name = "event-e")
public final class EventE extends AbstractEvent {

	private static final long serialVersionUID = 1000L;

	/** Unique name used to store the event. */
	public static final EventType EVENT_TYPE = new EventType("EventE");
	
	@NotNull
	@XmlAttribute(name = "a")
	@JsonbProperty("a")
	private MyString a;
	
	@NotNull
	@XmlAttribute(name = "b")
	@JsonbProperty("b")
	private MyString b;
	

	/**
	 * Protected default constructor for deserialization.
	 */
	protected EventE() {
		super();
	}
	
	/**
	 * Event E - Independent of an aggregate with value object reference.
	 *
	* @param a Field A 
	* @param b Field B 
	*/
	public EventE(@NotNull final MyString a, @NotNull final MyString b) {
		super();
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
	 * Returns: Field A
	 *
	 * @return Current value.
	 */
	@NotNull
	public final MyString getA() {
		return a;
	}
	
	/**
	 * Returns: Field B
	 *
	 * @return Current value.
	 */
	@NotNull
	public final MyString getB() {
		return b;
	}
	

	@Override
	public final String toString() {
		return KeyValue.replace("Something interesting happened!"
		, new KeyValue("a", a)
		, new KeyValue("b", b)
		);
	}
	
}
