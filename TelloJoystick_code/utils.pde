String osType() {
  String os = System.getProperty("os.name");
  if (os.contains("Windows")) {
    // os-specific setup and config here
    return "win";
  } else if (os.contains("Mac")) {
    // ...
    return "mac";
  } else if (os.contains("Linux")) {
    // ...
    return "linux";
  } else {
    // ...
    return "other";
  }
}
