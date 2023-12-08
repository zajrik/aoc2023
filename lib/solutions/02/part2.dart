part of aoc;

@Solution(day: 2, part: 2)
int day2part2(List<String> input) {
	int result = 0;

	for (String line in input) {
		final [_, ...pulls] = line
			.split(RegExp('[:;]'))
			.map((v) => v.trim())
			.toList();

		var (minRed, minGreen, minBlue) = (0, 0, 0);

		// Check all pulls for this game
		for (String pull in pulls) {
			// Parse cube sets from this pull
			final List<(int, String)> cubes = pull.split(', ').map((v) {
				final List<String> cubeSet = v.split(' ');
				return (int.parse(cubeSet[0]), cubeSet[1]);
			}).toList();

			// Find the highest value for each color in this pull
			for ((int, String) cubeSet in cubes) {
				switch (cubeSet) {
					case (int red, 'red') when red > minRed: minRed = red;
					case (int green, 'green') when green > minGreen: minGreen = green;
					case (int blue, 'blue') when blue > minBlue: minBlue = blue;
				}
			}
		}

		// Add game power to result
		result += (minRed * minGreen * minBlue);
	}

	return result;
}
