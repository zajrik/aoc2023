part of aoc;

@Solution(day: 1, part: 1)
int day1part1(List<String> input) {
	return input
		.map((v) => v.replaceAll(RegExp('[a-zA-Z]+'), '').split(''))
		.map((v) => int.parse('${v.first}${v.last}'))
		.fold(0, (a, b) => a + b);
}
