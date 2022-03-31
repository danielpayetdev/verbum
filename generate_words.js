const fs = require('fs');

const allWords = fs.readFileSync('mots.txt');

const words = allWords.toString()
  .normalize("NFD").replace(/\p{Diacritic}/gu, "")
  .split("\n")
  .map(word => word.trim().toUpperCase())
  .filter(word =>
    word != '' &&
    word.length >= 5 &&
    word.length <= 10 &&
    !word.includes(" ") &&
    !word.includes("-") &&
    !word.includes("!") &&
    !word.startsWith("K") &&
    !word.startsWith("Q") &&
    !word.startsWith("W") &&
    !word.startsWith("X") &&
    !word.startsWith("Y") &&
    !word.startsWith("Z") &&
    !word.endsWith("Z")
  )
  .filter(s => s != '')
  .filter(s => s.length >= 6)
  .filter(s => s.length <= 9);

fs.writeFileSync("functions/src/words.ts", "export const wordsLength = " + words.length + ";\nexport const words = " + JSON.stringify(words)) + ";";
