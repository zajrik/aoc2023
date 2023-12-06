part of aoc;

class SolutionRunner {
	/// Runs all Advent of Code solutions and prints their results.
	static Future<void> runSolutions() async {
		final String scriptPath = Platform.script.directory.path;
		final MirrorSystem mirrorSystem = currentMirrorSystem();
		final LibraryMirror aoc = mirrorSystem.findLibrary(#aoc);

		// Prepare solutions map
		final List<int> days = List.generate(25, (i) => i + 1);
		final Map<int, Map<int, MethodMirror>> solutions = Map.fromIterable(
			days,
			value: (_) => {}
		);

		// Gather all solutions
		for (DeclarationMirror declaration in aoc.declarations.values) {
			// Skip declarations that are not decorated as solutions
			if (declaration.metadata.isEmpty || declaration.metadata.first.reflectee is! Solution) {
				continue;
			}

			final Solution solution = declaration.metadata.first.reflectee;
			solutions[solution.day]![solution.part] = declaration as MethodMirror;
		}

		// Execute solutions
		for (int day in days) {
			for (int part in [1, 2]) {
				// Skip solutions that don't exist yet
				if (!solutions[day]!.containsKey(part)) {
					continue;
				}

				final MethodMirror solution = solutions[day]![part]!;

				// Determine type of solution input parameter
				final InputType inputType = switch (solution.parameters.first.type.reflectedType) {
					const (String) => InputType.raw,
					const (List<String>) => InputType.lines,
					_ => throw UnsupportedError('Invalid solution input type')
				};

				// Load input file contents for the current day
				final String inputPath = 'input/${day.toString().padLeft(2, '0')}/input.txt';
				final File inputFile = File(scriptPath.joinWithPath(inputPath));
				final String inputContents = (await inputFile.readAsString())
					.trim()
					.replaceAll('\r\n', '\n');

				// Prepare input based on input parameter type
				final List<dynamic> input = [
					switch (inputType) {
						InputType.raw => inputContents,
						InputType.lines => inputContents.split('\n')
					}
				];

				// Execute solution
				final int result = aoc.invoke(solution.simpleName, input).reflectee;

				// Skip printing unimplemented solutions
				if (result == 0) {
					continue;
				}

				print('Day $day, part $part: $result');
			}
		}
	}
}
