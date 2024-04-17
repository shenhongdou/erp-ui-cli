const getCompNameFromFilename = (filename) => {
  if (typeof filename !== "string") return filename;

  if (/^([a-zA-Z]+-)\1*/.test(filename)) {
    return filename
      .split("-")
      .map((item) => item.charAt(0).toUpperCase() + item.slice(1))
      .join("");
  }

  return filename.charAt(0).toUpperCase() + filename.slice(1);
};

module.exports = {
  getCompNameFromFilename,
};
