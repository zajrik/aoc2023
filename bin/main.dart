import 'package:aoc2023/aoc.dart';
import 'dart:mirrors';
import 'dart:io';

void main(List<String> arguments) async {
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

			MethodMirror solution = solutions[day]![part]!;

			// Determine type of solution input parameter
			InputType inputType = switch (solution.parameters.first.type.reflectedType) {
				var type when type == (String) => InputType.raw,
				var type when type == (List<String>) => InputType.lines,
				_ => throw UnsupportedError('Invalid solution input type')
			};

			// Load input file contents
			File inputFile = File(scriptPath.joinWithPath('input/$day/input.txt'));
			String inputContents = await inputFile.readAsString();

			// Prepare input based on input parameter type
			List<dynamic> input = [
				switch (inputType) {
					InputType.raw => inputContents,
					InputType.lines => inputContents
						.trim()
						.replaceAll('\r\n', '\n')
						.split('\n')
				}
			];

			// Execute solution
			int result = aoc.invoke(solution.simpleName, input).reflectee;

			// Skip printing unimplemented solutions
			if (result == 0) {
				continue;
			}

			print('Day $day, part $part: $result');
		}
	}
}
