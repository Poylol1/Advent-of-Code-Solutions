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
        acc = acc + is_safe(line, false);
    }
    println!("{}", acc);
    Ok(())
}
fn is_safe(l: Vec<&str>, used: bool) -> i32 {
    // The length of the vector of numbers
    // No more wrappers!!
    //Totally stupid solution
    let mut cop: Vec<&str> = l.clone();
    let mut cop1: Vec<&str> = l.clone();
    let mut cop2: Vec<&str> = l.clone();
    let int: Vec<i32> = l.iter().map(|&s| s.parse().unwrap()).collect();
    println!("{:?}", int);
    let le = int.iter().count();
    let d: bool;
    let first: i32 = int[0];
    let second: i32 = int[1];
    if first > second {
        d = true;
    } else if first < second {
        d = false;
    } else {
        // This section feels alright.
        if !used {
            cop.remove(0);
            cop1.remove(1);
            if is_safe(cop, true) == 1 {
                return 1;
            }
            if is_safe(cop1, true) == 1 {
                return 1;
            }
            return 0;
        }
        return 0;
    }

    let mut max: i32 = int[0];
    let mut plusultra: bool = false;
    for j in 0..(le - 1) {
        if j > 0 {
            plusultra = true;
        }
        let i: i32 = int[j];
        let f: i32 = int[j + 1];

        if (i - f).abs() > 3 {
            if !used {
                cop1.remove(j);
                cop.remove(j + 1);
                if plusultra {
                    cop2.remove(j - 1);
                    if is_safe(cop2, true) == 1 {
                        return 1;
                    }
                }
                if is_safe(cop, true) == 1 {
                    return 1;
                }
                if is_safe(cop1, true) == 1 {
                    return 1;
                }
                return 0;
            }
            return 0;
        }

        if (d && max <= f) || (!d && max >= f) {
            if !used {
                cop1.remove(j);
                cop.remove(j + 1);
                if plusultra {
                    cop2.remove(j - 1);
                    if is_safe(cop2, true) == 1 {
                        return 1;
                    }
                }
                if is_safe(cop, true) == 1 {
                    return 1;
                }
                if is_safe(cop1, true) == 1 {
                    return 1;
                }
                return 0;
            }
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
