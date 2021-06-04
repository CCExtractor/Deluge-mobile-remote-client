class magnet_detect {
  static bool parse(String url) {
    if (url.contains("magnet:?") && url.contains(".torrent")) {
      return true;
    } else {
      return false;
    }
  }
}
