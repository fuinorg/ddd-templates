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
package tst2.x.aggregateid;

import javax.annotation.concurrent.ThreadSafe;
import javax.enterprise.context.ApplicationScoped;
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.SingleEntityIdFactory;
import org.fuin.objects4j.vo.AbstractValueObjectConverter;

/**
 * Converts MyAggregate3Id from/to String.
 */
@ThreadSafe
@ApplicationScoped
@Converter(autoApply = true)
public final class MyAggregate3IdConverter extends
		AbstractValueObjectConverter<String, MyAggregate3Id> implements
		AttributeConverter<MyAggregate3Id, String>, SingleEntityIdFactory {

	@Override
	public Class<String> getBaseTypeClass() {
		return String.class;
	}

	@Override
	public final Class<MyAggregate3Id> getValueObjectClass() {
		return MyAggregate3Id.class;
	}

	@Override
	public final boolean isValid(final String value) {
		return MyAggregate3Id.isValid(value);
	}

	@Override
	public final MyAggregate3Id toVO(final String value) {
		return MyAggregate3Id.valueOf(value);
	}

	@Override
	public final String fromVO(final MyAggregate3Id value) {
		if (value == null) {
			return null;
		}
		return value.asBaseType();
	}

	@Override
	public final AggregateRootId createEntityId(final String id) {
		return MyAggregate3Id.valueOf(id);
	}

}
