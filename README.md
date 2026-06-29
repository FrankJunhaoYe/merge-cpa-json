# merge-cpa-json

A small PowerShell utility that recursively merges CPA-style JSON files into a single `all.json` array.

## Features

- Recursively scans the script directory for input `.json` files.
- Excludes any file named `all.json` so generated output is not merged back into itself.
- Parses all input files before writing output, avoiding partial output after a parse failure.
- Writes the merged result as a top-level JSON array.
- Keeps each input file as one top-level array entry, even when an input file itself contains an array.
- Prints only a safe summary with the merged file count and output path.

## Requirements

- Windows PowerShell 5.1 or PowerShell 7+.
- Read access to the folders that contain the input JSON files.
- Write access to the folder that contains `merge-cpa-json.ps1`.

## Usage

Place `merge-cpa-json.ps1` in the root folder that contains your JSON files, then run:

```powershell
.\merge-cpa-json.ps1
```

The script writes `all.json` next to `merge-cpa-json.ps1` and overwrites the previous generated `all.json` on each successful run.

## Input structure

Use folders like this with your own JSON files:

```text
sample-cpa-folder/
├── merge-cpa-json.ps1
├── region-a/
│   └── account-alpha.json
└── region-b/
    └── account-beta.json
```

Synthetic example input file:

```json
{
  "accountName": "example-account-alpha",
  "region": "example-region",
  "status": "active"
}
```

## Output structure

The generated `all.json` is a JSON array. Each input file becomes one item:

```json
[
  {
    "accountName": "example-account-alpha",
    "region": "example-region",
    "status": "active"
  },
  {
    "accountName": "example-account-beta",
    "region": "example-region",
    "status": "inactive"
  }
]
```

## Safety notes

- Do not commit real CPA account JSON files, tokens, credentials, or generated `all.json` output.
- This repository intentionally ignores `*.json` and `all.json`.
- Review `git status` and `git ls-files` before publishing changes.
- The script does not print JSON contents to the terminal; it only prints a merge summary.

## License

MIT License. See [LICENSE](LICENSE).

---

# merge-cpa-json（中文）

一个小型 PowerShell 工具，用于递归合并 CPA 风格的 JSON 文件，并生成单个数组形式的 `all.json`。

## 项目简介

`merge-cpa-json.ps1` 会从脚本所在目录开始递归查找 JSON 文件，读取并解析每个输入文件，然后把结果写入根目录下的 `all.json`。

## 功能特性

- 递归扫描脚本目录下的输入 `.json` 文件。
- 排除所有名为 `all.json` 的文件，避免把生成结果再次合并进去。
- 先解析全部输入文件，再写入输出文件，避免解析失败时生成不完整结果。
- 输出结果始终是顶层 JSON 数组。
- 每个输入文件对应输出数组中的一个元素；即使某个输入文件本身是数组，也不会被展开。
- 终端只输出安全摘要：合并数量和输出路径，不打印 JSON 内容。

## 环境要求

- Windows PowerShell 5.1 或 PowerShell 7+。
- 对输入 JSON 文件所在目录有读取权限。
- 对 `merge-cpa-json.ps1` 所在目录有写入权限。

## 使用方法

把 `merge-cpa-json.ps1` 放在包含 JSON 文件的根目录，然后运行：

```powershell
.\merge-cpa-json.ps1
```

脚本会在 `merge-cpa-json.ps1` 旁边生成 `all.json`，并在每次成功运行时覆盖旧的生成文件。

## 输入结构

可以使用类似下面的目录结构，并替换成你自己的 JSON 文件：

```text
sample-cpa-folder/
├── merge-cpa-json.ps1
├── region-a/
│   └── account-alpha.json
└── region-b/
    └── account-beta.json
```

合成示例输入文件：

```json
{
  "accountName": "example-account-alpha",
  "region": "example-region",
  "status": "active"
}
```

## 输出结构

生成的 `all.json` 是 JSON 数组。每个输入文件会成为数组中的一个元素：

```json
[
  {
    "accountName": "example-account-alpha",
    "region": "example-region",
    "status": "active"
  },
  {
    "accountName": "example-account-beta",
    "region": "example-region",
    "status": "inactive"
  }
]
```

## 安全提示

- 不要提交真实 CPA 账号 JSON 文件、令牌、凭据或生成的 `all.json`。
- 本仓库会有意忽略 `*.json` 和 `all.json`。
- 发布前请检查 `git status` 和 `git ls-files`。
- 脚本不会在终端打印 JSON 内容，只会打印合并摘要。

## 开源协议

MIT License。详见 [LICENSE](LICENSE)。
