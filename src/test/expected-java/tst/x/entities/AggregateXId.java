package tst.x.entities;

import jakarta.validation.constraints.NotNull;

import org.fuin.ddd4j.core.AggregateRootId;
import org.fuin.ddd4j.core.EntityType;
import org.fuin.ddd4j.core.StringBasedEntityType;
import org.fuin.objects4j.common.Contract;
import org.fuin.objects4j.common.ValueObject;
import org.fuin.objects4j.core.AbstractStringValueObject;

public final class AggregateXId extends AbstractStringValueObject implements
        AggregateRootId, ValueObject {

    private static final long serialVersionUID = 1000L;

    public static final EntityType TYPE = new StringBasedEntityType(
            "AggregateX");

    private String value;

    protected AggregateXId() {
        super();
    }

    public AggregateXId(@NotNull final String value) {
        super();
        Contract.requireArgNotNull("value", value);

        this.value = value;
    }

    public final String getValue() {
        return value;
    }

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
        return getValue();
    }

}
