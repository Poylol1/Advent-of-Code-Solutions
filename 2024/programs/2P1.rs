use std::error::Error;
use std::fs;

fn main() -> Result<(), Box<dyn Error>> {
    let mut result = Vec::new();

    // Gets the lines of the thingy even though I pretty sure the
    // docs adviced against this
    for line in fs::read_to_string("../inputs/2P1").unwrap().lines() {
        result.push(line.to_string());
    }
    let len = result.iter().count();
    let mut acc = 0;
    for i in 0..len {
        let line: Vec<&str> = result[i].split(" ").collect();
        acc = acc + is_safe(line);
    }
    println!("{}", acc);
    Ok(())
}
fn is_safe(l: Vec<&str>) -> i32 {
    // The length of the vector of numbers
    // No more wrappers!!
    let int: Vec<i32> = l.iter().map(|&s| s.parse().unwrap()).collect();

    let le = int.iter().count();
    let d: bool;
    let first: i32 = int[0];
    let second: i32 = int[1];
    if first > second {
        d = true;
    } else if first < second {
        d = false;
    } else {
        return 0;
    }

    let mut max: i32 = int[0];

    for j in 0..(le - 1) {
        let i: i32 = int[j];
        let f: i32 = int[j + 1];

        if (i - f).abs() > 3 {
            println!("{:?}", int);
            println!("{}", i - f);
            return 0;
        }

        if (d && max <= f) || (!d && max >= f) {
            println!("{:?}", int);
            return 0;
        }
        max = f;
    }
    //println!("{:?}", int);
    return 1;
}
//
//  fn(line)
//  let no = line.split(" ");
//  for i of no.len - 2
//    if abs(no[i] - no[i +2]) > 3
//     return 0
//  return 1
//
// acc = 0
// for l in file
//  acc += fn(l)
// return acc
