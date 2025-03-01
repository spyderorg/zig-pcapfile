const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("zig-pcapfile", .{ .root_source_file = b.path("src/lib.zig") });

    const lib = b.addStaticLibrary(.{
        .name = "zig-pcapfile",
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    const pcap_tests = b.addTest(.{
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_pcap_tests = b.addRunArtifact(pcap_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_pcap_tests.step);
}
