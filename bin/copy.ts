const copydir = require("copy-dir");
const fs = require("fs");
const Mustache = require("mustache");
const path = require("path");

function mkdirp(dir) {
  if (fs.existsSync(dir)) {
    return true;
  }
  const dirname = path.dirname(dir);
  mkdirp(dirname);
  fs.mkdirSync(dir);
}

function mkdirGuard(target) {
  try {
    fs.mkdirSync(target, { recursive: true });
  } catch (e) {
    // 如果mk dir失败，就先mk parent dir
    mkdirp(target);
  }
}

function copyDir(from, to, options) {
  mkdirGuard(to);
  copydir.sync(from, to, options);
}

function checkMkdirExists(path) {
  console.log(path, "path");
  return fs.existsSync(path);
}

function copyFile(from, to) {
  const buffer = fs.readFileSync(from);
  const parentPath = path.dirname(to);

  mkdirGuard(parentPath);

  fs.writeFileSync(to, buffer);
}

function readTemplate(path, data = {}) {
  const str = fs.readFileSync(path, { encoding: "utf8" });
  return Mustache.render(str, data);
}

function copyTemplate(from, to, data = {}) {
  if (path.extname(from) !== ".tpl") {
    return copyFile(from, to);
  }

  const parentToPath = path.dirname(to);
  mkdirGuard(parentToPath);
  fs.writeFileSync(to, readTemplate(from, data));
}

exports.checkMkdirExists = checkMkdirExists;
exports.copyDir = copyDir;
exports.copyFile = copyFile;
exports.readTemplate = readTemplate;
exports.copyTemplate = copyTemplate;
