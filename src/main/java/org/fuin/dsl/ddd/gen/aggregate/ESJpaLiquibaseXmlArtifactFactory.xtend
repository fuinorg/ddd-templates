package org.fuin.dsl.ddd.gen.aggregate

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.srcgen4j.commons.ArtifactFactory
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact

import static extension org.fuin.dsl.ddd.gen.extensions.StringExtensions.*

class ESJpaLiquibaseXmlArtifactFactory extends AbstractSource<Aggregate> implements ArtifactFactory<Aggregate> {

	override getModelType() {
		return typeof(Aggregate)
	}
	
	override create(Aggregate aggregate, Map<String, Object> context, boolean preparationRun) throws GenerateException {
        val Namespace ns = aggregate.eContainer() as Namespace;
        val filename = "changelog-xxxxx-" + aggregate.getName().toSqlLower + "_events.xml"
        return new GeneratedArtifact(artifactName, filename, create(aggregate, ns).toString().getBytes("UTF-8"));
	}
	
	def create(Aggregate aggregate, Namespace ns) {
		''' 
		<?xml version="1.0" encoding="UTF-8"?>
		<databaseChangeLog xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ext="http://www.liquibase.org/xml/ns/dbchangelog-ext"
			xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-3.0.xsd 
			                    http://www.liquibase.org/xml/ns/dbchangelog-ext http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-ext.xsd">
		
			<changeSet id="x" author="abc">
			
				<comment>Create «aggregate.name» stream</comment>
		
				<createTable tableName="«aggregate.name.toSqlLower»_events" remarks="Events of aggregate «aggregate.name»">
					<column name="«aggregate.name.toSqlLower»_id" type="java.sql.Types.VARCHAR(36)">
						<constraints nullable="false" />
					</column>
					<column name="event_number" type="java.sql.Types.INTEGER(10)">
						<constraints nullable="false" />
					</column>
					<column name="events_id" type="java.sql.Types.BIGINT">
						<constraints nullable="false" references="EVENTS"
							foreignKeyName="fk__«aggregate.name.toSqlInitials»__events_id" />
					</column>
				</createTable>
		
				<addPrimaryKey tableName="«aggregate.name.toSqlLower»_events" columnNames="«aggregate.name.toSqlLower»_id, event_number"
					constraintName="pk__«aggregate.name.toSqlInitials»_events" />
		
				<createTable tableName="«aggregate.name.toSqlLower»_streams" remarks="«aggregate.name» streams">
					<column name="«aggregate.name.toSqlLower»_id" type="java.sql.Types.VARCHAR(36)">
						<constraints nullable="false" primaryKey="true"
							primaryKeyName="pk__«aggregate.name.toSqlInitials»_streams" />
					</column>
					<column name="version" type="java.sql.Types.INTEGER(10)">
						<constraints nullable="false" />
					</column>
					<column name="deleted" type="java.sql.Types.INTEGER(1)">
						<constraints nullable="false" />
					</column>
				</createTable>
				
			</changeSet>
		
		</databaseChangeLog>
		'''	
	}
	
}