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
package tst2.x.resourceset;

import java.nio.charset.Charset;
import javax.annotation.PostConstruct;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.fuin.ddd4j.ddd.EntityIdFactory;
import org.fuin.ddd4j.ddd.EntityIdPathConverter;
import org.fuin.esc.spi.Deserializer;
import org.fuin.esc.spi.EnhancedMimeType;
import org.fuin.esc.spi.EscEvents;
import org.fuin.esc.spi.EscMeta;
import org.fuin.esc.spi.SerDeserializerRegistry;
import org.fuin.esc.spi.SerializedDataType;
import org.fuin.esc.spi.Serializer;
import org.fuin.esc.spi.SimpleSerializerDeserializerRegistry;
import org.fuin.esc.spi.XmlDeSerializer;
import tst2.x.ev.EventA;
import tst2.x.ev.EventB;
import tst2.x.ev.EventC;
import tst2.x.ev.EventD;
import tst2.x.ev.EventE;

/**
 * Contains a list of all events defined by this package.
 */
@ApplicationScoped
public class XEventRegistry implements SerDeserializerRegistry {

    private static final String CONTENT_TYPE = "application/xml";

    private static final Charset UTF8 = Charset.forName("utf-8");

	private SimpleSerializerDeserializerRegistry registry;
	
	@Inject
	private EntityIdFactory entityIdFactory;

	@PostConstruct
	protected void init() {
		
		final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(entityIdFactory);
		final XmlAdapter<?, ?>[] adapters = new XmlAdapter<?, ?>[] { entityIdPathConverter };
		final XmlDeSerializer xmlDeSer = new XmlDeSerializer(UTF8, adapters, false, EscEvents.class, EscMeta.class, EventA.class, EventB.class, EventC.class, EventD.class, EventE.class);
		
		registry = new SimpleSerializerDeserializerRegistry();
        // Base types always needed
        registry.add(EscEvents.SER_TYPE, CONTENT_TYPE, xmlDeSer);
        registry.add(EscMeta.SER_TYPE, CONTENT_TYPE, xmlDeSer);
        // User types
		registry.add(new SerializedDataType(EventA.EVENT_TYPE.asBaseType()), CONTENT_TYPE, xmlDeSer);
		registry.add(new SerializedDataType(EventB.EVENT_TYPE.asBaseType()), CONTENT_TYPE, xmlDeSer);
		registry.add(new SerializedDataType(EventC.EVENT_TYPE.asBaseType()), CONTENT_TYPE, xmlDeSer);
		registry.add(new SerializedDataType(EventD.EVENT_TYPE.asBaseType()), CONTENT_TYPE, xmlDeSer);
		registry.add(new SerializedDataType(EventE.EVENT_TYPE.asBaseType()), CONTENT_TYPE, xmlDeSer);
	}

	@Override
	public Serializer getSerializer(final SerializedDataType type) {
		return registry.getSerializer(type);
	}

	@Override
	public Deserializer getDeserializer(final SerializedDataType type, final EnhancedMimeType mimeType) {
		return registry.getDeserializer(type, mimeType);
	}

    @Override
    public Deserializer getDeserializer(final SerializedDataType type) {
        return registry.getDeserializer(type);
    }

    @Override
    public EnhancedMimeType getDefaultContentType(final SerializedDataType type) {
        return registry.getDefaultContentType(type);
    }

    @Override
    public boolean serializerExists(final SerializedDataType type) {
    	return registry.serializerExists(type);
    }

    @Override
    public boolean deserializerExists(final SerializedDataType type) {
    	return registry.deserializerExists(type);
    }

    @Override
    public boolean deserializerExists(final SerializedDataType type, final EnhancedMimeType mimeType) {
    	return registry.deserializerExists(type, mimeType);
    }

}

