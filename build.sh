#!/bin/sh

echo "Cleaning existing classes..."
rm -rf build
mkdir -p build
# Clean up any stray .class files in the main directory
find . -maxdepth 1 -name "*.class" -type f -delete

echo "Compiling source code and unit tests..."
javac -d build -classpath .:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar src/main/java/*.java src/test/java/*.java
if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

echo "Running unit tests..."
java -cp build:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore EdgeConnectorTest
if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

echo "Running application..."
java -cp build RunEdgeConvert