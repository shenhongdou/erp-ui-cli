#!/usr/bin/env node
const yargs = require("yargs");
const path = require("path");
const { inquirerPrompt } = require("./inquirer.ts");
const {
  copyDir,
  checkMkdirExists,
  copyFile,
  copyTemplate,
} = require("./copy.ts");

yargs.command(
  ["create", "c"],
  "创建项目",
  (yargs) => {
    return yargs.option("template", {
      alias: "t",
      describe: "生成模板文件",
      type: "string",
      demand: true,
    });
  },
  (argv) => {
    inquirerPrompt(argv)
      .then((answers) => {
        const { filePath, filename, type, ext } = answers;
        /**
         * process.cwd() 当前 Node.js 进程执行时的文件所属目录的绝对路径。
         */
        /**
         * __dirname 是用来动态获取当前文件模块所属目录的绝对路径。
         * 比如在 bin/index.js 文件中使用 __dirname ，
         * __dirname 表示就是 bin/index.js 文件所属目录的绝对路径 C:\Users\shenh\Desktop\demo-project\monorepo-cli\packages\shd-cli\bin\index.ts
         */

        const isMkdirExists = checkMkdirExists(
          path.resolve(process.cwd(), filePath, `${filename}${ext}`)
        );
        if (isMkdirExists) {
          console.log(`${filePath}文件已经存在`);
        } else {
          copyTemplate(
            path.resolve(__dirname, `./template/${type}/index.tpl`),
            path.resolve(process.cwd(), filePath, `${filename}${ext}`),
            {
              name: filename,
            }
          );
        }
      })
      .catch((err) => console.log(err));
  }
).argv;
