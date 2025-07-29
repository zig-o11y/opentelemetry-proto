## OpenTelemetry Protobuf Zig

[OpenTelemetry Protobuf definitions](https://github.com/open-telemetry/opentelemetry-proto) packaged for Zig.

---

This repository checks out the official OpenTelemetry Protobuf definitions in a submodule and contains a Zig build to expose the generated Zig code as a package.

### Import the package

The following command will checkout the latest avaiable commit on `main`, which _should_ also be the latest tagged version.

```bash
zig fetch --save "git+https://github.com/zig-o11y/opentelemetry-proto
```

To specify a tag, add the ref (e.g. `v1.6.0` tag).

```bash
zig fetch --save "git+https://github.com/zig-o11y/opentelemetry-proto#v1.6.0
```

Tags in this repository will mirror the tags in the OpenTelemetry official repository.

### Generate the code for a new release

```zig
git submodule update --remote
cd proto-src
git checkout <newest-tag>
cd -
zig build
```

### Dependencies

The marvellous [`zig-protobuf`](https://github.com/Arwalk/zig-protobuf/) library from @Arwalk.
