part of aoc;

class Day3Gear {
	final int x;
	final int y;

	final List<Day3PartNumber> adjacentParts = [];

	Day3Gear({
		required this.x,
		required this.y
	});
}

@Solution(day: 3, part: 2)
int day3part2(List<List<String>> input) {
	int result = 0;

	String currentPart = '';
	int partX = 0;
	int partY = 0;

	final RegExp numerical = RegExp(r'\d');

	final List<Day3PartNumber> parts = [];
	final Map<String, Day3Gear> gears = {};

	// Add the current part number to the parts list, reset tracking, and find adjacent gears
	void finalizePart() {
		final Day3PartNumber part = Day3PartNumber(
			x: partX,
			y: partY,
			len: currentPart.length,
			value: int.parse(currentPart)
		);

		parts.add(part);

		// Reset tracking
		currentPart = '';
		partX = 0;
		partY = 0;

		// Find adjacent gears
		final int xStart = max(0, part.x - 1);
		final int xEnd = min(input.length - 1, part.x + 1);

		final int yStart = max(0, part.y - 1);
		final int yEnd = min(input[part.x].length - 1, part.y + part.len);

		for (int x = xStart; x <= xEnd; x++) {
			for (int y = yStart; y <= yEnd; y++) {
				if (input[x][y] == '*') {
					final Day3Gear gear = gears['$x:$y'] ?? Day3Gear(x: x, y: y);

					gear.adjacentParts.add(part);
					gears['$x:$y'] = gear;
				}
			}
		}
	}

	// Find all potential part numbers
	for (int x = 0; x < input.length; x++) {
		for (int y = 0; y < input[x].length; y++) {
			// If we're at the end of a line, finalize current part and move to next line
			if (y == input[x].length - 1 && currentPart.isNotEmpty && numerical.hasMatch(input[x][y])) {
				currentPart += input[x][y];
				finalizePart();
			}

			// Append to current part if we hit a number
			else if (numerical.hasMatch(input[x][y])) {
				// Track starting position
				if (currentPart.isEmpty) {
					partX = x;
					partY = y;
				}

				currentPart += input[x][y];
			}

			// Otherwise finalize part if it's not empty and we hit a non-numerical character
			else if (currentPart.isNotEmpty) {
				finalizePart();
			}
		}
	}

	// Add up gear ratios
	for (Day3Gear gear in gears.values) {
		// Skip gear if it isn't adjacent to exactly 2 parts
		if (gear.adjacentParts.length != 2) {
			continue;
		}

		result += gear.adjacentParts.first.value * gear.adjacentParts.last.value;
	}

	return result;

	// return gears
	// 	.values
	// 	.where((g) => g.adjacentParts.length == 2)
	// 	.map((g) => g.adjacentParts.map((p) => p.value).fold(1, (a, b) => a * b))
	// 	.fold(0, (a, b) => a + b);
}
