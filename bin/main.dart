import 'dart:io';

import 'package:args/args.dart';
import 'package:aoc2023/aoc.dart';

void main(List<String> arguments) async {
	final ArgParser argParser = ArgParser();

	argParser.addOption(
		'days',
		abbr: 'd',
		defaultsTo: '1-25',
	);

	final String daysArg = argParser.parse(arguments)['days'];

	final RegExp commaDays = RegExp(r'\d+(?:,\d+)*');
	final RegExp hyphenDays = RegExp(r'\d+-\d+');

	final List<int> daysToRun = [];

	// Handle comma-separated days
	if (commaDays.hasMatch(daysArg)) {
		daysToRun.addAll(daysArg.split(',').map(int.parse));
	}

	// Handle range of days
	else if (hyphenDays.hasMatch(daysArg)) {
		final List<int> dayRange = daysArg
			.split('-')
			.map(int.parse)
			.toList()
			..sort();

		final [start, end] = dayRange;

		for (int i = start; i <= end; i++) {
			daysToRun.add(i);
		}
	}

	// Handle invalid days
	else {
		print(
			'Please enter a valid set or range of days for which to execute solutions.\n'
			'For example: "5,10,11" or "3-17"'
		);

		exit(0);
	}

	SolutionRunner.runSolutions(daysToRun);
}
