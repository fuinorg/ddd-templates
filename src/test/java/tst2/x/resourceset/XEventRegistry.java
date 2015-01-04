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
package tst2.x.resourceset;

import java.nio.charset.Charset;
import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.fuin.ddd4j.ddd.BasicEventMetaData;
import org.fuin.ddd4j.ddd.Deserializer;
import org.fuin.ddd4j.ddd.EntityIdFactory;
import org.fuin.ddd4j.ddd.EntityIdPathConverter;
import org.fuin.ddd4j.ddd.Serializer;
import org.fuin.ddd4j.ddd.SerializerDeserializerRegistry;
import org.fuin.ddd4j.ddd.SimpleSerializerDeserializerRegistry;
import org.fuin.ddd4j.ddd.XmlDeSerializer;
import tst2.x.ev.EventA;
import tst2.x.ev.EventB;
import tst2.x.ev.EventC;
import tst2.x.ev.EventD;

/**
 * Contains a list of all events defined by this package.
 */
@ApplicationScoped
public class XEventRegistry implements SerializerDeserializerRegistry {

	private SimpleSerializerDeserializerRegistry registry;
	
	@Inject
	private EntityIdFactory entityIdFactory;

	@PostConstruct
	protected void init() {
		
		final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(entityIdFactory);
		final XmlAdapter<?, ?>[] adapters = new XmlAdapter<?, ?>[] { entityIdPathConverter };
		
		registry = new SimpleSerializerDeserializerRegistry();
		registry.add(new XmlDeSerializer("BasicEventMetaData", BasicEventMetaData.class));
		registry.add(new XmlDeSerializer(EventA.EVENT_TYPE.asBaseType(), adapters, EventA.class));
		registry.add(new XmlDeSerializer(EventB.EVENT_TYPE.asBaseType(), adapters, EventB.class));
		registry.add(new XmlDeSerializer(EventC.EVENT_TYPE.asBaseType(), adapters, EventC.class));
		registry.add(new XmlDeSerializer(EventD.EVENT_TYPE.asBaseType(), adapters, EventD.class));
	}

	@Override
	public Serializer getSerializer(final String type) {
		return registry.getSerializer(type);
	}

	@Override
	public Deserializer getDeserializer(final String type, final int version, final String mimeType, final Charset encoding) {
		return registry.getDeserializer(type, version, mimeType, encoding);
	}

}

