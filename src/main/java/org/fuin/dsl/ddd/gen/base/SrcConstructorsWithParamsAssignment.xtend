package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.extensions.DddAbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.extensions.DddCollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions.*

/**
 * Creates source code for a number of constructors with 
 * all parameters assigned to an instance variable.
 */
class SrcConstructorsWithParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx;
	val GenerateOptions options
	val List<ConstructorData> constructors

	/**
	 * Constructor with entity.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param entity Entity.
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractEntity entity) {
		this(ctx, options, entity, false)
	}
	
	/**
	 * Constructor with entity.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param entity Entity.
	 * @param passToSuper Defines if all variables should be passed to the super call
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractEntity entity, boolean passToSuper) {
		this.ctx = ctx
		this.options = options
		this.constructors = new ArrayList<ConstructorData>()
		for (con : entity.constructors.nullSafe) {
			this.constructors.add(new ConstructorData("public", entity.name, con))
		}
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param vo Value object.
	 * @param abstr Generate abstract class?
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractVO vo, boolean abstr) {
		this(ctx, options, vo, "public", abstr, false)
	}
	
	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param vo Value object.
	 * @param abstr Generate abstract class?
	 * @param passToSuper Defines if all variables should be passed to the super call
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractVO vo, boolean abstr, boolean passToSuper) {
		this(ctx, options, vo, "public", abstr, passToSuper)
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param vo Value object.
	 * @param modifiers Modifiers for the constructor
	 * @param abstr Generate abstract class?
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractVO vo, String modifiers, boolean abstr) {
		this(ctx, options, vo, modifiers, abstr, false)
	}
	
	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param vo Value object.
	 * @param modifiers Modifiers for the constructor
	 * @param abstr Generate abstract class?
	 * @param passToSuper Defines if all variables should be passed to the super call
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, AbstractVO vo, String modifiers, boolean abstr, boolean passToSuper) {
		this.ctx = ctx
		this.options = options
		this.constructors = new ArrayList<ConstructorData>()

		if (vo.attributes.nullSafe.size > 0) {

			var String name;
			if (abstr) {
				name = vo.abstractName
			} else {
				name = vo.name
			}
			constructors.add(new ConstructorData("/** Default constructor. */", "protected", name, null, null))
			if ((vo.constructors === null) || (vo.constructors.size == 0)) {
				constructors.add(
					new ConstructorData("/** Constructor with all data. */", modifiers, name, vo.asWrappedParameters(passToSuper), null))
			} else {
				for (con : vo.constructors.nullSafe) {
					this.constructors.add(new ConstructorData("public", name, con, passToSuper))
				}
			}

		}

	}

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param options Options to use.
	 * @param constructors Constructors.
	 */
	new(CodeSnippetContext ctx, GenerateOptions options, List<ConstructorData> constructorData) {
		this.ctx = ctx
		this.options = options
		this.constructors = constructorData
	}

	override toString() {
		if ((constructors === null) || (constructors.size == 0)) {
			return ""
		}
		'''	
			«FOR constructor : constructors.nullSafe»
				«new SrcConstructorWithParamsAssignment(ctx, options, constructor)»
				
			«ENDFOR»
		'''
	}

}
