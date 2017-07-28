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

import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.junit.Test;
import static org.fest.assertions.Assertions.*;
import static org.fuin.utils4j.JaxbUtils.marshal;
import static org.fuin.utils4j.JaxbUtils.unmarshal;
import static org.fuin.utils4j.Utils4J.deserialize;
import static org.fuin.utils4j.Utils4J.serialize;

// CHECKSTYLE:OFF
public final class EventDTest {

	@Test
	public final void testSerializeDeserialize() {

		// PREPARE
		final EventD original = createTestee();

		// TEST
		final EventD copy = deserialize(serialize(original));

		// VERIFY
		assertThat(original).isEqualTo(copy);

	}

	@Test
	public final void testMarshalUnmarshal() {

		// PREPARE
		final EventD original = createTestee();

		// TEST
		final String xml = marshal(original, createAdapter(), EventD.class);
		final EventD copy = unmarshal(xml, createAdapter(), EventD.class);

		// VERIFY
		assertThat(original).isEqualTo(copy);

	}

	private EventD createTestee() {
		return new EventD();
	}

	protected final XmlAdapter<?, ?>[] createAdapter() {
		return new XmlAdapter[] { };
	}

}
// CHECKSTYLE:ON
