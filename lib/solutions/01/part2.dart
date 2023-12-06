part of aoc;

@Solution(day: 1, part: 2)
int day1part2(List<String> input) {
	final RegExp numberRegex = RegExp(r'(?=(\d|one|two|three|four|five|six|seven|eight|nine))');
	final Map<String, String> numberMap = {
		'one': '1',
		'two': '2',
		'three': '3',
		'four': '4',
		'five': '5',
		'six': '6',
		'seven': '7',
		'eight': '8',
		'nine': '9'
	};

	return input
		.map((v) => numberRegex.allMatches(v).map((e) => e[1]))
		.map((v) => v.map((e) => numberMap.containsKey(e) ? numberMap[e] : e))
		.map((v) => int.parse('${v.first}${v.last}'))
		.fold(0, (a, b) => a + b);
}
