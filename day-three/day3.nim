import std/strutils



proc find_engine_sum_part_one(file_path: string): void =
    let f: File = open(file_path)
    let file_lines: string = readAll(f)
    let file_array = file_lines.split()
    var finalSum:int = 0

    for r in countup(0, file_array.len-1):
    # for r in countup(0, fi):
        var oldIntString:string = ""
        var cStart:int = -1
        var cEnd:int = -1
        var cString = ""

        for c in countup(0, file_array[r].len-1) :
            var currentIntString:string = ""
            var doCheck:bool = false
            if isDigit(file_array[r][c]):

                if cStart == -1:
                    cStart = c
                cEnd = c

                if cString == "":
                    cString.add($c)
                else:
                    cString.add(",")
                    cString.add($c)

                currentIntString.add(file_array[r][c])
                oldIntString.add(currentIntString)


                if c == file_array[r].len-1:
                    # echo "At the edge"
                    # echo oldIntString
                    doCheck = true

                elif not isDigit(file_array[r][c+1]):
                    # echo oldIntString
                    doCheck = true

                if doCheck:
                    var isNumber:bool = false
                    #left
                    if cStart > 1 and file_array[r][cStart-1] != '.':
                        finalSum += parseInt(oldIntString)
                        echo "LEFT PASSED"
                        isNumber = true
                 
                    # right
                    elif cEnd < file_array[r].len-1 and file_array[r][cEnd+1] != '.':
                        finalSum += parseInt(oldIntString)
                        echo "RIGHT PASSED"
                        isNumber = true

                    # top left
                    elif r > 0 and cStart > 1 and file_array[r-1][cStart-1] != '.':
                        finalSum += parseInt(oldIntString)
                        echo "TOP LEFT PASSED"
                        isNumber = true

                    # top right
                    elif r > 0 and cEnd < file_array[r].len-1 and file_array[r-1][cEnd+1] != '.':
                        echo "TOP RIGHT PASSED"
                        finalSum += parseInt(oldIntString)
                        isNumber = true

                    # bottom left
                    elif r < file_array.len-1 and cStart > 1 and  file_array[r+1][cStart-1] != '.':
                        finalSum += parseInt(oldIntString)
                        echo "BOTTOM LEFT PASSED"
                        isNumber = true

                    # bottom right
                    elif cEnd < file_array[r].len-1 and r < file_array.len-1 and file_array[r+1][cEnd+1] != '.':
                        echo "BOTTOM RIGHT PASSED"
                        finalSum += parseInt(oldIntString)
                        isNumber = true
                    
                    # top and bottom
                    else:
                        var iInt:int =0
                        for i in cString.split(','):
                            iInt = parseInt($i)

                            # top
                            if r > 0 and file_array[r-1][iInt] != '.':
                                echo "TOP PASSED"
                                # echo file_array[r-1][iInt]
                                echo iINt
                                finalSum += parseInt(oldIntString)
                                isNumber = true
                                break

                            # bottom
                            elif r < file_array.len-1 and file_array[r+1][iInt] != '.':
                                echo "BOTTOM PASSED"
                                finalSum += parseInt(oldIntString)
                                isNumber = true
                                break
                    
                    oldIntString.add(" isNumber: ")
                    oldIntString.add($isNumber)

                    echo cString
                    echo oldIntString
                    

                    oldIntString = ""
                    cString = ""
                    cStart = -1
                    cEnd = -1

    echo finalSum



find_engine_sum_part_one("./input2.txt")