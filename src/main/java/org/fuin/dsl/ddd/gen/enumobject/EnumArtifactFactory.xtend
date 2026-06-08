package org.fuin.dsl.ddd.gen.enumobject

import java.util.Map
import org.fuin.dsl.cqrs.cqrsDsl.EnumObject
import org.fuin.dsl.cqrs.cqrsDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.GenerateOptions
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcParamsAssignment
import org.fuin.dsl.ddd.gen.base.SrcParamsDecl
import org.fuin.dsl.ddd.gen.base.SrcVarsDecl
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.cqrs.extensions.CqrsAbstractElementExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsAttributeExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsCollectionExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsEObjectExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsLiteralExtensions.*
import static extension org.fuin.dsl.cqrs.extensions.CqrsStringExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*
import java.util.List
import org.fuin.dsl.ddd.gen.base.SrcGetters

class EnumArtifactFactory extends AbstractSource<EnumObject> {

    override getModelType() {
        typeof(EnumObject)
    }

    override create(EnumObject enu, Map<String, Object> context, boolean preparationRun) throws GenerateException {

        val className = enu.getName()
        val Namespace ns = enu.namespace;
        val pkg = ns.asPackage
        val fqn = pkg + "." + className
        val filename = fqn.replace('.', '/') + ".java";

        val CodeReferenceRegistry refReg = context.codeReferenceRegistry
        refReg.putReference(enu.uniqueName, fqn)

        if (preparationRun) {

            // No code generation during preparation phase
            return null
        }

        val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
        ctx.addImports
        ctx.addReferences(enu)

        return List.of(new GeneratedArtifact(artifactName, filename,
            create(ctx, enu, pkg, className).toString().getBytes("UTF-8")));
    }

    def addImports(CodeSnippetContext ctx) {
    }

    def addReferences(CodeSnippetContext ctx, EnumObject enu) {
    }

    def create(SimpleCodeSnippetContext ctx, EnumObject eo, String pkg, String className) {
        var String src
        if (eo.attributes.nullSafe.size == 0) {
            src = ''' 
                /** «eo.doc.text» */
                public enum «className» {
                    
                    «FOR in : eo.instances SEPARATOR ','»
                    «in.doc»
                    «in.name»
                    
                    «ENDFOR»;
                    
                    «new SrcStaticEnumCode(ctx, eo)»
                }
                '''
        } else {
            src = ''' 
                /** «eo.doc.text» */
                public enum «className» {
                
                    «FOR in : eo.instances SEPARATOR ','»
                    «in.doc»
                    «in.name»(«FOR lit : in.params SEPARATOR ', '»«lit.str»«ENDFOR»)
                    
                    «ENDFOR»;
                    
                    «new SrcVarsDecl(ctx, "private", GenerateOptions.empty(), eo)»
                    «new SrcGetters(ctx, GenerateOptions.empty(), "public", eo.attributes)»
                    «new SrcStaticEnumCode(ctx, eo)»
                    private «className»(«new SrcParamsDecl(ctx, GenerateOptions.empty(), eo.attributes.asParameters)») {
                        «new SrcParamsAssignment(ctx, eo.attributes.asParameters)»
                    }
                
                }
                '''
        }

        new SrcAll(ctx, copyrightHeader, pkg, ctx.imports, src).toString

    }
    
}
