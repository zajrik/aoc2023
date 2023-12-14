part of aoc;

@Solution(day: 4, part: 1)
int day4part1(List<String> input) {
	int result = 0;

	final RegExp numberRegex = RegExp(r'\d+');

	// Process each card
	for (String line in input) {
		// Get the winning and revealed number strings
		final [_, numbers] = line.split(':').toList();
		final [winning, revealed] = numbers.split('|').toList();

		// Parse winning numbers
		final List<int> winningNumbers = numberRegex
			.allMatches(winning)
			.map((e) => int.parse(e[0]!))
			.toList();

		// Parse revealed numbers
		final List<int> revealedNumbers = numberRegex
			.allMatches(revealed)
			.map((e) => int.parse(e[0]!))
			.toList();

		int cardValue = 0;

		// Calculate card value
		for (int number in winningNumbers) {
			if (revealedNumbers.contains(number)) {
				cardValue = cardValue == 0 ? 1 : cardValue * 2;
			}
		}

		// Add card value to result
		result += cardValue;
	}

	return result;
}
