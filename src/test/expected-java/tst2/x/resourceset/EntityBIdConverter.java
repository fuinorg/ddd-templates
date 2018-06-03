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

import javax.annotation.concurrent.ThreadSafe;
import javax.enterprise.context.ApplicationScoped;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import org.fuin.ddd4j.ddd.EntityId;
import org.fuin.ddd4j.ddd.SingleEntityIdFactory;
import org.fuin.objects4j.vo.AbstractValueObjectConverter;

/**
 * Converts EntityBId from/to String.
 */
@ThreadSafe
@ApplicationScoped
@Converter(autoApply = true)
public final class EntityBIdConverter extends
		AbstractValueObjectConverter<String, EntityBId> implements
		AttributeConverter<EntityBId, String>, SingleEntityIdFactory {

	@Override
	public Class<String> getBaseTypeClass() {
		return String.class;
	}

	@Override
	public final Class<EntityBId> getValueObjectClass() {
		return EntityBId.class;
	}

	@Override
	public final boolean isValid(final String value) {
		return EntityBId.isValid(value);
	}

	@Override
	public final EntityBId toVO(final String value) {
		return EntityBId.valueOf(value);
	}

	@Override
	public final String fromVO(final EntityBId value) {
		if (value == null) {
			return null;
		}
		return value.asBaseType();
	}

	@Override
	public final EntityId createEntityId(final String id) {
		return EntityBId.valueOf(id);
	}

}
