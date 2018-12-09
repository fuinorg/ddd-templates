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

import javax.annotation.concurrent.Immutable;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import org.fuin.ddd4j.ddd.EntityId;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.vo.AbstractStringValueObject;
import org.fuin.objects4j.vo.ValueObject;

@Immutable
@XmlJavaTypeAdapter(EntityBIdConverter.class)
public final class EntityBId extends AbstractStringValueObject implements EntityId, ValueObject {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	private String a;
	
	@NotNull
	private String b;
	
	/**
	 * Default constructor.
	 */
	protected EntityBId() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param a Persistent value A.
	 * @param b Persistent value B.
	 */
	public EntityBId(@NotNull final String a, @NotNull final String b) {
		super();
		Contract.requireArgNotNull("a", a);
		Contract.requireArgNotNull("b", b);
		
		this.a = a;
		this.b = b;
	}
	
	/**
	 * Returns: Persistent value A.
	 *
	 * @return Current value.
	 */
	@NotNull
	public final String getA() {
		return a;
	}
	
	/**
	 * Returns: Persistent value B.
	 *
	 * @return Current value.
	 */
	@NotNull
	public final String getB() {
		return b;
	}
	
	/** Name that identifies the entity uniquely within the context. */	
	public static final EntityType TYPE = new StringBasedEntityType("EntityB");
	
	@Override
	public final EntityType getType() {
		return TYPE;
	}
	
	@Override
	public final String asTypedString() {
		return TYPE + " " + asString();
	}
	
	@Override
	public final String asBaseType() {
		// TODO Implement!
		return null;
	}
	
	/**
	 * Returns the information if a given string can be converted into
	 * an instance of EntityBId. A <code>null</code> value returns <code>true</code>.
	 * 
	 * @param value
	 *            Value to check.
	 * 
	 * @return TRUE if it's a valid string, else FALSE.
	 */
	public static boolean isValid(final String value) {
		if (value == null) {
			return true;
		}
		// TODO Verify the value is valid!
		return true;
	}
	
	/**
	 * Parses a given string and returns a new instance of EntityBId.
	 * 
	 * @param value
	 *            Value to convert. A <code>null</code> value returns
	 *            <code>null</code>.
	 * 
	 * @return Converted value.
	 */
	public static EntityBId valueOf(final String value) {
		if (value == null) {
			return null;
		}
		// TODO Parse string value and return new instance! 
		// return new EntityBId(value);
		return null;
	}
	
}
