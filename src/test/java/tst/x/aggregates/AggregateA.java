package tst.x.aggregates;

import org.fuin.ddd4j.ddd.AbstractAggregateRoot;
import org.fuin.ddd4j.ddd.EntityType;

public class AggregateA extends AbstractAggregateRoot<AggregateAId> {

    @Override
    public AggregateAId getId() {
        return null;
    }

    @Override
    public EntityType getType() {
        return AggregateAId.TYPE;
    }

}
