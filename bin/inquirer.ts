const inquirer = require("inquirer");

function inquirerPrompt(argv) {
  const { filename, filePath } = argv;
  return new Promise((resolve, reject) => {
    inquirer
      .prompt([
        {
          type: "list",
          name: "type",
          message: "请选择模板类型",
          choices: ["Form表单页", "Modal模板"],
          filter: (value) => {
            return {
              Form表单页: "form",
              Modal模板: "modal",
            }[value];
          },
        },
        {
          type: "input",
          name: "filePath",
          message: "请输文件所在文件夹路径(相对于项目根目录的dirname)",
          default: filePath,
          // validate: (val) => {
          //   if (!/^[a-zA-Z]+$/.test(val)) {
          //     return "模板名称只能含有英文";
          //   }

          //   return true;
          // },
        },
        {
          type: "input",
          name: "filename",
          message: "请输文件名(filename)",
          default: filename,
        },
        {
          type: "list",
          name: "ext",
          message: "请选择文件后缀",
          choices: [".tsx", ".js"],
        },
      ])
      .then((answers) => {
        // 返回用户输入的项目名称
        resolve(answers);
      })
      .catch((error) => {
        reject(error);
      });
  });
}

exports.inquirerPrompt = inquirerPrompt;
