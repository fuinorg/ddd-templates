package org.fuin.dsl.ddd.gen.enumgen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EnumObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.enumgen.EnumAbstractSource;

public class EnumGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof EnumObject) {
                generate((EnumObject) obj, fsa);
            }
        }

    }

    private void generate(EnumObject en, IFileSystemAccess fsa) {
        final Namespace ns = (Namespace) en.eContainer();
        final String voFilename = (ns.getName() + "." + en.getName()).replace(
                '.', '/') + ".java";
        fsa.generateFile(voFilename, new EnumAbstractSource().create(en, ns));
    }
}
