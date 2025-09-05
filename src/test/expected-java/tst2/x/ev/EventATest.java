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

import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.json.bind.JsonbConfig;
import jakarta.xml.bind.annotation.adapters.XmlAdapter;
import org.eclipse.yasson.FieldAccessStrategy;
import org.fuin.ddd4j.core.EntityIdPath;
import org.fuin.ddd4j.jaxb.EntityIdPathXmlAdapter;
import org.fuin.ddd4j.jsonb.EventIdJsonbAdapter;
import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.*;
import static org.fuin.utils4j.Utils4J.deserialize;
import static org.fuin.utils4j.Utils4J.serialize;
import static org.fuin.utils4j.jaxb.JaxbUtils.marshal;
import static org.fuin.utils4j.jaxb.JaxbUtils.unmarshal;

// CHECKSTYLE:OFF
public final class EventATest {

    @Test
    public final void testSerializeDeserialize() {

        // PREPARE
        final EventA original = createTestee();

        // TEST
        final EventA copy = deserialize(serialize(original));

        // VERIFY
        assertThat(original).isEqualTo(copy);

    }

    @Test
    public final void testMarshalUnmarshalXml() {

        // PREPARE
        final EventA original = createTestee();

        // TEST
        final String xml = marshal(original, createAdapter(), EventA.class);
        final EventA copy = unmarshal(xml, createAdapter(), EventA.class);

        // VERIFY
        assertThat(original).isEqualTo(copy);

    }

    @Test
    public final void testMarshalUnmarshalJson() {

        // PREPARE
        final EventA original = createTestee();

        final JsonbConfig config = new JsonbConfig()
                .withAdapters(new EventIdJsonbAdapter())
                .withPropertyVisibilityStrategy(new FieldAccessStrategy());
        final Jsonb jsonb = JsonbBuilder.create(config);

        // TEST
        final String json = jsonb.toJson(original, EventA.class);
        final EventA copy = jsonb.fromJson(json, EventA.class);

        // VERIFY
        assertThat(original).isEqualTo(copy);

    }

    private EventA createTestee() {
        // TODO Set test values
        final CustomerId entityId = new CustomerId("42705de0-91a1-11e4-b4a9-0800200c9a6");
        return new EventA(new EntityIdPath(entityId));
    }

    protected final XmlAdapter<?, ?>[] createAdapter() {
        final EntityIdPathXmlAdapter EntityIdPathXmlAdapter = new EntityIdPathXmlAdapter(new XEntityIdFactory());
        return new XmlAdapter[] { EntityIdPathXmlAdapter };
    }

}
// CHECKSTYLE:ON
