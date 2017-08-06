ddd-templates
=============

Xtend based domain-driven design (DDD) code generation templates for use with SrcGen4J

[![Build Status](https://fuin-org.ci.cloudbees.com/job/ddd-templates/badge/icon)](https://fuin-org.ci.cloudbees.com/job/ddd-templates/)
[![Maven Central](https://maven-badges.herokuapp.com/maven-central/org.fuin.dsl.ddd/ddd-templates/badge.svg)](https://maven-badges.herokuapp.com/maven-central/org.fuin.dsl.ddd/ddd-templates/)
[![LGPLv3 License](http://img.shields.io/badge/license-LGPLv3-blue.svg)](https://www.gnu.org/licenses/lgpl.html)
[![Java Development Kit 1.8](https://img.shields.io/badge/JDK-1.8-green.svg)](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

<a href="https://fuin-org.ci.cloudbees.com/job/ddd-templates"><img src="http://www.fuin.org/images/Button-Built-on-CB-1.png" width="213" height="72" border="0" alt="Built on CloudBees"/></a>

What is this?
-------------
The project provides several artifact factories that can be used to generate code using SrcGen4J 
([srcgen4j-common](https://github.com/fuinorg/srcgen4j-common/) / [srcgen4j-core](https://github.com/fuinorg/srcgen4j-core/) / [srcgen4j-maven](https://github.com/fuinorg/srcgen4j-maven/)) 
from an Xtext based [DDD DSL](https://github.com/fuinorg/org.fuin.dsl.ddd) model.   

An [artifact factory](https://github.com/fuinorg/srcgen4j-commons/blob/master/src/main/java/org/fuin/srcgen4j/commons/ArtifactFactory.java) is a piece of code that creates an artifact for a given model element.
The result is Java code based on utility classes defined in the [ddd-4-java](https://github.com/fuinorg/ddd-4-java) project.

Aggregate Factories
-------------------
Factories generating code based on the the 'aggregate' model element.

Factory Name | ddd-4-java | Description
-------- | -------- | --------
[AbstractAggregateArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/AbstractAggregateArtifactFactory.xtend) | [AbstractAggregateRoot](https://github.com/fuinorg/ddd-4-java/blob/master/src/main/java/org/fuin/ddd4j/ddd/AbstractAggregateRoot.java) | Abstract aggregate root Java class.
[FinalAggregateArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/FinalAggregateArtifactFactory.xtend)   | - | Final aggregate root Java source extending the above abstract class.
[AggregateDocArtifactFactory](https://github.com/fuinorg/ddd-templates/blob/master/src/main/java/org/fuin/dsl/ddd/gen/aggregate/AggregateDocArtifactFactory.xtend)   | - | Single HTML page with all known aggregates.

**TBD**

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
