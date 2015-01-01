package tst2.x.ev;

import java.util.UUID;

import org.fuin.ddd4j.ddd.EntityId;
import org.fuin.ddd4j.ddd.EntityIdFactory;

public class XEntityIdFactory implements EntityIdFactory {

    @Override
    public boolean containsType(String type) {
        if (type.equals(CustomerId.TYPE.asString())) {
            return true;
        }
        return false;
    }

    @Override
    public EntityId createEntityId(String type, String id) {
        if (type.equals(CustomerId.TYPE.asString())) {
            return new CustomerId(UUID.fromString(id));
        }
        throw new IllegalArgumentException("Unknown type: " + type);
    }

}
