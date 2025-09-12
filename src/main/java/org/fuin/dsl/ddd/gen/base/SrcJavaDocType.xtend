package org.fuin.dsl.ddd.gen.base

import org.fuin.dsl.cqrs.cqrsDsl.Constructor
import org.fuin.dsl.cqrs.cqrsDsl.Event
import org.fuin.dsl.cqrs.cqrsDsl.InternalType
import org.fuin.dsl.cqrs.cqrsDsl.Method
import org.fuin.dsl.cqrs.cqrsDsl.Service
import org.fuin.srcgen4j.core.emf.CodeSnippet

import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import org.fuin.dsl.cqrs.cqrsDsl.Command

/**
 * Creates the source code for a type (class, interface) JavaDoc.
 */
class SrcJavaDocType implements CodeSnippet {

    val String text

    /**
     * Constructor with doc.
     * 
     * @param doc Doc including comment characters.
     */
    new(String doc) {
        this.text = doc.text
    }

    /**
     * Constructor with constructor.
     * 
     * @param method Constructor with doc.
     */
    new(Constructor constructor) {
        this(constructor.doc)
    }

    /**
     * Constructor with method.
     * 
     * @param method Method with doc.
     */
    new(Method method) {
        this(method.doc)
    }

    /**
     * Constructor with internal type.
     * 
     * @param internalType Type with doc.
     */
    new(InternalType internalType) {
        this(internalType.doc)
    }

    /**
     * Constructor with service.
     * 
     * @param service Service with doc.
     */
    new(Service service) {
        this(service.doc)
    }
    
    /**
     * Constructor with event.
     * 
     * @param event Event with doc.
     */
    new(Event event) {
        this(event.doc)
    }

    /**
     * Constructor with command.
     * 
     * @param event Command with doc.
     */
    new(Command command) {
        this(command.doc)
    }

    override toString() {
        '''
            /**
             * «text»
             */
        '''
    }

}
