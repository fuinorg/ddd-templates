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
package tst2.x.ev;

import java.util.UUID;

import javax.validation.constraints.NotNull;

import org.fuin.ddd4j.ddd.AbstractUUIDVO;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;

public final class CustomerId extends AbstractUUIDVO implements AggregateRootId {

    private static final long serialVersionUID = 1000L;

    /** Name that identifies the entity uniquely within the context. */
    public static final EntityType TYPE = new StringBasedEntityType(
            "CustomerId");

    /**
     * Default constructor.
     */
    protected CustomerId() {
        super();
    }

    /**
     * Constructor with all data.
     * 
     * @param value
     *            Persistent value.
     */
    public CustomerId(@NotNull final UUID value) {
        super(value);
    }

    @Override
    public final EntityType getType() {
        return TYPE;
    }

    @Override
    public final String asTypedString() {
        return TYPE + " " + asString();
    }

}
