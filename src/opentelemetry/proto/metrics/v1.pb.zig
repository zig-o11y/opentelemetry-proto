// Code generated by protoc-gen-zig
///! package opentelemetry.proto.metrics.v1
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const protobuf = @import("protobuf");
const ManagedString = protobuf.ManagedString;
const fd = protobuf.fd;
const ManagedStruct = protobuf.ManagedStruct;
/// import package opentelemetry.proto.common.v1
const opentelemetry_proto_common_v1 = @import("../common/v1.pb.zig");
/// import package opentelemetry.proto.resource.v1
const opentelemetry_proto_resource_v1 = @import("../resource/v1.pb.zig");

pub const AggregationTemporality = enum(i32) {
    AGGREGATION_TEMPORALITY_UNSPECIFIED = 0,
    AGGREGATION_TEMPORALITY_DELTA = 1,
    AGGREGATION_TEMPORALITY_CUMULATIVE = 2,
    _,
};

pub const DataPointFlags = enum(i32) {
    DATA_POINT_FLAGS_DO_NOT_USE = 0,
    DATA_POINT_FLAGS_NO_RECORDED_VALUE_MASK = 1,
    _,
};

pub const MetricsData = struct {
    resource_metrics: ArrayList(ResourceMetrics),

    pub const _desc_table = .{
        .resource_metrics = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ResourceMetrics = struct {
    resource: ?opentelemetry_proto_resource_v1.Resource = null,
    scope_metrics: ArrayList(ScopeMetrics),
    schema_url: ManagedString = .Empty,

    pub const _desc_table = .{
        .resource = fd(1, .{ .SubMessage = {} }),
        .scope_metrics = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .schema_url = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ScopeMetrics = struct {
    scope: ?opentelemetry_proto_common_v1.InstrumentationScope = null,
    metrics: ArrayList(Metric),
    schema_url: ManagedString = .Empty,

    pub const _desc_table = .{
        .scope = fd(1, .{ .SubMessage = {} }),
        .metrics = fd(2, .{ .List = .{ .SubMessage = {} } }),
        .schema_url = fd(3, .String),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Metric = struct {
    name: ManagedString = .Empty,
    description: ManagedString = .Empty,
    unit: ManagedString = .Empty,
    metadata: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    data: ?data_union,

    pub const _data_case = enum {
        gauge,
        sum,
        histogram,
        exponential_histogram,
        summary,
    };
    pub const data_union = union(_data_case) {
        gauge: Gauge,
        sum: Sum,
        histogram: Histogram,
        exponential_histogram: ExponentialHistogram,
        summary: Summary,
        pub const _union_desc = .{
            .gauge = fd(5, .{ .SubMessage = {} }),
            .sum = fd(7, .{ .SubMessage = {} }),
            .histogram = fd(9, .{ .SubMessage = {} }),
            .exponential_histogram = fd(10, .{ .SubMessage = {} }),
            .summary = fd(11, .{ .SubMessage = {} }),
        };
    };

    pub const _desc_table = .{
        .name = fd(1, .String),
        .description = fd(2, .String),
        .unit = fd(3, .String),
        .metadata = fd(12, .{ .List = .{ .SubMessage = {} } }),
        .data = fd(null, .{ .OneOf = data_union }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Gauge = struct {
    data_points: ArrayList(NumberDataPoint),

    pub const _desc_table = .{
        .data_points = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Sum = struct {
    data_points: ArrayList(NumberDataPoint),
    aggregation_temporality: AggregationTemporality = @enumFromInt(0),
    is_monotonic: bool = false,

    pub const _desc_table = .{
        .data_points = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .aggregation_temporality = fd(2, .{ .Varint = .Simple }),
        .is_monotonic = fd(3, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Histogram = struct {
    data_points: ArrayList(HistogramDataPoint),
    aggregation_temporality: AggregationTemporality = @enumFromInt(0),

    pub const _desc_table = .{
        .data_points = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .aggregation_temporality = fd(2, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ExponentialHistogram = struct {
    data_points: ArrayList(ExponentialHistogramDataPoint),
    aggregation_temporality: AggregationTemporality = @enumFromInt(0),

    pub const _desc_table = .{
        .data_points = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .aggregation_temporality = fd(2, .{ .Varint = .Simple }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Summary = struct {
    data_points: ArrayList(SummaryDataPoint),

    pub const _desc_table = .{
        .data_points = fd(1, .{ .List = .{ .SubMessage = {} } }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const NumberDataPoint = struct {
    attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    start_time_unix_nano: u64 = 0,
    time_unix_nano: u64 = 0,
    exemplars: ArrayList(Exemplar),
    flags: u32 = 0,
    value: ?value_union,

    pub const _value_case = enum {
        as_double,
        as_int,
    };
    pub const value_union = union(_value_case) {
        as_double: f64,
        as_int: i64,
        pub const _union_desc = .{
            .as_double = fd(4, .{ .FixedInt = .I64 }),
            .as_int = fd(6, .{ .FixedInt = .I64 }),
        };
    };

    pub const _desc_table = .{
        .attributes = fd(7, .{ .List = .{ .SubMessage = {} } }),
        .start_time_unix_nano = fd(2, .{ .FixedInt = .I64 }),
        .time_unix_nano = fd(3, .{ .FixedInt = .I64 }),
        .exemplars = fd(5, .{ .List = .{ .SubMessage = {} } }),
        .flags = fd(8, .{ .Varint = .Simple }),
        .value = fd(null, .{ .OneOf = value_union }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const HistogramDataPoint = struct {
    attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    start_time_unix_nano: u64 = 0,
    time_unix_nano: u64 = 0,
    count: u64 = 0,
    sum: ?f64 = null,
    bucket_counts: ArrayList(u64),
    explicit_bounds: ArrayList(f64),
    exemplars: ArrayList(Exemplar),
    flags: u32 = 0,
    min: ?f64 = null,
    max: ?f64 = null,

    pub const _desc_table = .{
        .attributes = fd(9, .{ .List = .{ .SubMessage = {} } }),
        .start_time_unix_nano = fd(2, .{ .FixedInt = .I64 }),
        .time_unix_nano = fd(3, .{ .FixedInt = .I64 }),
        .count = fd(4, .{ .FixedInt = .I64 }),
        .sum = fd(5, .{ .FixedInt = .I64 }),
        .bucket_counts = fd(6, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .explicit_bounds = fd(7, .{ .PackedList = .{ .FixedInt = .I64 } }),
        .exemplars = fd(8, .{ .List = .{ .SubMessage = {} } }),
        .flags = fd(10, .{ .Varint = .Simple }),
        .min = fd(11, .{ .FixedInt = .I64 }),
        .max = fd(12, .{ .FixedInt = .I64 }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const ExponentialHistogramDataPoint = struct {
    attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    start_time_unix_nano: u64 = 0,
    time_unix_nano: u64 = 0,
    count: u64 = 0,
    sum: ?f64 = null,
    scale: i32 = 0,
    zero_count: u64 = 0,
    positive: ?ExponentialHistogramDataPoint.Buckets = null,
    negative: ?ExponentialHistogramDataPoint.Buckets = null,
    flags: u32 = 0,
    exemplars: ArrayList(Exemplar),
    min: ?f64 = null,
    max: ?f64 = null,
    zero_threshold: f64 = 0,

    pub const _desc_table = .{
        .attributes = fd(1, .{ .List = .{ .SubMessage = {} } }),
        .start_time_unix_nano = fd(2, .{ .FixedInt = .I64 }),
        .time_unix_nano = fd(3, .{ .FixedInt = .I64 }),
        .count = fd(4, .{ .FixedInt = .I64 }),
        .sum = fd(5, .{ .FixedInt = .I64 }),
        .scale = fd(6, .{ .Varint = .ZigZagOptimized }),
        .zero_count = fd(7, .{ .FixedInt = .I64 }),
        .positive = fd(8, .{ .SubMessage = {} }),
        .negative = fd(9, .{ .SubMessage = {} }),
        .flags = fd(10, .{ .Varint = .Simple }),
        .exemplars = fd(11, .{ .List = .{ .SubMessage = {} } }),
        .min = fd(12, .{ .FixedInt = .I64 }),
        .max = fd(13, .{ .FixedInt = .I64 }),
        .zero_threshold = fd(14, .{ .FixedInt = .I64 }),
    };

    pub const Buckets = struct {
        offset: i32 = 0,
        bucket_counts: ArrayList(u64),

        pub const _desc_table = .{
            .offset = fd(1, .{ .Varint = .ZigZagOptimized }),
            .bucket_counts = fd(2, .{ .PackedList = .{ .Varint = .Simple } }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const SummaryDataPoint = struct {
    attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    start_time_unix_nano: u64 = 0,
    time_unix_nano: u64 = 0,
    count: u64 = 0,
    sum: f64 = 0,
    quantile_values: ArrayList(SummaryDataPoint.ValueAtQuantile),
    flags: u32 = 0,

    pub const _desc_table = .{
        .attributes = fd(7, .{ .List = .{ .SubMessage = {} } }),
        .start_time_unix_nano = fd(2, .{ .FixedInt = .I64 }),
        .time_unix_nano = fd(3, .{ .FixedInt = .I64 }),
        .count = fd(4, .{ .FixedInt = .I64 }),
        .sum = fd(5, .{ .FixedInt = .I64 }),
        .quantile_values = fd(6, .{ .List = .{ .SubMessage = {} } }),
        .flags = fd(8, .{ .Varint = .Simple }),
    };

    pub const ValueAtQuantile = struct {
        quantile: f64 = 0,
        value: f64 = 0,

        pub const _desc_table = .{
            .quantile = fd(1, .{ .FixedInt = .I64 }),
            .value = fd(2, .{ .FixedInt = .I64 }),
        };

        pub usingnamespace protobuf.MessageMixins(@This());
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};

pub const Exemplar = struct {
    filtered_attributes: ArrayList(opentelemetry_proto_common_v1.KeyValue),
    time_unix_nano: u64 = 0,
    span_id: ManagedString = .Empty,
    trace_id: ManagedString = .Empty,
    value: ?value_union,

    pub const _value_case = enum {
        as_double,
        as_int,
    };
    pub const value_union = union(_value_case) {
        as_double: f64,
        as_int: i64,
        pub const _union_desc = .{
            .as_double = fd(3, .{ .FixedInt = .I64 }),
            .as_int = fd(6, .{ .FixedInt = .I64 }),
        };
    };

    pub const _desc_table = .{
        .filtered_attributes = fd(7, .{ .List = .{ .SubMessage = {} } }),
        .time_unix_nano = fd(2, .{ .FixedInt = .I64 }),
        .span_id = fd(4, .Bytes),
        .trace_id = fd(5, .Bytes),
        .value = fd(null, .{ .OneOf = value_union }),
    };

    pub usingnamespace protobuf.MessageMixins(@This());
};
