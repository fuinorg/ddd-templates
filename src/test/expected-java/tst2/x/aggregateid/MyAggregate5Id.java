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

import java.util.UUID;
import javax.json.bind.adapter.JsonbAdapter;
import javax.persistence.AttributeConverter;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import org.fuin.ddd4j.ddd.AggregateRootUuid;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;
import org.fuin.objects4j.common.Immutable;
import org.fuin.objects4j.vo.ValueObjectConverter;

/**
 * Aggregate ID no attribute and with UUID base.
 */
@Immutable
public final class MyAggregate5Id extends AggregateRootUuid {

	private static final long serialVersionUID = 1000L;

	/** Unique name of the aggregate this identifier refers to. */
	public static final EntityType TYPE = new StringBasedEntityType(
			"MyAggregate5");

	/**
	 * Default constructor.
	 */
	protected MyAggregate5Id() {
		super(TYPE);
	}

	/**
	 * Constructor with all data.
	 *
	 * @param value
	 *            Persistent value.
	 */
	public MyAggregate5Id(@NotNull final UUID value) {
		super(TYPE, value);
	}

	/**
	 * Parses a given string and returns a new instance of MyAggregate5Id.
	 * 
	 * @param value
	 *            String with valid UUID to convert. A <code>null</code> value
	 *            returns <code>null</code>.
	 * 
	 * @return Converted value.
	 */
	public static MyAggregate5Id valueOf(final String value) {
		if (value == null) {
			return null;
		}
		requireArgValid("value", value);
		return new MyAggregate5Id(UUID.fromString(value));
	}

	/**
	 * Converts the value object from/to UUID.
	 */
	public static final class Converter extends XmlAdapter<UUID, MyAggregate5Id>
			implements ValueObjectConverter<UUID, MyAggregate5Id>
			, AttributeConverter<MyAggregate5Id, UUID>
			, JsonbAdapter<MyAggregate5Id, UUID> {

		// Attribute Converter

		@Override
		public final Class<UUID> getBaseTypeClass() {
			return UUID.class;
		}

		@Override
		public final Class<MyAggregate5Id> getValueObjectClass() {
			return MyAggregate5Id.class;
		}

		@Override
		public boolean isValid(final UUID value) {
			return true;
		}

		@Override
		public final MyAggregate5Id toVO(final UUID value) {
			if (value == null) {
				return null;
			}
			return new MyAggregate5Id(value);
		}

		@Override
		public final UUID fromVO(final MyAggregate5Id value) {
			if (value == null) {
				return null;
			}
			return value.asBaseType();
		}

		// JAXB XML Adapter

		@Override
		public final MyAggregate5Id unmarshal(final UUID value)
				throws Exception {
			return toVO(value);
		}

		@Override
		public final UUID marshal(final MyAggregate5Id obj)
				throws Exception {
			return fromVO(obj);
		}

		// JPA Attribute Converter

		@Override
		public final UUID convertToDatabaseColumn(
				final MyAggregate5Id obj) {
			return fromVO(obj);
		}

		@Override
		public final MyAggregate5Id convertToEntityAttribute(
				final UUID value) {
			return toVO(value);
		}

		// JSONB Adapter

		@Override
		public final UUID adaptToJson(final MyAggregate5Id obj)
				throws Exception {
			return fromVO(obj);
		}

		@Override
		public final MyAggregate5Id adaptFromJson(
				final UUID value) throws Exception {
			return toVO(value);
		}

	}

}
