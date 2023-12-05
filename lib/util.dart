part of aoc;

extension StringExtension on String
{
	/// Compares this string to another using `compareNatural()`
	int compareNaturallyTo(String other) => compareNatural(this, other);

	/// Returns this string joined with the given path segment strings and normalized
	String joinWithPath(String a, [String? b, String? c, String? d, String? e, String? f, String? g]) =>
		normalize(join(this, a, b, c, d, e, f, g));
}

extension UriExtension on Uri
{
	/// Gets the directory this URI lives in
	Directory get directory => Directory(dirname(toFilePath()));
}
