List<String> getImages(List<dynamic> images) {
  List<String> urls = [];

  RegExp exp = RegExp(r'https?://[^\\]+');

  for (var inputString in images) {
    Iterable<Match> matches = exp.allMatches(inputString);
    for (Match match in matches) {
      String url = match.group(0)!;
      urls.add(
          url.replaceAll(RegExp(r'[\[\]"]'), '')); // Remove brackets and quotes
    }
  }
  return urls;
}
