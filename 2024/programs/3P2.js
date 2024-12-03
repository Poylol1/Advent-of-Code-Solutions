const fs = require("fs");
const fileContents = fs.readFileSync("../inputs/3P1").toString();

let acc = 0;
let inDont = false;
let i = 0;
do {
  if (inDont && fileContents.substring(i, i + 5).match(/do\(\)/)) {
    inDont = false;
  }
  if (!inDont && fileContents.substring(i, i + 8).match(/don't\(\)/)) {
    inDont = true;
  }
  if (
    !inDont &&
    fileContents.substring(i, i + 12).match(/mul\(\d{1,3}\,\d{1,3}\)/)
  ) {
    let firstNumbersPos = something(/mul\(/, i, 12, 4);
    let secondNumbersPos = something(/\,/, firstNumbersPos, 5, 1);
    let parLength = something(/\)/, secondNumbersPos, 5, 1) - 1;
    let firstNumber = fileContents.substring(
      firstNumbersPos,
      secondNumbersPos - 1,
    );
    let secondNumber = fileContents.substring(secondNumbersPos, parLength);

    console.log(
      `${fileContents.substring(i, parLength + 1)}: ${firstNumber}, ${secondNumber} : ${firstNumber * secondNumber}`,
    );
    acc += firstNumber * secondNumber;
    i = parLength - 4;
    continue;
  }
  i++;
} while (i < fileContents.length);

console.log(acc);

function something(subs, curr, range, lenOfStr) {
  for (let i = curr; i < curr + range; i++) {
    if (fileContents.substring(i, i + lenOfStr).match(subs)) {
      return i + lenOfStr;
    }
  }
}
