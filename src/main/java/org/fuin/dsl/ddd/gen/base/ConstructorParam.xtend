package org.fuin.dsl.ddd.gen.base

import javax.validation.constraints.NotNull
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Invariants
import org.fuin.dsl.ddd.domainDrivenDesignDsl.OverriddenTypeMetaInfo
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Type
import org.eclipse.emf.ecore.EStructuralFeature
import org.eclipse.emf.ecore.EOperation
import org.eclipse.emf.common.util.EList
import java.lang.reflect.InvocationTargetException
import org.eclipse.emf.common.notify.Notification

/**
 * Enhances the variable with additional information.
 */
class ConstructorParam implements Variable {
	
	val Variable variable
	
	val boolean passToSuper
	
	new(@NotNull Variable variable) {
		this.variable = variable
		this.passToSuper = false
	}
	
	new(@NotNull Variable variable, boolean passToSuper) {
		this.variable = variable
		this.passToSuper = passToSuper
	}
	
	def isPassToSuper() {
		passToSuper
	}
	
	override getDoc() {
		variable.doc
	}
	
	override getInvariants() {
		variable.invariants
	}
	
	override getMultiplicity() {
		variable.multiplicity
	}
	
	override getName() {
		variable.name
	}
	
	override getNullable() {
		variable.nullable
	}
	
	override getOverridden() {
		variable.overridden
	}
	
	override getType() {
		variable.type
	}
	
	override setDoc(String value) {
		variable.doc = value
	}
	
	override setInvariants(Invariants value) {
		variable.invariants = value
	}
	
	override setMultiplicity(String value) {
		variable.multiplicity = value
	}
	
	override setName(String value) {
		variable.name = value
	}
	
	override setNullable(String value) {
		variable.nullable = value
	}
	
	override setOverridden(OverriddenTypeMetaInfo value) {
		variable.overridden = value
	}
	
	override setType(Type value) {
		variable.type = value
	}
	
	override eAllContents() {
		variable.eAllContents
	}
	
	override eClass() {
		variable.eClass
	}
	
	override eContainer() {
		variable.eContainer
	}
	
	override eContainingFeature() {
		variable.eContainingFeature
	}
	
	override eContainmentFeature() {
		variable.eContainmentFeature
	}
	
	override eContents() {
		variable.eContents
	}
	
	override eCrossReferences() {
		variable.eCrossReferences
	}
	
	override eGet(EStructuralFeature feature) {
		variable.eGet(feature)
	}
	
	override eGet(EStructuralFeature feature, boolean resolve) {
		variable.eGet(feature, resolve)
	}
	
	override eInvoke(EOperation operation, EList<?> arguments) throws InvocationTargetException {
		variable.eInvoke(operation, arguments)
	}
	
	override eIsProxy() {
		variable.eIsProxy
	}
	
	override eIsSet(EStructuralFeature feature) {
		variable.eIsSet(feature)
	}
	
	override eResource() {
		variable.eResource
	}
	
	override eSet(EStructuralFeature feature, Object newValue) {
		variable.eSet(feature, newValue)
	}
	
	override eUnset(EStructuralFeature feature) {
		variable.eUnset(feature)
	}
	
	override eAdapters() {
		variable.eAdapters
	}
	
	override eDeliver() {
		variable.eDeliver
	}
	
	override eNotify(Notification arg0) {
		variable.eNotify(arg0)
	}
	
	override eSetDeliver(boolean arg0) {
		variable.eSetDeliver(arg0)
	}
	
}
