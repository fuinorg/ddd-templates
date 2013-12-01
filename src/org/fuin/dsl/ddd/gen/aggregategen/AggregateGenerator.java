package org.fuin.dsl.ddd.gen.aggregategen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.aggregategen.AggregateAbstractSource;
import org.fuin.dsl.ddd.gen.aggregategen.AggregateManualSource;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;

public class AggregateGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof Aggregate) {
                generate((Aggregate) obj, fsa);
            }
        }

    }

    public void generate(final Aggregate aggregate, final IFileSystemAccess fsa) {

        final Namespace ns = (Namespace) aggregate.eContainer();

        final String abstractFilenname = (ns.getName() + ".Abstract" + aggregate
                .getName()).replace('.', '/') + ".java";
        fsa.generateFile(abstractFilenname,
                new AggregateAbstractSource().create(aggregate, ns));

        final String manualFilenname = (ns.getName() + '.' + aggregate
                .getName()).replace('.', '/') + ".java";
        fsa.generateFile(manualFilenname,
                new AggregateManualSource().create(aggregate, ns));

    }

}
