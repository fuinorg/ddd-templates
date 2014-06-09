package org.fuin.dsl.ddd.gen.extensions

import java.util.ArrayList
import java.util.List
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractVO
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constraint
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ConstraintCall
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainDrivenDesignDslFactory
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ExternalType
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Method
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable

import static extension org.fuin.dsl.ddd.gen.extensions.ConstraintsExtensions.*

/**
 * Provides extension methods for Method.
 */
class MethodExtensions {


	def static List<Constraint> allConstraints(Method method) {
		val List<Constraint> list = new ArrayList<Constraint>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allConstraints);
		}
		if (method.constraints != null) {
			for (ConstraintCall cc : method.constraints.calls) {
				list.add(cc.constraint);
			}
		}
		return list;
	}

	def static List<Variable> allVariables(Method method) {
		var List<Variable> list = new ArrayList<Variable>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			var Variable refVar = createVariableForRef(method.refMethod);
			if (refVar != null) {
				list.add(refVar);
			}
			list.addAll(method.refMethod.allVariables);
		}
		list.addAll(method.variables);
		return list;
	}

	def static List<String> allExceptions(Method method) {
		var List<String> list = new ArrayList<String>();
		if ((method.refMethod != null) && (method != method.refMethod)) {
			list.addAll(method.refMethod.allExceptions);
		}
		if (method.constraints != null) {
			list.addAll(method.constraints.exceptionList);
		}
		return list;
	}
	
	def static Variable createVariableForRef(Method method) {
		if (method.eContainer instanceof AbstractVO) {
			var AbstractVO vo = method.eContainer as AbstractVO;
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName(vo.name.toFirstLower);
			v.setType(vo);
			return v;
		} else if (method.eContainer instanceof AbstractEntity) {
			var ExternalType et = DomainDrivenDesignDslFactory::eINSTANCE.createExternalType();
			et.setName("EntityIdPath");
			var Variable v = DomainDrivenDesignDslFactory::eINSTANCE.createVariable();
			v.setName("entityIdPath");
			v.setType(et);
			return v;
		}
		return null;
	}
	


}
