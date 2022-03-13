class Doc {
  Map<int, String> lines = {};

  addLines(String paragrapgh) {
    RegExp regExp = RegExp(r"([^.!?]+[.!?])");
    Iterable<Match> matches = regExp.allMatches(paragrapgh);
    int i = 0;
    for (Match m in matches) {
      lines[++i] = m.group(0)!;
    }
    for (var lineEntry in lines.entries) {
      lines[lineEntry.key] = lineEntry.value.replaceAll('\n', ' ').trim();
    }
  }

  void clear() => lines = {};
}
