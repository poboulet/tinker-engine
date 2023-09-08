# tinker-engine

A small playground project to learn about video game engines.

## How to build

```
./bin/run.sh build // --debug or --release
```

Runs the build script to build the project. It will create a build directory and run cmake and make to build the project.

This will create a binary called `TinkerEngine` in the build/src directory.

### VSCode Launch Configurations

VSCode launch configurations are included to either run or debug the project. These automatically execute the build script with the right flags, and then launch the binary from either the "build/release/src" or "build/debug/src" directory.

- `TinkerEngine: Run ` - Runs the project in release mode.
- `TinkerEngine: Debug ` - Runs the project in debug mode.
- `TinkerEngine: Debug (Tests)` - Runs the test project in debug mode.
- `TinkerEngine: Run (Tests)` - Runs the test project in release mode.
