part of aoc;

/// Represents the input data type for a solution. Determined by the type of the
/// input parameter of the solution function.
///
/// - If String is used, the raw text of the input will be provided.
/// - If List<String> is used, the input will be split into lines.
/// - If List<List<String>> is used, the input will be split into a 2-dimensional
///   array of single-character strings.
enum InputType {
	raw,
	lines,
	chars
}
