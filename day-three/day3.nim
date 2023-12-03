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

proc find_engine_sum_part_two(file_path: string): void =
    let f: File = open(file_path)
    let file_lines: string = readAll(f)
    let file_array = file_lines.split()

    var finalSum:int = 0

    for r in countup(0, file_array.len-1):
        for c in countup(0, file_array[r].len-1) :
            var isGear:bool = false;

            if file_array[r][c] == '*': isGear = true

            if not isGear: continue
            var gearRatio:int = 1
            var gearAdj:int = 0

            echo "*"
            var canLookBottom:bool = true
            var canLookTop:bool = true

            var left:int = c-1
            var right:int = c+1
            var top:int = r-1
            var bottom:int = r+1

            # left
            if isDigit(file_array[r][c-1]):
                gearAdj += 1
                var number:int = 0
                var numberString:string = ""
                # triple going left
                if isDigit(file_array[r][c-3]) and isDigit(file_array[r][c-2]):
                    numberString.add(file_array[r][c-3])
                    numberString.add(file_array[r][c-2])
                    numberString.add(file_array[r][c-1])
                # double going left
                elif isDigit(file_array[r][c-2]):
                    numberString.add(file_array[r][c-2])
                    numberString.add(file_array[r][c-1])
                # single
                else:
                    numberString.add(file_array[r][c-1])


                number = parseInt(numberString)
                gearRatio*=number

            # right
            if isDigit(file_array[r][c+1]):
                gearAdj += 1
                var number:int = 0
                var numberString:string = ""
                # triple going right
                if isDigit(file_array[r][c+3]) and isDigit(file_array[r][c+2]):
                    numberString.add(file_array[r][c+1])
                    numberString.add(file_array[r][c+2])
                    numberString.add(file_array[r][c+3])
                # double going right
                elif isDigit(file_array[r][c+2]):
                    numberString.add(file_array[r][c+1])
                    numberString.add(file_array[r][c+2])
                # single
                else:
                    numberString.add(file_array[r][c+1])
                number = parseInt(numberString)
                gearRatio*=number
            
            # bottom
            if isDigit(file_array[r+1][c]):
                canLookBottom = false
                gearAdj += 1
                var number:int = 0
                var numberString:string = ""

                # triple middle
                if isDigit(file_array[r+1][c+1]) and isDigit(file_array[r+1][c-1]):
                    numberString.add(file_array[r+1][c-1])
                    numberString.add(file_array[r+1][c])
                    numberString.add(file_array[r+1][c+1])

                # triple going right
                elif isDigit(file_array[r+1][c+2]) and isDigit(file_array[r+1][c+1]):
                    numberString.add(file_array[r+1][c])
                    numberString.add(file_array[r+1][c+1])
                    numberString.add(file_array[r+1][c+2])
                # double going right
                elif isDigit(file_array[r+1][c+1]):
                    numberString.add(file_array[r+1][c])
                    numberString.add(file_array[r+1][c+1])

                # triple going left
                elif isDigit(file_array[r+1][c-2]) and isDigit(file_array[r+1][c-1]):
                    numberString.add(file_array[r+1][c-2])
                    numberString.add(file_array[r+1][c-1])
                    numberString.add(file_array[r+1][c])
                # double going left
                elif isDigit(file_array[r+1][c-1]):
                    numberString.add(file_array[r+1][c-1])
                    numberString.add(file_array[r+1][c])

                # single
                else:
                    numberString.add(file_array[r+1][c])

                echo numberString
                number = parseInt(numberString)
                gearRatio*=number

            # top
            if isDigit(file_array[top][c]):
                canLookTop = false
                gearAdj += 1
                var number:int = 0
                var numberString:string = ""

                # middle
                if isDigit(file_array[r-1][c+1]) and isDigit(file_array[r-1][c-1]):
                    numberString.add(file_array[r-1][c-1])
                    numberString.add(file_array[r-1][c])
                    numberString.add(file_array[r-1][c+1])

                # triple going right
                elif isDigit(file_array[top][c+2]) and isDigit(file_array[top][c+1]):
                    numberString.add(file_array[top][c])
                    numberString.add(file_array[top][c+1])
                    numberString.add(file_array[top][c+2])
                # double going right
                elif isDigit(file_array[top][c+1]):
                    numberString.add(file_array[top][c])
                    numberString.add(file_array[top][c+1])

                # triple going left
                elif isDigit(file_array[top][c-2]) and isDigit(file_array[top][c-1]):
                    numberString.add(file_array[top][c-2])
                    numberString.add(file_array[top][c-1])
                    numberString.add(file_array[top][c])
                # double going left
                elif isDigit(file_array[top][c-1]):
                    numberString.add(file_array[top][c-1])
                    numberString.add(file_array[top][c])

                # single
                else:
                    numberString.add(file_array[top][c])

                echo numberString
                number = parseInt(numberString)
                gearRatio*=number

            if canLookTop:
                # top right
                if isDigit(file_array[top][right]):
                    gearAdj += 1
                    var number:int = 0
                    var numberString:string = ""

                    # triple going right
                    if isDigit(file_array[top][right+2]) and isDigit(file_array[top][right+1]):
                        numberString.add(file_array[top][right])
                        numberString.add(file_array[top][right+1])
                        numberString.add(file_array[top][right+2])
                    # double going right
                    elif isDigit(file_array[top][right+1]):
                        numberString.add(file_array[top][right])
                        numberString.add(file_array[top][right+1])

                    # triple going left
                    elif isDigit(file_array[top][right-2]) and isDigit(file_array[top][right-1]):
                        numberString.add(file_array[top][right-2])
                        numberString.add(file_array[top][right-1])
                        numberString.add(file_array[top][right])
                    # double going left
                    elif isDigit(file_array[top][right-1]):
                        numberString.add(file_array[top][right-1])
                        numberString.add(file_array[top][right])

                    # single
                    else:
                        numberString.add(file_array[top][right])

                    echo numberString
                    number = parseInt(numberString)
                    gearRatio*=number

                # top left
                if isDigit(file_array[top][left]):
                    gearAdj += 1
                    var number:int = 0
                    var numberString:string = ""

                    # triple going right
                    if isDigit(file_array[top][left+2]) and isDigit(file_array[top][left+1]):
                        numberString.add(file_array[top][left])
                        numberString.add(file_array[top][left+1])
                        numberString.add(file_array[top][left+2])
                    # double going right
                    elif isDigit(file_array[top][left+1]):
                        numberString.add(file_array[top][left])
                        numberString.add(file_array[top][left+1])

                    # triple going left
                    elif isDigit(file_array[top][left-2]) and isDigit(file_array[top][left-1]):
                        numberString.add(file_array[top][left-2])
                        numberString.add(file_array[top][left-1])
                        numberString.add(file_array[top][left])
                    # double going left
                    elif isDigit(file_array[top][left-1]):
                        numberString.add(file_array[top][left-1])
                        numberString.add(file_array[top][left])
                    # single
                    else:
                        numberString.add(file_array[top][left])

                    echo numberString
                    number = parseInt(numberString)
                    gearRatio*=number

            if canLookBottom:
                # bottom right
                if isDigit(file_array[bottom][right]):
                    gearAdj += 1
                    var number:int = 0
                    var numberString:string = ""

                    # triple going right
                    if isDigit(file_array[bottom][right+2]) and isDigit(file_array[bottom][right+1]):
                        numberString.add(file_array[bottom][right])
                        numberString.add(file_array[bottom][right+1])
                        numberString.add(file_array[bottom][right+2])
                    # double going right
                    elif isDigit(file_array[bottom][right+1]):
                        numberString.add(file_array[bottom][right])
                        numberString.add(file_array[bottom][right+1])

                    # triple going left
                    elif isDigit(file_array[bottom][right-2]) and isDigit(file_array[bottom][right-1]):
                        numberString.add(file_array[bottom][right-2])
                        numberString.add(file_array[bottom][right-1])
                        numberString.add(file_array[bottom][right])
                    # double going left
                    elif isDigit(file_array[bottom][right-1]):
                        numberString.add(file_array[bottom][right-1])
                        numberString.add(file_array[bottom][right])

                    # single
                    else:
                        numberString.add(file_array[bottom][right])

                    echo numberString
                    number = parseInt(numberString)
                    gearRatio*=number

                # bottom left
                if isDigit(file_array[bottom][left]):
                    gearAdj += 1
                    var number:int = 0
                    var numberString:string = ""

                    # triple going right
                    if isDigit(file_array[bottom][left+2]) and isDigit(file_array[bottom][left+1]):
                        numberString.add(file_array[bottom][left])
                        numberString.add(file_array[bottom][left+1])
                        numberString.add(file_array[bottom][left+2])
                    # double going right
                    elif isDigit(file_array[bottom][left+1]):
                        numberString.add(file_array[bottom][left])
                        numberString.add(file_array[bottom][left+1])

                    # triple going left
                    elif isDigit(file_array[bottom][left-2]) and isDigit(file_array[bottom][left-1]):
                        numberString.add(file_array[bottom][left-2])
                        numberString.add(file_array[bottom][left-1])
                        numberString.add(file_array[bottom][left])
                    # double going left
                    elif isDigit(file_array[bottom][left-1]):
                        numberString.add(file_array[bottom][left-1])
                        numberString.add(file_array[bottom][left])
                    # single
                    else:
                        numberString.add(file_array[bottom][left])

                    echo numberString
                    number = parseInt(numberString)
                    gearRatio*=number

            if gearAdj == 2:
                finalSum += gearRatio
    
    echo finalSum


find_engine_sum_part_two("./input2.txt")