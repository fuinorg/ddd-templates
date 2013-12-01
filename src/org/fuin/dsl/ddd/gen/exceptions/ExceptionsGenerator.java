package org.fuin.dsl.ddd.gen.exceptions;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.exceptions.ExceptionAbstractSource;
import org.fuin.dsl.ddd.gen.exceptions.ExceptionManualSource;

public class ExceptionsGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof Constraint) {
                final Constraint constraint = (Constraint) obj;
                if (constraint.getException() != null) {
                    generate(constraint, fsa);
                }
            }
        }

    }

    private void generate(Constraint constraint, IFileSystemAccess fsa) {

        final Namespace ns = (Namespace) constraint.eContainer();

        final String abstractFilenname = (ns.getName() + ".Abstract" + constraint
                .getException()).replace('.', '/') + ".java";
        fsa.generateFile(abstractFilenname,
                new ExceptionAbstractSource().create(constraint, ns));

        final String manualFilenname = (ns.getName() + "." + constraint
                .getException()).replace('.', '/') + ".java";
        fsa.generateFile(manualFilenname,
                new ExceptionManualSource().create(constraint, ns));

    }

}
