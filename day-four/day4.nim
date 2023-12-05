import std/strutils
import std/tables
import std/math

proc part_one(file_path:string): void =
    let f: File = open(file_path)
    let file_lines:string = readAll(f)
    let file_array = file_lines.splitLines()
    var total_sum:int = 0
    var card_sum:int = 0
    var final_value:int = 0

    for r in countup(0, file_array.len-1):
        let line_index:int = find(file_array[r], '|') - 1
        let card_index:int = find(file_array[r], ':') + 1


        var winning_numbers_sub = file_array[r][card_index..line_index]
        var my_numbers_sub =  file_array[r][line_index+2..file_array[r].len-1]

        var number_table = {"":0}.newTable
        for number in winning_numbers_sub.split():
            total_sum = 0
            number_table[number] = 0
        number_table.del("")

        for key in number_table.keys:
            for number in my_numbers_sub.split():
                if key == number:
                    number_table[key] += 1
                    total_sum += 1
        if total_sum > 0:
            card_sum = 2^(total_sum-1)
        else:
            card_sum = 0
        final_value += card_sum
    echo final_value


part_one("./input2.txt")