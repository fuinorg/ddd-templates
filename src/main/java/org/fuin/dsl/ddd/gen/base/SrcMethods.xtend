package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.AbstractEntity
import org.fuin.dsl.cqrs.cqrsDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*

/**
 * Creates source code for a number of methods.
 */
class SrcMethods implements CodeSnippet {

    val CodeSnippetContext ctx;
    val GenerateOptions options
    val List<MethodData> methods

    /**
     * Constructor with entity.
     * 
     * @param ctx Context.
     * @param options Options to use.
     * @param entity Entity.
     * @param makeAbstract Should the method be made abstract?
     */
    new(CodeSnippetContext ctx, GenerateOptions options, AbstractEntity entity, boolean makeAbstract) {
        this.ctx = ctx
        this.options = options
        this.methods = new ArrayList<MethodData>()
        for (method : entity.methods.nullSafe) {
        	if (makeAbstract) {
        		this.methods.add(new MethodData("public", true, method))
        	} else {
            	this.methods.add(new MethodData("public final", false, method))            
            }
        }
    }

    /**
     * Constructor with value object.
     * 
     * @param ctx Context.
     * @param options Options to use.
     * @param type Value object.
     * @param makeAbstract Should the method be made abstract?
     */
    new(CodeSnippetContext ctx, GenerateOptions options, AbstractVO vo, boolean makeAbstract) {
        this.ctx = ctx
        this.options = options
        this.methods = new ArrayList<MethodData>()
        for (method : vo.methods.nullSafe) {
        	if (makeAbstract) {
        		this.methods.add(new MethodData("public", true, method))
        	} else {
            	this.methods.add(new MethodData("public final", false, method))            
            }
        }
    }

    /**
     * Constructor with all mandatory data.
     * 
     * @param ctx Context.
     * @param typeName Name of the type the constructors creates.
     * @param options Options to use.
     * @param constructors Constructors.
     */
    new(CodeSnippetContext ctx, String typeName, GenerateOptions options, List<MethodData> methods) {
        this.ctx = ctx
        this.options = options
        this.methods = methods
    }

    override toString() {
        if ((methods === null) || (methods.size == 0)) {
            return ""
        }
        '''    
            «FOR method : methods.nullSafe»
                «new SrcMethod(ctx, options, method)»
                
            «ENDFOR»
        '''
    }

}
