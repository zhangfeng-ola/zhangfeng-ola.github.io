import fs from "fs";
import path from "path";
import {
  removePrefixSlash,
  removeFilePathExtension,
  replaceNumber,
} from "./utils/utils";

// Remove all generated files, first job in the main function
function removeAllGeneratedFiles(directoryPath: string) {
  try {
    const files = fs.readdirSync(directoryPath);
    // Loop through the files
    files.forEach((file) => {
      const filePath = path.join(directoryPath, file);
      if (fs.statSync(filePath).isDirectory()) {
        removeAllGeneratedFiles(filePath);
        return;
      }

      // Delete file
      fs.unlink(filePath, (err) => {
        if (err) {
          console.error("Error deleting file:", err);
          return;
        }
        console.log("File deleted:", filePath);
      });
    });
  } catch (err) {
    if (err) {
      console.error("Error reading directory:", err);
      return;
    }
  }
}

// Convert the xterm2 theme js to dart
function convertJsToDart(jsObject, filePath: string, fileName: string) {
  const dartContent = `import 'package:flutter/material.dart';
import 'package:xterm/ui.dart';
import './../../../terminal_theme_item.dart';

const TerminalThemeItem ${replaceNumber(fileName)}Theme = TerminalThemeItem(
  name: "${replaceNumber(fileName)}Theme",
  theme: TerminalTheme(
    cursor: Color(0XFF${jsObject.cursor.substring(1)}),
    selection: Color(0XFF${jsObject.cursor.substring(1)}),
    foreground: Color(0XFF${jsObject.foreground.substring(1)}),
    background: Color(0XFF${jsObject.background.substring(1)}),
    black: Color(0XFF${jsObject.black.substring(1)}),
    brightBlack: Color(0XFF${jsObject.brightBlack.substring(1)}),
    red: Color(0XFF${jsObject.red.substring(1)}),
    brightRed: Color(0XFF${jsObject.brightRed.substring(1)}),
    green: Color(0XFF${jsObject.green.substring(1)}),
    brightGreen: Color(0XFF${jsObject.brightGreen.substring(1)}),
    yellow: Color(0XFF${jsObject.yellow.substring(1)}),
    brightYellow: Color(0XFF${jsObject.brightYellow.substring(1)}),
    blue: Color(0XFF${jsObject.blue.substring(1)}),
    brightBlue: Color(0XFF${jsObject.brightBlue.substring(1)}),
    magenta: Color(0XFF${jsObject.magenta.substring(1)}),
    brightMagenta: Color(0XFF${jsObject.brightMagenta.substring(1)}),
    cyan: Color(0XFF${jsObject.cyan.substring(1)}),
    brightCyan: Color(0XFF${jsObject.brightCyan.substring(1)}),
    white: Color(0XFF${jsObject.white.substring(1)}),
    brightWhite: Color(0XFF${jsObject.brightWhite.substring(1)}),
    searchHitBackground: Color(0XFF${jsObject.background.substring(1)}),
    searchHitBackgroundCurrent: Color(0XFF${jsObject.foreground.substring(1)}),
    searchHitForeground: Color(0XFF${jsObject.black.substring(1)}),
));
`;

  fs.writeFileSync(filePath, dartContent);
  console.log("File created:", filePath);
}

// Recursive function to get files
function getFiles(dir: string, files: string[] = []) {
  // Get an array of all files and directories in the passed directory using fs.readdirSync
  const fileList = fs.readdirSync(dir);
  // Create the full path of the file/directory by concatenating the passed directory and file/directory name
  for (const file of fileList) {
    const name = `${dir}/${file}`;
    // Check if the current file/directory is a directory using fs.statSync
    if (fs.statSync(name).isDirectory()) {
      // If it is a directory, recursively call the getFiles function with the directory path and the files array
      getFiles(name, files);
    } else {
      // If it is a file, push the full path to the files array
      files.push(name);
    }
  }
  return files;
}

function generateLibraryExportDart(
  directoryPath: string,
  dartFilename: string
) {
  let dartContent = `library theme;\n`;
  const files = fs.readdirSync(directoryPath);
  // Create the full path of the file/directory by concatenating the passed directory and file/directory name
  // Loop through the files
  files.forEach((file) => {
    const filePath = path.join("./themes", file);
    dartContent += `export "./${filePath}";\n`;
  });
  dartContent += `export "./theme_list.dart";`
  fs.writeFileSync(dartFilename, dartContent);
  console.log("File created:", dartFilename);
}

// Generate the ./generated/theme_list.dart
function generateLibraryListDart(directoryPath: string, dartFilename: string) {
  let dartContent = `import 'package:xterm/ui.dart';
import './../../terminal_theme_item.dart';\n\n`;
  const files = fs.readdirSync(directoryPath);
  // Create the full path of the file/directory by concatenating the passed directory and file/directory name
  // Loop through the files
  files.forEach((file) => {
    const filePath = path.join("./themes", file);
    dartContent += `import "./${filePath}";\n`;
  });
  const themeNames: string[] = files.map(
    (item) => `\n${replaceNumber(removeFilePathExtension(item))}Theme`
  );

  dartContent += `\nconst List<TerminalThemeItem> generatedThemes = [${themeNames.toString()}];`;
  fs.writeFileSync(dartFilename, dartContent);
  console.log("File created:", dartFilename);
}

async function main() {
  removeAllGeneratedFiles("./generated");
  const themeFiles = getFiles("./source");

  for (let themeFile of themeFiles) {
    const theme = (await import(themeFile)).default;
    const fileName = removePrefixSlash(removeFilePathExtension(themeFile));
    const filePath = `./generated/themes/${fileName}.dart`;

    convertJsToDart(theme, filePath, fileName);
  }
  generateLibraryListDart("./generated/themes", "./generated/theme_list.dart");
  generateLibraryExportDart("./generated/themes", "./generated/theme.dart");
}

main();
