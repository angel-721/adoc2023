import std/strutils
import std/tables
import sequtils

let allowed_numbers = {"red": 12, "green": 13, "blue": 14}.newTable 

proc is_possible_game_part_one(file_path: string): void =
    let f: File = open(file_path)
    let file_lines: string = readAll(f)
    var ids_combined:int = 0
    var id:int = 0
    var line_array: seq[string]
    var word: string
    var line_is_good:bool
    var count:int

    for line in file_lines.splitLines():
        line_is_good = true
        echo line
        line_array = line.split(" ")
        id = parseInt(line_array[1].substr(0, line_array[1].len-2))
        echo id

        var color_numbers = {"red": 0, "green": 0, "blue": 0}.newTable 
        for i in countup(0, line_array.len-1):
            word = line_array[i]

            if "red" in word.toLower():
                color_numbers["red"] += parseInt(line_array[i-1])
            elif "green" in word.toLower():
                color_numbers["green"] += parseInt(line_array[i-1])
            elif "blue" in word.toLower():
                color_numbers["blue"] += parseInt(line_array[i-1])
                
            if word[word.len-1] == ';' or i == line_array.len-1:
                echo color_numbers
                if color_numbers["red"] > allowed_numbers["red"]:
                    line_is_good = false
                if color_numbers["green"] > allowed_numbers["green"]:
                    line_is_good = false
                if color_numbers["blue"] > allowed_numbers["blue"]:
                    line_is_good = false

                color_numbers["red"] = 0
                color_numbers["green"] = 0
                color_numbers["blue"]  = 0
                
        if line_is_good:
            ids_combined += id
    
    echo ids_combined
    f.close()

    for line in file_lines.splitLines():
        line_is_good = true
        echo line
        line_array = line.split(" ")
        id = parseInt(line_array[1].substr(0, line_array[1].len-2))
        echo id

        var color_numbers = {"red": 0, "green": 0, "blue": 0}.newTable 
        for i in countup(0, line_array.len-1):
            word = line_array[i]

            if "red" in word.toLower():
                color_numbers["red"] += parseInt(line_array[i-1])
            elif "green" in word.toLower():
                color_numbers["green"] += parseInt(line_array[i-1])
            elif "blue" in word.toLower():
                color_numbers["blue"] += parseInt(line_array[i-1])
                
            if word[word.len-1] == ';' or i == line_array.len-1:
                echo color_numbers
                if color_numbers["red"] > allowed_numbers["red"]:
                    line_is_good = false
                if color_numbers["green"] > allowed_numbers["green"]:
                    line_is_good = false
                if color_numbers["blue"] > allowed_numbers["blue"]:
                    line_is_good = false

                color_numbers["red"] = 0
                color_numbers["green"] = 0
                color_numbers["blue"]  = 0
                
        if line_is_good:
            ids_combined += id
    
    echo ids_combined
    f.close()

is_possible_game_part_one("input2.txt")