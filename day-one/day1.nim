import std/strutils
import std/tables
import std/lists

let numbers = {"one":1, "two": 2, "three":3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}.newTable

proc calibrate_values_part_one(file_path: string): void =
    let f: File = open(file_path)
    let file_lines: string = readAll(f)
    var totaL_value: int = 0
    var value:int

    for line in file_lines.splitLines():
        var v: string = ""
        var new_v: string = ""
        echo line

        for i in countup(0, line.len-1):
            if isDigit(line[i]):
                v.add(line[i])

        new_v.add(v[0])

        if v.len >= 1:
            new_v.add(v[v.len-1])
        else:
            new_v = "0"

        value = parseInt(new_v)
        total_value += value

    f.close()
    echo total_value


proc calibrate_values_part_two(file_path: string): void =
    let f: File = open(file_path)
    let file_lines: string = readAll(f)
    var totaL_value: int = 0
    var value:int

    for line in file_lines.splitLines():
        var v: string = ""
        var new_v: string = ""

        for i in countup(0, line.len-1):
            var substring_three:string = substr(line, i, i+2)            
            var substring_four:string = substr(line,i, i+3)
            var substring_five:string = substr(line,i, i+4)
            let substrings = [substring_three, substring_four, substring_five]

            for substring in substrings:
                if substring in numbers:
                    v.add($numbers[substring])
            


            if isDigit(line[i]):
                v.add(line[i])


        new_v.add(v[0])

        if v.len >= 1:
            new_v.add(v[v.len-1])
        else:
            new_v = "0"

        value = parseInt(new_v)
        total_value += value

    f.close()
    echo total_value
        
        

calibrate_values_part_two("input2.txt")