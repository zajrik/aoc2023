part of aoc;

/// Metadata class to mark a function as an Advent of Code solution to be loaded
/// and executed at runtime.
class Solution {
	final int day;
	final int part;

	const Solution({
		required this.day,
		required this.part
	});
}
