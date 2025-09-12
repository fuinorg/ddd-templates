package org.fuin.dsl.ddd.gen.enumobject

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.cqrs.cqrsDsl.Attribute
import org.fuin.dsl.cqrs.cqrsDsl.EnumInstance
import org.fuin.dsl.cqrs.cqrsDsl.EnumObject
import org.fuin.dsl.cqrs.cqrsDsl.ExternalType
import org.fuin.dsl.cqrs.cqrsDsl.Variable
import org.fuin.dsl.ddd.gen.base.SrcInvokeGetter
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions
import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.TypeExtensions.*
import jakarta.annotation.Nullable

/**
 * Creates static source code for an enumeration.
 */
class SrcStaticEnumCode implements CodeSnippet {

    val CodeSnippetContext ctx
    val String className
    val List<Attribute> attributes
    val Variable baseVar
    val List<EnumInstance> instances
    val ExternalType base

    new(CodeSnippetContext ctx, EnumObject enumObject) {
        this.ctx = ctx
        this.className = enumObject.name
        this.attributes = enumObject.attributes
        // Workaround for "getFirst()" default method in List that collides with extension
        this.baseVar = CqrsCollectionExtensions.<Attribute>first(attributes.nullSafe)
        this.instances = enumObject.instances
        this.base = enumObject.base
        ctx.requiresImport(Nullable.name)
        ctx.requiresImport(List.name)
    }
    
    override toString() {
        '''    
        /** All instances. */
        public static final List<«className»> ALL = List.of(
            «FOR in : instances SEPARATOR ", "»«in.name»«ENDFOR»
        );
        
        /** Valid instances. */
        public static final List<«className»> VALID = List.of(
            «FOR in : instances.valid SEPARATOR ", "»«in.name»«ENDFOR»
        );
        
        /** Deprecated instances. */
        public static final List<«className»> DEPRECATED = List.of(
            «FOR in : instances.deprecated SEPARATOR ", "»«in.name»«ENDFOR»
        );
        
        «IF base !== null»
        /**
         * Determines if it's possible to return an enumeration instance for the
         * given value.
         * 
         * @param value
         *            Value to check.
         * 
         * @return TRUE if the {@link #valueOf(«base.simpleName(ctx)»)} will return a value else
         *         FALSE.
         */
        public static boolean isValid(@Nullable final «base.simpleName(ctx)» value) {
            if (value == null) {
                return true;
            }
            for (final «className» v : ALL) {
                if («new SrcInvokeGetter(ctx, "v", baseVar)».equals(value)) {
                    return true;
                }
            }
            return false;
        }
        
        /**
         * Returns an enumeration instance for the given value. Throws an
         * {@link IllegalArgumentException} if the value is invalid.
         * 
         * @param value
         *            Value to check.
         * 
         * @return Instance
         */
        @Nullable
        public static «className» valueOf(@Nullable final «base.simpleName(ctx)» value) {
            if (value == null) {
                return null;
            }
            for (final «className» v : ALL) {
                if («new SrcInvokeGetter(ctx, "v", baseVar)».equals(value)) {
                    return v;
                }
            }
            throw new IllegalArgumentException("Unknown value: " + value);
        }
        
        «ENDIF»
        '''
    }

    def private static List<EnumInstance> valid(List<EnumInstance> all) {
        val List<EnumInstance> list = new ArrayList<EnumInstance>()
        for (instance : all) {
            if (instance.deprecated === null) {
                list.add(instance)
            }
        }
        return list
    }

    def private static List<EnumInstance> deprecated(List<EnumInstance> all) {
        val List<EnumInstance> list = new ArrayList<EnumInstance>()
        for (instance : all) {
            if (instance.deprecated !== null) {
                list.add(instance)
            }
        }
        return list
    }

}
