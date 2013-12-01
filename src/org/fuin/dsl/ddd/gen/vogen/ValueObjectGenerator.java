package org.fuin.dsl.ddd.gen.vogen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.vogen.ValueObjectAbstractSource;
import org.fuin.dsl.ddd.gen.vogen.ValueObjectManualSource;

public class ValueObjectGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof ValueObject) {
                generate((ValueObject) obj, fsa);
            }
        }

    }

    private void generate(ValueObject vo, IFileSystemAccess fsa) {

        final Namespace ns = (Namespace) vo.eContainer();

        // Abstract class
        final String abstractVoFilename = (ns.getName() + ".Abstract" + vo
                .getName()).replace('.', '/') + ".java";
        fsa.generateFile(abstractVoFilename,
                new ValueObjectAbstractSource().create(vo, ns));

        // One time generated class
        final String manualVoFilename = (ns.getName() + "." + vo.getName())
                .replace('.', '/') + ".java";
        fsa.generateFile(manualVoFilename,
                new ValueObjectManualSource().create(vo, ns));

    }

}
