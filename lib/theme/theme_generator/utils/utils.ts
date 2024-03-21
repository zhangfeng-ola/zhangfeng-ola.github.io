export function removePrefixSlash(filepath: string) {
    return filepath.replace(/^.*[\\\/]/, "");
}

export function removeFilePathExtension(filepath: string) {
    return filepath.replace(/\.[^/.]+$/, "");
}

/// Dart does not support numbering variable, so we replace with X instead
export function replaceNumber(input: string): string {
    function replaceWithEnglishChar(match) {
      const digitMap = [
        "Zero",
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
      ];
      const digit = parseInt(match);
      if (digit < 0 || digit > 9) {
        return match; // Return original match if digit is not within 0-9 range
      }
      return digitMap[digit];
    }
    return input.replace(/\d/g, replaceWithEnglishChar);
  }
