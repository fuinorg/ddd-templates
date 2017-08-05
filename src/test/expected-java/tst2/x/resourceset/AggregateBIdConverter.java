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

import javax.enterprise.context.ApplicationScoped;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.SingleEntityIdFactory;
import org.fuin.objects4j.common.ThreadSafe;
import org.fuin.objects4j.vo.AbstractValueObjectConverter;

/**
 * Converts AggregateBId from/to String.
 */
@ThreadSafe
@ApplicationScoped
@Converter(autoApply = true)
public final class AggregateBIdConverter extends
		AbstractValueObjectConverter<String, AggregateBId> implements
		AttributeConverter<AggregateBId, String>, SingleEntityIdFactory {

	@Override
	public Class<String> getBaseTypeClass() {
		return String.class;
	}

	@Override
	public final Class<AggregateBId> getValueObjectClass() {
		return AggregateBId.class;
	}

	@Override
	public final boolean isValid(final String value) {
		return AggregateBId.isValid(value);
	}

	@Override
	public final AggregateBId toVO(final String value) {
		return AggregateBId.valueOf(value);
	}

	@Override
	public final String fromVO(final AggregateBId value) {
		if (value == null) {
			return null;
		}
		return value.asBaseType();
	}

	@Override
	public final AggregateRootId createEntityId(final String id) {
		return AggregateBId.valueOf(id);
	}

}
