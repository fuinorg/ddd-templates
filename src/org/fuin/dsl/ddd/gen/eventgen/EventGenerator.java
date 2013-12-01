package org.fuin.dsl.ddd.gen.eventgen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.eventgen.EventAbstractSource;
import org.fuin.dsl.ddd.gen.eventgen.EventManualSource;

public class EventGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof Event) {
                generate((Event) obj, fsa);
            }
        }

    }

    public void generate(final Event event, final IFileSystemAccess fsa) {

        final EObject method = event.eContainer();
        final EObject container = method.eContainer();

        if (container instanceof AbstractEntity) {

            final AbstractEntity entity = (AbstractEntity) container;
            final Namespace ns = (Namespace) entity.eContainer();

            final String abstractFilenname = (ns.getName() + ".Abstract" + event
                    .getName()).replace('.', '/') + ".java";
            fsa.generateFile(abstractFilenname,
                    new EventAbstractSource().create(event, ns));

            final String manualFilenname = (ns.getName() + '.' + event
                    .getName()).replace('.', '/') + ".java";
            fsa.generateFile(manualFilenname,
                    new EventManualSource().create(event, ns));

        }

    }

}
