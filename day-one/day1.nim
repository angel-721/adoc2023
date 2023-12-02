import std/strutils

let numbers = {"one":1, "two": 2, "three":3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}

proc calibrate_values_part_1(file_path: string): void =
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

        
        

calibrate_values("input2.txt")