import sys

cells = [0] * 30000
cell_pointer = 0
code_pointer = 0
brackets = {}
user_input = []
print_output = []

filename = input('filename: ')

# instructions = [i for i in list(input(': ')) if i in '+-<>,.[]']
# instructions = list(input(': '))

with open(filename, 'r') as f:
    instructions = [i for i in list(f.read()) if i in '+-<>,.[]']

temp_index = []
for pos, i in enumerate(instructions):
    if i == '[':
        temp_index.append(pos)
    elif i == ']':
        start = temp_index.pop()
        brackets[start] = pos
        brackets[pos] = start


while code_pointer < len(instructions):
    if instructions[code_pointer] == '+':
        if cells[cell_pointer] == 255:
            cells[cell_pointer] = 0
        else:
            cells[cell_pointer] += 1
    elif instructions[code_pointer] == '-':
        if cells[cell_pointer] == 0:
            cells[cell_pointer] = 255
        else:
            cells[cell_pointer] -= 1
    elif instructions[code_pointer] == '>':
        if cell_pointer == len(cells) - 1:
            cell_pointer = 0
        else:
            cell_pointer += 1
    elif instructions[code_pointer] == '<':
        if cell_pointer == 0:
            cell_pointer = len(cells) - 1
        else:
            cell_pointer -= 1
    elif instructions[code_pointer] == '[':
        if cells[cell_pointer] == 0:
            code_pointer = brackets[code_pointer]
    elif instructions[code_pointer] == ']':
        if cells[cell_pointer] != 0:
            code_pointer = brackets[code_pointer]
    elif instructions[code_pointer] == '.':
        # if code_pointer != 0 and instructions[code_pointer - 1] == ',' and instructions[code_pointer + 1] == ',' or code_pointer != len(instructions) - 1 and instructions[code_pointer + 1] == ',':
        #     sys.stdout.write(chr(cells[cell_pointer]) + '\n')
        # else:
        #     sys.stdout.write(chr(cells[cell_pointer]))
        print_output.append(chr(cells[cell_pointer]))
    elif instructions[code_pointer] == ',':
        if len(user_input) == 0:
            if len(print_output) > 0:
                print(''.join(print_output))
            user_input = list(input(': '))
        cells[cell_pointer] = ord(user_input[0])
        user_input.pop(0)

    code_pointer += 1

print(''.join(print_output))
