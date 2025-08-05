const std = @import("std");
const protobuf = @import("protobuf");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) !void {
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

    // Debug protoc generation in Debug builds
    protoc_step.verbose = optimize == .Debug;

    b.getInstallStep().dependOn(&protoc_step.step);

    const lib_mod = b.addModule("opentelemetry-proto", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "protobuf", .module = protobuf_dep.module("protobuf") },
        },
    });

    const lib = b.addLibrary(.{
        .name = "opentelemetry-proto",
        .root_module = lib_mod,
    });
    const lib_install = b.addInstallArtifact(lib, .{});

    b.getInstallStep().dependOn(&lib.step);
    b.getInstallStep().dependOn(&lib_install.step);

    const tag = b.option([]const u8, "tag",
        \\The tag to use for the OpenTelemetry proto submodule.
        \\If not set, the build step will fail.
    );

    const update_remote = b.addSystemCommand(&.{
        "git",
        "submodule",
        "update",
        "--remote",
    });
    const update_to_tag = b.addSystemCommand(&.{
        "git",
        "submodule",
        "foreach",
        try std.fmt.allocPrint(b.allocator, "git checkout {s}", .{tag orelse ""}),
    });
    update_to_tag.step.dependOn(&update_remote.step);

    const update_step = b.step("update-tag", "Update OpenTelemetry proto submodule to the specified tag");
    update_step.dependOn(&update_to_tag.step);
}
