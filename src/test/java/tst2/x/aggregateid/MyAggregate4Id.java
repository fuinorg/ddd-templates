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
package tst2.x.aggregateid;

import javax.validation.constraints.NotNull;
import org.fuin.ddd4j.ddd.AggregateRootId;
import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.ddd.StringBasedEntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.Immutable;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Aggregate ID multiple attribute and without base.
 */
@Immutable
public final class MyAggregate4Id implements AggregateRootId, ValueObject {

	private static final long serialVersionUID = 1000L;

	@NotNull
	private String a;
	
	@NotNull
	private String b;
	

	/**
	 * Default constructor.
	 *
	 *
	 */
	protected MyAggregate4Id() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param a Persistent value A.
	 * @param b Persistent value B.
	 *
	 */
	public MyAggregate4Id(@NotNull final String a, @NotNull final String b) {
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
	 @NeverNull
	public final String getA() {
		return a;
	}
	
	/**
	 * Returns: Persistent value B.
	 *
	 * @return Current value.
	 */
	 @NeverNull
	public final String getB() {
		return b;
	}
	

	/** Name that identifies the entity uniquely within the context. */	
	public static final EntityType TYPE = new StringBasedEntityType("MyAggregate4");
	
	@Override
	public final EntityType getType() {
		return TYPE;
	}
	
	@Override
	public final String asTypedString() {
		return TYPE + " " + asString();
	}

	@Override
	public final String asString() {
		// TODO Implement!
		return null;
	}
	

}
