package tst.x.entities;

import org.fuin.ddd4j.core.AbstractAggregateRoot;
import org.fuin.ddd4j.core.EntityType;

public class AggregateX extends AbstractAggregateRoot<AggregateXId> {

    @Override
    public AggregateXId getId() {
        return null;
    }

    @Override
    public EntityType getType() {
        return AggregateXId.TYPE;
    }

}
