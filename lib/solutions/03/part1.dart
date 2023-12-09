part of aoc;

/// Represents a part number in the day 3 input schematics
class Day3PartNumber {
	final int x;
	final int y;
	final int len;
	final int value;

	const Day3PartNumber({
		required this.x,
		required this.y,
		required this.len,
		required this.value
	});
}

@Solution(day: 3, part: 1)
int day3part1(List<List<String>> input) {
	int result = 0;

	String currentPart = '';
	int partX = 0;
	int partY = 0;

	final RegExp numerical = RegExp(r'\d');
	final RegExp symbol = RegExp(r'[^\d\.]');

	final List<Day3PartNumber> parts = [];
	final List<Day3PartNumber> validParts = [];

	// Add the current part number to the parts list and reset tracking
	void finalizePart() {
		parts.add(
			Day3PartNumber(
				x: partX,
				y: partY,
				len: currentPart.length,
				value: int.parse(currentPart)
			)
		);

		// Reset tracking
		currentPart = '';
		partX = 0;
		partY = 0;
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

	// Find all valid parts
	for (Day3PartNumber part in parts) {
		final int xStart = max(0, part.x - 1);
		final int xEnd = min(input.length - 1, part.x + 1);

		final int yStart = max(0, part.y - 1);
		final int yEnd = min(input[part.x].length - 1, part.y + part.len);

		partCheck: for (int x = xStart; x <= xEnd; x++) {
			for (int y = yStart; y <= yEnd; y++) {
				if (symbol.hasMatch(input[x][y])) {
					validParts.add(part);
					break partCheck;
				}
			}
		}
	}

	// Add all valid part number values to the result
	for (Day3PartNumber part in validParts) {
		result += part.value;
	}

	return result;

	// return validParts
	// 	.map((p) => p.value)
	// 	.fold(0, (a, b) => a + b);
}
