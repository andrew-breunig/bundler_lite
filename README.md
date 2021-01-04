# BundlerLite

### Description

Conceptual implementation of the dependency graphing components of a typical package manager.

Ignores versioning concerns for simplicity.

### Usage

To run this program from the console, execute the file at `./bin/bundler_lite.rb`:

```
$ chmod u+x ./bin/bundler_lite.rb
$ ./bin/bundler_lite.rb
```

First line of input must specify the length of the expected instruction set:

```
$ 10
# Indicates a set of 10 instructions.
```

Subsequent lines of input may specify commands for managing dependencies:

```
$ DEPEND A B C
# Adds packages B and C as dependencies of package A, provided their relationships are acyclic.
# If package A is currently installed, installs new dependencies.
```

```
$ INSTALL A
# Installs package A and its uninstalled dependencies.
```

```
$ REMOVE A
# Removes package A and any dependencies which are not required by another installation.
```

```
$ LIST
# Lists currently installed packages, sorted alphabetically.
```

Final line of input exits the program by entering the termination command:

```
$ END
# Terminates the program.
```

Note that input which exceeds the specified length or does not resolve to one of the supported commands above will terminate the program.

### Testing

Tests are written for the `test-unit` framework packaged with the Ruby standard library.

Run individual test suites by executing their containing file:

```
$ ruby ./test/commands/test_command.rb
```

Or run all tests by executing the file at `./bin/test_bundler_lite.rb`:

```
$ chmod u+x ./bin/test_bundler_lite.rb
$ ./bin/test_bundler_lite.rb
```

### TODO

`Graph#package`
* Smell: `Package` class stores references to other packages in `@dependencies` as instances of `String`, not of `Package`
* Concern: Divergent representation of packages creates tight coupling between classes in `lib/packages/`
* TODO: Investigate alternative data structures to model one-to-many dependency relationships
