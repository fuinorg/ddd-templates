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
package tst2.x.aggregates;

import org.fuin.ddd4j.ddd.EntityType;
import org.fuin.ddd4j.esrepo.EventStoreRepository;
import org.fuin.esc.api.EventStoreSync;

import tst.x.aggregates.AggregateC;
import tst.x.aggregates.AggregateCId;

/**
 * Repository that is capable of storing a {@link AggregateC}.
 */
public final class AggregateCRepository extends EventStoreRepository<AggregateCId, AggregateC> {

    /**
     * Constructor without credentials.
     * 
     * @param eventStore
     *            Event store.
     */
    public AggregateCRepository(final EventStoreSync eventStore) {
        super(eventStore);
    }

	@Override
	public Class<AggregateC> getAggregateClass() {
		return AggregateC.class;
	}

	@Override
	public final EntityType getAggregateType() {
		return AggregateCId.TYPE;
	}

	@Override
	public final AggregateC create() {
		return new AggregateC();
	}

	@Override
	protected final String getIdParamName() {
		return "aggregateCId";
	}

}
