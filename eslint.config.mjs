import { dirname } from "path";
import { fileURLToPath } from "url";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

const eslintConfig = [
  ...compat.extends("next/core-web-vitals", "next/typescript"),
  {
    // 忽略自动生成的文件
    ignores: ["**/generated/**/*", "**/node_modules/**", "**/.next/**"],
  },
  {
    // 为项目中的所有文件设置规则
    files: ["**/*.js", "**/*.ts", "**/*.tsx"],
    rules: {
      // 关闭一些在生成代码中经常出现的规则
      "@typescript-eslint/no-unused-expressions": "warn", // 降级为警告
      "@typescript-eslint/no-this-alias": "warn", // 降级为警告
      "@typescript-eslint/no-unused-vars": "warn", // 降级为警告
      "@typescript-eslint/no-require-imports": "warn", // 降级为警告
    },
  },
];

export default eslintConfig;
