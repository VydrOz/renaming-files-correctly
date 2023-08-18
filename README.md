# Table of Contents
- [📖 Context](#-context)
  - [v1](#v1)
  - [v2](#v2)
- [💡 Informations](#-informations)
- [🖥️ Preview](#️-preview)
  - [v1 - Result](#v1---result)
  - [v2 - Steps](#v2---steps)


## 📖 Context

### v1
Following a personal request from a family member. I wrote a script to rename files (type defined in, e.g. "`.txt`") by removing special characters from a predefined list and replacing spaces with an underscore.

### v2
The original request has evolved, I now need to export files in a csv table to rename them manually.

## 💡 Informations

The script takes only files from where is it. You must place it on the same path as the files to be renamed.

## 🖥️ Preview

Considering this tree :
```
📂 Desktop/
├─ 📂 Memes/
│  └─ 📹 RickRoll.wav
├─ 📂 TestFolder/
│  ├─ 📂 1/
│  │  └─ 📄 text file.txt
│  ├─ 📜 .ExportFilesToCsv.ps1
│  ├─ 📜 .RenameCorrectlyFiles.ps1
│  ├─ 📜 .RenameCorrectlyFilesToCsv.ps1
│  ├─ 📄 another #   test  file----  .txt
│  ├─ 📄 a test     file      .txt
│  ├─ 📄 one       more $ .txt
│  ├─ 📄 Ze last [test file].txt
│  └─ 🖼️ 2022-02-14-00042354.png
├─ 📂 UwU/
│  └─ 📄 Cat tier list.txt  
```

### v1 - Result

1. `.RenamingFilesCorrectly.ps1`

    ![image](https://github.com/VydrOz/renaming-files-correctly/assets/61025448/6efcaf25-5644-4fb4-8fbf-8fa98d3961dc)

### v2 - Steps
1. `.ExportFilesToCsv.ps1`

    ![image](https://github.com/VydrOz/renaming-files-correctly/assets/61025448/acc5c1d5-38a0-4684-825b-96d82c6ca6cf)

    ... wich creates the file `Files_To_Rename.csv`
    <table>
        <tr>
            <td>
                Notepad
            </td>
            <td>
                Excel
            </td>
        </tr>
        <tr>
            <td>

    ```excel
    "Actual file name";"New file name"
    "a test     file      .txt";""
    "another #   test  file----  .txt";""
    "one       more $ .txt";""
    "Ze last [test file].txt";""
    ```
    </td>
    <td>

    | Actual file name | New file name |
    |---|---|
    | a test     file      .txt | |
    | another #   test  file----  .txt | |
    | one       more $ .txt | |
    | Ze last [test file].txt | |
    </td>
    </tr>
    </table>

2. Modify csv with custom names

    <table>
        <tr>
            <td>
                Notepad
            </td>
            <td>
                Excel
            </td>
        </tr>
        <tr>
            <td>

    ```excel
    "Actual file name";"New file name"
    "a test     file      .txt";"test_file.txt"
    "another #   test  file----  .txt";"another_file.txt"
    "one       more $ .txt";"oneMore.txt"
    "Ze last [test file].txt";"TheLastTestFile.txt"
    ```
    </td>
    <td>

    | Actual file name | New file name |
    |---|---|
    | a test     file      .txt | test_file.txt |
    | another #   test  file----  .txt | another_file.txt |
    | one       more $ .txt | oneMore.txt |
    | Ze last [test file].txt | TheLastTestFile.txt |
    </td>
    </tr>
    </table>


3. `.RenamingFilesFromCsv.ps1`

    ![image](https://github.com/VydrOz/renaming-files-correctly/assets/61025448/252f30c5-39f1-4c1d-a4ff-ddba58b6318e)
