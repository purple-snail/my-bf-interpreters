function run() {
    let code = document.getElementById('code').value
    let outputElement = document.getElementById('output')
    let tape = Array(30000).fill(0)
    let tapePointer = 0
    let codePointer = 0
    let inputElement = document.getElementById('input')
    let outputData = ''
    let inputData = inputElement.value.split("")
    let brackets = {}
    let instruction

    outputElement.value = ''

    let temp_brackets = []
    for (let i = 0; i <= code.length; i++) {
        if (code[i] == '[') {
            temp_brackets.push(i)
        } else if (code[i] == ']') {
            let start = temp_brackets.pop()
            brackets[start] = i
            brackets[i] = start
        }
    }

    while (codePointer < code.length) {
        instruction = code[codePointer]

        if (instruction == '+') {
            if (tape[tapePointer] == 255) {
                tape[tapePointer] = 0
            } else {
                tape[tapePointer]++
            }
        } else if (instruction == '-') {
            if (tape[tapePointer] == 0) {
                tape[tapePointer] = 255
            } else {
                tape[tapePointer]--
            }
        } else if (instruction == '>') {
            if (tapePointer == tape.length - 1) {
                tapePointer = 0
            } else {
                tapePointer++
            }
        } else if (instruction == '<') {
            if (tapePointer == 0) {
                tapePointer = tape.length - 1
            } else {
                tapePointer--
            }
        } else if (instruction == '.') {
            outputData = outputElement.value + String.fromCharCode(tape[tapePointer])
            outputElement.value = outputData
        } else if (instruction == ',') {
            if (inputData.length == 0) {
                inputData = prompt('There is no input. Add input:').split('')
            }
            tape[tapePointer] = inputData.shift().charCodeAt(0)
            inputElement.value = inputData.join('')
        } else if(instruction == '[') {
            if (tape[tapePointer] == 0) {
                codePointer = brackets[codePointer]
            }
        } else if(instruction == ']') {
            if (tape[tapePointer] != 0) {
                codePointer = brackets[codePointer]
            }
        }

        codePointer++
    }
}
