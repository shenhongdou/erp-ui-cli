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
          choices: ["Form表单页", "Modal模板", "Table列表页", "ProTable列表页"],
          filter: (value) => {
            return {
              Form表单页: "form",
              Modal模板: "modal",
              Table列表页: "table",
              ProTable列表页: "pro-table",
            }[value];
          },
        },
        {
          type: "input",
          name: "filePath",
          message: "请输文件所在文件夹路径(相对于项目根目录的dirname)",
          default: filePath,
        },
        {
          type: "input",
          name: "filename",
          message: "请输文件名(filename)",
          default: filename,
          validate: (val) => {
            if (!/^[a-zA-Z-]+$/.test(val)) {
              return "文件名称只能含有英文和中划线";
            }

            return true;
          },
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

module.exports = {
  inquirerPrompt,
};
