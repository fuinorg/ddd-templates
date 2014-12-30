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
package tst.x.aggregateid;

import org.fuin.objects4j.common.Immutable;

/**
 * Aggregate ID single attribute and without base.
 */
@Immutable
public final class MyAggregate2Id extends AbstractMyAggregate2Id {

	private static final long serialVersionUID = 1000L;
	
	@Override
	public final String asString() {
		return "" + getId();
	}

	
}
