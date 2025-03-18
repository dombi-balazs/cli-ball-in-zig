const std = @import("std");
const stdout = std.io.getStdOut().writer();

//------------------------------------------------------

fn gotoxy(x: u8, y: u8) !void {
    try stdout.print("\x1b[{};{}H", .{ y, x });
}

//------------------------------------------------------

fn clearScreen() !void {
    try stdout.print("\x1b[2J", .{});
}

//------------------------------------------------------

fn sleeper() void {
    std.time.sleep(1 * std.time.ns_per_s / 5);
}

//------------------------------------------------------

fn square(x1: u8, y1: u8, x2: u8, y2: u8) !void {
    var x: u8 = x1;
    var y: u8 = y1;

    while (x < x2) : (x += 1) {
        try gotoxy(x, y1);
        try stdout.print("*", .{});
        try gotoxy(x, y2);
        try stdout.print("*", .{});
    }

    while (y < y2) : (y += 1) {
        try gotoxy(x1, y);
        try stdout.print("*", .{});
        try gotoxy(x2, y);
        try stdout.print("*", .{});
    }
}

//------------------------------------------------------

pub fn main() !void {
    try clearScreen();
    try gotoxy(0, 0);
    try square(1, 1, 50, 20);

    var m: u8 = 2;
    while (m < 20) : (m += 1) {
        var n: u8 = 19;
        var v: u8 = m;
        while (n > m) : (n -= 1) {
            try gotoxy(25, n);
            try stdout.print("*\n", .{});
            sleeper();
            try gotoxy(25, n);
            try stdout.print(" ", .{});
        }
        while (v < 19) : (v += 1) {
            try gotoxy(25, v);
            try stdout.print("*\n", .{});
            sleeper();
            try gotoxy(25, v);
            try stdout.print(" ", .{});
        }
    }
}
