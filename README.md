ddd-templates
=============

Xtend based domain-driven design (DDD) code generation templates for use with SrcGen4J

[![Build Status](https://jenkins.fuin.org/job/ddd-templates/badge/icon)](https://jenkins.fuin.org/job/ddd-templates/)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.fuin.dsl.ddd/ddd-templates/badge.svg)](https://maven-badges.herokuapp.com/maven-central/org.fuin.dsl.ddd/ddd-templates/)
[![LGPLv3 License](http://img.shields.io/badge/license-LGPLv3-blue.svg)](https://www.gnu.org/licenses/lgpl.html)
[![Java Development Kit 1.8](https://img.shields.io/badge/JDK-1.8-green.svg)](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

What is this?
-------------
The project provides several artifact factories that can be used to generate code using SrcGen4J: 
[srcgen4j-common](https://github.com/fuinorg/srcgen4j-common/) / [srcgen4j-core](https://github.com/fuinorg/srcgen4j-core/) / [srcgen4j-maven](https://github.com/fuinorg/srcgen4j-maven/) 
from an Xtext based [DDD DSL](https://github.com/fuinorg/org.fuin.dsl.ddd) model.   

An [artifact factory](https://github.com/fuinorg/srcgen4j-commons/blob/master/src/main/java/org/fuin/srcgen4j/commons/ArtifactFactory.java) is a piece of code that creates an artifact for a given model element.
The result is Java code based on utility classes defined in the [ddd-4-java](https://github.com/fuinorg/ddd-4-java) project.

Aggregate Factories
-------------------
Factories generating code based on the the 'aggregate' model element.

| Factory Name | Reference | Description | Example |
| :----------- | :-------- | :---------- | :------ |
| [AbstractAggregateArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/AbstractAggregateArtifactFactory.xtend) | [AbstractAggregateRoot](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/ddd/AbstractAggregateRoot.java) | Abstract aggregate root Java class. | [AbstractAggregateA](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst/x/aggregates/AbstractAggregateA.java) |
| [FinalAggregateArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/FinalAggregateArtifactFactory.xtend)   | - | Final aggregate root Java source extending the above abstract class. | [AggregateA](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst/x/aggregates/AggregateA.java) |
| [AggregateDocArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/AggregateDocArtifactFactory.xtend)   | - | HTML file with a description of the aggregate. | - |
| [ESJpaEventArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESJpaEventArtifactFactory.xtend)   | [JpaStreamEvent](https://github.com/fuinorg/event-store-commons/blob/master/jpa/src/main/java/org/fuin/esc/jpa/JpaStreamEvent.java) | JPA entity that stores all events of an aggregate type. | - |
| [ESJpaEventIdArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESJpaEventIdArtifactFactory.xtend)   | - | JPA key for an event that is based on the aggregate identifier and version number. | - |
| [ESJpaLiquibaseXmlArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESJpaLiquibaseXmlArtifactFactory.xtend)   | - | [Liquibase](http://www.liquibase.org/) XML databaseChangeLog that creates all necessary tables for the aggregates. | - |
| [ESJpaStreamArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESJpaStreamArtifactFactory.xtend)   | [JpaStream](https://github.com/fuinorg/event-store-commons/blob/master/jpa/src/main/java/org/fuin/esc/jpa/JpaStream.java) | JPA entity for storing the aggregate stream itself (not the events). | - |
| [ESRepositoryArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESRepositoryArtifactFactory.xtend)   | [EventStoreRepository](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/esrepo/EventStoreRepository.java) | Event store based repository for a single aggregate type. | [AggregateCRepository](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst2/x/aggregates/AggregateCRepository.java) |
| [ESRepositoryFactoryArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/ESRepositoryFactoryArtifactFactory.xtend)   | - | Creates a CDI based producer that creates above event store repsoitory. | [AggregateCRepositoryFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst2/x/aggregates/AggregateCRepositoryFactory.java) |

For an explanation of the generated event store commons JPA types, see the [documentation](https://github.com/fuinorg/event-store-commons/tree/master/jpa).

See [source code](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate).


Aggregate ID Factories
----------------------
Factories generating code based on the the 'aggregate-id' model element.

| Factory Name | Reference | Description | Example |
| :----------- | :-------- | :---------- | :------ |
| [AbstractAggregateIdArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/AbstractAggregateIdArtifactFactory.xtend)   | [AggregateRootId](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/ddd/AggregateRootId.java) | Abstract aggregate root identifier Java class. | [AbstractMyAggregateId](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst/x/aggregateid/AbstractMyAggregateId.java) |
| [FinalAggregateIdArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/FinalAggregateIdArtifactFactory.xtend)   | - | Final aggregate root identifier Java source extending the above abstract class. | [MyAggregateId](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst/x/aggregateid/MyAggregateId.java) |
| [AggregateIdArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/AggregateIdArtifactFactory.xtend)   | [AggregateRootId](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/ddd/AggregateRootId.java) | Aggregate root identifier Java class (Not splitted into 'abstract' and 'final' parts). | [MyAggregateId](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst2/x/aggregateid/MyAggregateId.java) |
| [AggregateIdConverterArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/AggregateIdConverterArtifactFactory.xtend)   | - | Aggregate root identifier converter for JPA/JAXB/JSONB. | [MyAggregateIdConverter](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst2/x/aggregateid/MyAggregateIdConverter.java) |
| [AggregateIdStreamFactoryArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/AggregateIdStreamFactoryArtifactFactory.xtend)   | [IdStreamFactory]() | ![Warning](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/warning.gif) ~~OUTDATED~~ - Needs to be reworked. | [Example]() |
| [SimpleAggregateIdArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid/SimpleAggregateIdArtifactFactory.xtend)   | [AggregateRootUuid](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/ddd/AggregateRootUuid.java) | UUID based aggregate root identifier Java class. | [MyAggregate5Id](https://github.com/fuinorg/ddd-templates/blob/master/src/test/expected-java/tst2/x/aggregateid/MyAggregate5Id.java) |

See [source code](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregateid).


Constraint Factories
--------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/constraint).

Entity Factories
----------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/entity).

Entity ID Factories
-------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/entityid).

Enum Object Factories
---------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/enumobject).

Event Factories
---------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/event).

Exception Factories
-------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/except).

Resource Set Factories
----------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/resourceset).

Service Factories
-----------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/service).

Value Object Factories
----------------------
![Work in progress](https://raw.githubusercontent.com/fuinorg/ddd-templates/master/doc/work-in-progress.png)
See [source code](https://github.com/fuinorg/ddd-templates/tree/master/src/main/java/org/fuin/dsl/ddd/gen/valueobject).

- - - - - - - - -

Snapshots
=========

Snapshots can be found on the [OSS Sonatype Snapshots Repository](http://oss.sonatype.org/content/repositories/snapshots/org/fuin "Snapshot Repository"). 

Add the following to your [.m2/settings.xml](http://maven.apache.org/ref/3.2.1/maven-settings/settings.html "Reference configuration") to enable snapshots in your Maven build:

```xml
<repository>
    <id>sonatype.oss.snapshots</id>
    <name>Sonatype OSS Snapshot Repository</name>
    <url>http://oss.sonatype.org/content/repositories/snapshots</url>
    <releases>
        <enabled>false</enabled>
    </releases>
    <snapshots>
        <enabled>true</enabled>
    </snapshots>
</repository>
```
