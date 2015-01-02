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
package tst2.x.valueobject;

import java.io.Serializable;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.NeverNull;
import org.fuin.objects4j.vo.ValueObject;

/**
 * Value object multiple attribute and without base.
 */
@XmlRootElement(name = "my-value-object4")
public final class MyValueObject4 implements ValueObject, Serializable {

	private static final long serialVersionUID = 1000L;
	
	@NotNull
	@XmlAttribute(name = "a")
	private String a;
	
	@NotNull
	@XmlAttribute(name = "b")
	private String b;
	

	/**
	 * Default constructor.
	 */
	protected MyValueObject4() {
		super();
	}
	
	/**
	 * Constructor with all data.
	 *
	 * @param a Persistent value A.
	 * @param b Persistent value B.
	 */
	public MyValueObject4(@NotNull final String a, @NotNull final String b) {
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
	
	
	
}
