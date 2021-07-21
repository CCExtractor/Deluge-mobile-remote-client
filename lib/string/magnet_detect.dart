class magnet_detect {
  static bool parse(String url) {
    if (url.contains("magnet:?")) {
      return true;
    } else {
      return false;
    }
  }
}
