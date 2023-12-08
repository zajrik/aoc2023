part of aoc;

@Solution(day: 2, part: 1)
int day2part1(List<String> input) {
	int result = 0;

	for (String line in input) {
		final [game, ...pulls] = line
			.split(RegExp('[:;]'))
			.map((v) => v.trim())
			.toList();

		final int gameId = int.parse(game.split(' ')[1]);

		bool validGame = true;

		// Check all pulls for this game
		for (String pull in pulls) {
			// Parse cube sets from this pull
			final List<(int, String)> cubes = pull.split(', ').map((v) {
				final List<String> cubeSet = v.split(' ');
				return (int.parse(cubeSet[0]), cubeSet[1]);
			}).toList();

			// Determine if any pulled set of cubes is invalid
			for ((int, String) cubeSet in cubes) {
				// End this game if it's invalid
				if (validGame == false) {
					break;
				}

				validGame = switch (cubeSet) {
					(> 12, 'red') => false,
					(> 13, 'green') => false,
					(> 14, 'blue') => false,
					_ => true
				};
			}
		}

		// Add gameId to result if the game was valid
		if (validGame) {
			result += gameId;
		}
	}

	return result;
}
