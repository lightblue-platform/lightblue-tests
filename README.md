lightblue-tests
===============

Functional and load tests for lightblue

# Structure
Each directory at the top level represents a type of test.
* functional
* load

## Functional Tests
Black box (using only external interface) testing to verify the evaluated software is following the specifications.  For lightblue that means testing the crud and metadat services

## Load Tests
Testing the software to understand it limits, making sure that an anticipated peak will be supported and the software will behave correctly. It also gives support to determine the capability testing and then stress testing.

## Web App Tests
Testing the management application interfaces.  Some of the testing might overlap with functional tests but the core intent is to verify the applications function correctly.

# FAQ

## How are functional tests different from unit tests?
With Arquillian and using in-memory databases there is a lot that can be tested about how the applications behave before being deployed.  But there are some things you want to check against a deployed application:
* Functional tests provide verification that a deployment of the application was successfull and that authentication and authorization is working.
* Load tests stress the application ideally in conditions that match (or are) production.  This cannot be done with unit tests.
* Web app tests verify the deployed application behaves correctly and that authentication and authorization works

## How do you define success?
For a functional test to be successful the API called must:
1. not change data in any way to impact production systes
1. return an expected HTTP code
1. return well formed JSON
1. pass all field level verifications for the response

For a load test to be successful:
1. meet all the requirements of a functional test
1. performance as measured over a pervious test execution set degrade more than X stdev [1]

[1] previous test set to verify against and acceptable deviation are not defined yet

For a web app to be successful:
1. TBD
