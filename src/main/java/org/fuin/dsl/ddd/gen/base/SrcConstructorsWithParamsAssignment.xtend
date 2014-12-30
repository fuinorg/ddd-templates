package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.srcgen4j.core.emf.CodeSnippet
import org.fuin.srcgen4j.core.emf.CodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*

/**
 * Creates source code for a number of constructors with 
 * all parameters assigned to an instance variable.
 */
class SrcConstructorsWithParamsAssignment implements CodeSnippet {

	val CodeSnippetContext ctx;
	val List<ConstructorData> constructors

	/**
	 * Constructor with entity.
	 * 
	 * @param ctx Context.
	 * @param entity Entity.
	 */
	new(CodeSnippetContext ctx, AbstractEntity entity) {
		this.ctx = ctx
		this.constructors = new ArrayList<ConstructorData>()
		for (con : entity.constructors.nullSafe) {
			this.constructors.add(new ConstructorData("public", entity.name, con))
		}
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param vo Value object.
	 * @param abstr Generate abstract class?
	 */
	new(CodeSnippetContext ctx, AbstractVO vo, boolean abstr) {
		this.ctx = ctx
		this.constructors = new ArrayList<ConstructorData>()
		var String name;
		if (abstr) {
			name = "Abstract" + vo.name
		} else {
			name = vo.name
		}
		constructors.add(new ConstructorData("/** Default constructor. */", "protected", name, null, null))
		if ((vo.constructors == null) || (vo.constructors.size == 0)) {
			constructors.add(
				new ConstructorData("/** Constructor with all data. */", "public", name, vo.variables, null))
		} else {
			for (con : vo.constructors.nullSafe) {
				this.constructors.add(new ConstructorData("public", name, con))
			}
		}
	}

	/**
	 * Constructor with all mandatory data.
	 * 
	 * @param ctx Context.
	 * @param typeName Name of the type the constructors creates.
	 * @param constructors Constructors.
	 */
	new(CodeSnippetContext ctx, String typeName, List<ConstructorData> constructorData) {
		this.ctx = ctx
		this.constructors = constructorData
	}

	override toString() {
		if ((constructors == null) || (constructors.size == 0)) {
			return ""
		}
		'''	
			«FOR constructor : constructors.nullSafe»
				«new SrcConstructorWithParamsAssignment(ctx, constructor)»
				
			«ENDFOR»
		'''
	}

}
