package org.fuin.dsl.ddd.gen.base

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.InternalType
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
	 * Constructor with internal type.
	 * 
	 * @param ctx Context.
	 * @param type Type.
	 */
	new(CodeSnippetContext ctx, InternalType type) {
		this.ctx = ctx
		this.constructors = new ArrayList<ConstructorData>()
		for (con : type.constructors) {
			this.constructors.add(new ConstructorData("public", type.name, con))
		}
	}

	/**
	 * Constructor with value object.
	 * 
	 * @param ctx Context.
	 * @param vo Value object.
	 */
	new(CodeSnippetContext ctx, String typeName, AbstractVO vo) {
		this.ctx = ctx
		this.constructors = new ArrayList<ConstructorData>()
		constructors.add(new ConstructorData("/** Default constructor. */", "protected", typeName, null, null))
		if ((vo.variables == null) || (vo.variables.size == 0)) {
			constructors.add(
				new ConstructorData("/** Constructor with all data. */", "public", typeName, vo.variables, null))
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
		this.constructors = constructors
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
