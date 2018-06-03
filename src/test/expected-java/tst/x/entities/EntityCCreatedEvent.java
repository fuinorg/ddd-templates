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

import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

import org.fuin.ddd4j.ddd.AbstractDomainEvent;
import org.fuin.ddd4j.ddd.EntityIdPath;
import org.fuin.ddd4j.ddd.EventType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.vo.KeyValue;

/**
 * The entity C was created.
 */
@XmlRootElement(name = "entity-c-created-event")
public final class EntityCCreatedEvent extends AbstractDomainEvent<EntityCId> {

    private static final long serialVersionUID = 1000L;

    /** Unique name used to store the event. */
    public static final EventType EVENT_TYPE = new EventType(
            "EntityCCreatedEvent");

    @NotNull
    @XmlAttribute(name = "a")
    private String a;

    @NotNull
    @XmlAttribute(name = "b")
    private Integer b;

    /**
     * Protected default constructor for deserialization.
     */
    protected EntityCCreatedEvent() {
        super();
    }

    /**
     * The entity C was created.
     * 
     * @param entityIdPath
     *            Path from the aggregate root (first) to the entity that raised
     *            the event (last).
     * @param a
     *            String
     * @param b
     *            Integer
     */
    public EntityCCreatedEvent(@NotNull final EntityIdPath entityIdPath,
            @NotNull final String a, @NotNull final Integer b) {
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
     * Returns: String
     * 
     * @return Current value.
     */
    @NotNull
    public final String getA() {
        return a;
    }

    /**
     * Returns: Integer
     * 
     * @return Current value.
     */
    @NotNull
    public final Integer getB() {
        return b;
    }

    @Override
    public final String toString() {
        return KeyValue.replace("Entity C was created: ${a} / ${b} [${#entityIdPath}]",
                new KeyValue("#entityIdPath", getEntityIdPath()), new KeyValue(
                        "a", a), new KeyValue("b", b));
    }

}
