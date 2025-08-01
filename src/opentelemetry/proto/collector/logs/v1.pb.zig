// Code generated by protoc-gen-zig
///! package opentelemetry.proto.collector.logs.v1
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;
const ManagedStruct = protobuf.ManagedStruct;
/// import package opentelemetry.proto.logs.v1
const opentelemetry_proto_logs_v1 = @import("../../logs/v1.pb.zig");

pub const ExportLogsServiceRequest = struct {
    resource_logs: ArrayList(opentelemetry_proto_logs_v1.ResourceLogs),

    pub const _desc_table = .{
        .resource_logs = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ExportLogsServiceResponse = struct {
    partial_success: ?ExportLogsPartialSuccess = null,

    pub const _desc_table = .{
        .partial_success = fd(1, .{ .SubMessage = {} }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ExportLogsPartialSuccess = struct {
    rejected_log_records: i64 = 0,
    error_message: ManagedString = .Empty,

    pub const _desc_table = .{
        .rejected_log_records = fd(1, .{ .Varint = .Simple }),
        .error_message = fd(2, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};
