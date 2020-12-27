# BundlerLite

### Description

Conceptual implementation of the dependency graphing components of a typical package manager; ignores versioning concerns for simplicity.

### Usage

To run this program from the console, execute the file at `./bin/bundler_lite.rb`:

`$ chmod u+x ./bin/bundler_lite.rb`
`$ ./bin/bundler_lite.rb`

The first line of input must specify the length of the expected instruction set:

* `"10\n"` _Indicates a set of 10 instructions._

Subsequent lines may specify commands for managing dependencies:

* `DEPEND A B C` _Adds packages `B` and `C` as dependencies of package `A`, provided the relationships are acyclic._
* `INSTALL A` _Installs package `A` and its uninstalled dependencies._
* `REMOVE A` _Removes package `A` if it is not required by another packages, and its non-required dependencies._
* `LIST` _Lists currently installed packages._

Exit the program by entering the termination command:

* `END` _Terminates the program._

Note that input which exceeds the specified length or does not resolve to an appropriate command above will terminate the program.

### Testing

Tests are written for the `test-unit` framework packaged with the Ruby standard library.

Run individual test suites by executing their containing file:

`$ ruby ./test/commands/test_command.rb`

Or run all tests by executing the file at `./bin/test_bundler_lite.rb`:

`$ chmod u+x ./bin/test_bundler_lite.rb`
`$ ./bin/test_bundler_lite.rb`

### TODO

`Graph#package`
* Smell: `Package` class stores references to other packages in `@dependencies` list as instances of `String`, not `Package`
* Concern: Context-depdendent representation of packages produces tight coupling between classes in `lib/packages`
* TODO: Investigate alternative data structures for modeling dependency relationships