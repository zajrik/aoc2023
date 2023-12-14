part of aoc;

@Solution(day: 4, part: 2)
int day4part2(List<String> input) {
	int result = 0;

	final RegExp numberRegex = RegExp(r'\d+');

	// Find the number of wins on each card
	final Map<int, int> cardWins = Map.fromIterable(
		List.generate(input.length, (i) => i),
		value: (i) {
			// Get the winning and revealed number strings
			final [_, numbers] = input[i].split(':').toList();
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

			int winCount = 0;

			// Calculate wins
			for (int number in winningNumbers) {
				if (revealedNumbers.contains(number)) {
					winCount++;
				}
			}

			return winCount;
		}
	);

	// Prepare map to track card copies
	final Map<int, int> copies = Map.fromIterable(
		List.generate(input.length, (i) => i),
		value: (_) => 1
	);

	// Process each card
	for (int i = 0; i < input.length; i++) {
		// Process each copy of current card
		for (int j = 0; j < copies[i]!; j++) {
			final int winCount = cardWins[i]!;

			// Add won copies to copies map
			for (int k = i + 1; k < i + winCount + 1; k++) {
				copies[k] = copies[k]! + 1;
			}
		}
	}

	// Add card copy counts to result
	for (int count in copies.values) {
		result += count;
	}

	return result;
}
