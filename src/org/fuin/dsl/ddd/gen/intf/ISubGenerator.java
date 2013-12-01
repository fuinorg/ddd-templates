package org.fuin.dsl.ddd.gen.intf;

import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.IFileSystemAccess;

/**
 * Generator that creates parts of the whole generation process.
 */
public interface ISubGenerator {

    /**
     * Generates files from a resource.
     *
     * @param resource
     *            Resource.
     * @param fsa
     *            File system access.
     */
    public void generate(Resource resource, IFileSystemAccess fsa);

}
