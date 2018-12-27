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

import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.fuin.ddd4j.ddd.EntityIdPath;
import org.fuin.ddd4j.ddd.EntityIdPathConverter;
import org.fuin.ddd4j.ddd.EventIdConverter;
import org.junit.Test;
import static org.assertj.core.api.Assertions.*;
import static org.fuin.utils4j.JaxbUtils.marshal;
import static org.fuin.utils4j.JaxbUtils.unmarshal;
import static org.fuin.utils4j.Utils4J.deserialize;
import static org.fuin.utils4j.Utils4J.serialize;

// CHECKSTYLE:OFF
public final class EventBTest {

	@Test
	public final void testSerializeDeserialize() {

		// PREPARE
		final EventB original = createTestee();

		// TEST
		final EventB copy = deserialize(serialize(original));

		// VERIFY
		assertThat(original).isEqualTo(copy);
		assertThat(original.getA()).isEqualTo(copy.getA());

	}

	@Test
	public final void testMarshalUnmarshalXml() {

		// PREPARE
		final EventB original = createTestee();

		// TEST
		final String xml = marshal(original, createAdapter(), EventB.class);
		final EventB copy = unmarshal(xml, createAdapter(), EventB.class);

		// VERIFY
		assertThat(original).isEqualTo(copy);
		assertThat(original.getA()).isEqualTo(copy.getA());

	}

	@Test
	public final void testMarshalUnmarshalJson() {

		// PREPARE
		final EventB original = createTestee();

		final JsonbConfig config = new JsonbConfig()
				.withAdapters(new EventIdConverter(), new ZonedDateTimeJsonbAdapter())
				.withPropertyVisibilityStrategy(new FieldAccessStrategy());
		final Jsonb jsonb = JsonbBuilder.create(config);

		// TEST
		final String json = jsonb.toJson(original, EventB.class);
		final EventB copy = jsonb.fromJson(json, EventB.class);

		// VERIFY
		assertThat(original).isEqualTo(copy);
		assertThat(original.getA()).isEqualTo(copy.getA());

	}

	private EventB createTestee() {
		// TODO Set test values
		final CustomerId entityId = new CustomerId("42705de0-91a1-11e4-b4a9-0800200c9a6");
		final String a = "Abc";
		return new EventB(new EntityIdPath(entityId), a);
	}

	protected final XmlAdapter<?, ?>[] createAdapter() {
		final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new XEntityIdFactory());
		return new XmlAdapter[] { entityIdPathConverter };
	}

}
// CHECKSTYLE:ON
