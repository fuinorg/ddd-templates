package org.fuin.dsl.ddd.gen.validatorgen;

import java.util.Iterator;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.gen.intf.ISubGenerator;
import org.fuin.dsl.ddd.gen.validatorgen.AnnotationSource;
import org.fuin.dsl.ddd.gen.validatorgen.ValidatorAbstractSource;
import org.fuin.dsl.ddd.gen.validatorgen.ValidatorManualSource;

public class ValidatorGenerator implements ISubGenerator {

    public void generate(Resource resource, IFileSystemAccess fsa) {

        final Iterator<EObject> it = resource.getAllContents();
        while (it.hasNext()) {
            final EObject obj = it.next();
            if (obj instanceof Constraint) {
                generate((Constraint) obj, fsa);
            }
        }

    }

    public void generate(Constraint c, IFileSystemAccess fsa) {
        final Namespace ns = (Namespace) c.eContainer();

        // Annotation
        final String annotationFilename = (ns.getName() + "." + c.getName())
                .replace('.', '/') + ".java";
        fsa.generateFile(annotationFilename,
                new AnnotationSource().create(c, ns));

        // Validator
        final String abstractValidatorFilename = (ns.getName() + ".Abstract"
                + c.getName() + "Validator").replace('.', '/')
                + ".java";
        fsa.generateFile(abstractValidatorFilename,
                new ValidatorAbstractSource().create(c, ns));

        final String manualValidatorFilename = (ns.getName() + "."
                + c.getName() + "Validator").replace('.', '/')
                + ".java";
        fsa.generateFile(manualValidatorFilename,
                new ValidatorManualSource().create(c, ns));

    }

}
