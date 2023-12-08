part of aoc;

@Solution(day: 3, part: 2)
int day3part2(String input) {
	int result = 0;

	/// Plan: copy over part finding from part 1, when finalizing part, search for adjacent gear.
	/// If found, cache gear and associate part with it. If gear already is already cached for that
	/// location, associate part with existing gear. Filter for gears with two associated parts.
	///
	/// Cache gears in map keyed by 'x:y' for easy lookup of existing gears and then filter on map.values

	return result;
}
