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

import java.util.HashMap;
import java.util.Map;
import javax.enterprise.context.ApplicationScoped;
import org.fuin.ddd4j.ddd.EntityId;
import org.fuin.ddd4j.ddd.EntityIdFactory;
import org.fuin.ddd4j.ddd.SingleEntityIdFactory;

/**
 * Creates entity identifier instanced based on the type.
 */
@ApplicationScoped
public final class XEntityIdFactory implements EntityIdFactory {

	private Map<String, SingleEntityIdFactory> map;
	
	/**
	 * Default constructor.
	 */
	public XEntityIdFactory() {
		super();
		map = new HashMap<String, SingleEntityIdFactory>();
		map.put(AggregateAId.TYPE.asString(), new AggregateAIdConverter());
		map.put(AggregateBId.TYPE.asString(), new AggregateBIdConverter());
		map.put(EntityAId.TYPE.asString(), new EntityAIdConverter());
		map.put(EntityBId.TYPE.asString(), new EntityBIdConverter());
	}
	
	@Override
	public EntityId createEntityId(final String type, final String id) {
		final SingleEntityIdFactory factory = map.get(type);
		if (factory == null) {
			throw new IllegalArgumentException("Unknown type: " + type);
		}
		return factory.createEntityId(id);
	}
	
	@Override
	public boolean containsType(final String type) {
		return map.containsKey(type);
	}

}
