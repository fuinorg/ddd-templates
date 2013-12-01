package org.fuin.dsl.ddd.gen.entitygen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.entitygen.EntityAbstractSource;
import org.fuin.dsl.ddd.gen.entitygen.EntityManualSource;

public class EntityGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof Entity) {
                generate((Entity) obj, fsa);
            }
        }

    }

    public void generate(final Entity entity, final IFileSystemAccess fsa) {

        final Namespace ns = (Namespace) entity.eContainer();

        final String abstractFilenname = (ns.getName() + ".Abstract" + entity
                .getName()).replace('.', '/') + ".java";
        fsa.generateFile(abstractFilenname,
                new EntityAbstractSource().create(entity, ns));

        final String manualFilenname = (ns.getName() + '.' + entity.getName())
                .replace('.', '/') + ".java";
        fsa.generateFile(manualFilenname,
                new EntityManualSource().create(entity, ns));

    }

}
