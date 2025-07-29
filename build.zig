const std = @import("std");
const protobuf = @import("protobuf");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Protobuf code generation from the OpenTelemetry proto files.
    const protobuf_dep = b.dependency("protobuf", .{
        .target = target,
        .optimize = optimize,
    });

    var protoc_step = protobuf.RunProtocStep.create(b, protobuf_dep.builder, target, .{
        // Output directory for the generated zig files
        .destination_directory = b.path("src"),
        .source_files = &.{
            // Add more protobuf definitions as the API grows
            // Signals
            "proto-src/opentelemetry/proto/common/v1/common.proto",
            "proto-src/opentelemetry/proto/resource/v1/resource.proto",
            "proto-src/opentelemetry/proto/metrics/v1/metrics.proto",
            "proto-src/opentelemetry/proto/trace/v1/trace.proto",
            "proto-src/opentelemetry/proto/logs/v1/logs.proto",
            // collector types for OTLP
            "proto-src/opentelemetry/proto/collector/metrics/v1/metrics_service.proto",
            "proto-src/opentelemetry/proto/collector/trace/v1/trace_service.proto",
            "proto-src/opentelemetry/proto/collector/logs/v1/logs_service.proto",
        },
        .include_directories = &.{
            // Imports in proto files require that the top-level directory
            // containing te proto files is included
            "proto-src/",
        },
    });

    // Debug protoc generation in all builds
    protoc_step.verbose = true;

    b.getInstallStep().dependOn(&protoc_step.step);
}
