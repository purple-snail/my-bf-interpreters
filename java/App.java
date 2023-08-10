import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class App {
    public static void main(String[] args) throws Exception {
        Scanner reader = new Scanner(System.in);
        System.out.print("code: ");
        String code = reader.nextLine();

        List<Integer> inputs = new ArrayList<Integer>();
        Map<Integer, Integer> brackets = new HashMap<Integer, Integer>();
        int codePointer = 0;
        int tapePointer = 0;
        int[] tape = new int[30000];
        Arrays.fill(tape, 0);

        List<Integer> unmatchedBrackets = new ArrayList<Integer>();

        for (int i = 0; i < code.length(); i++) {
            if (code.charAt(i) == '[') {
                unmatchedBrackets.add(i);
            } else if (code.charAt(i) == ']') {
                int start = unmatchedBrackets.remove(unmatchedBrackets.size() - 1);
                brackets.put(start, i);
                brackets.put(i, start);
            }
        }

        while (codePointer < code.length()) {
            switch (code.charAt(codePointer)) {
                case '>':
                    if (tapePointer == tape.length - 1) {
                        tapePointer = 0;
                    } else {
                        tapePointer++;
                    }
                    break;
                case '<':
                    if (tapePointer == 0) {
                        tapePointer = tape.length - 1;
                    } else {
                        tapePointer--;
                    }
                    break;
                case '+':
                    if (tape[tapePointer] == 255) {
                        tape[tapePointer] = 0;
                    } else {
                        tape[tapePointer] += 1;
                    }
                    break;
                case '-':
                    if (tape[tapePointer] == 0) {
                        tape[tapePointer] = 255;
                    } else {
                        tape[tapePointer] -= 1;
                    }
                    break;
                case ',':
                    if (inputs.size() < 1) {
                        System.out.print(": ");
                        String input = reader.nextLine();

                        for (char character : input.toCharArray()) {
                            inputs.add((int) character);
                        }
                    }

                    tape[tapePointer] = inputs.remove(0);
                    break;
                case '.':
                    System.out.print((char) tape[tapePointer]);
                    break;
                case '[':
                    if (tape[tapePointer] == 0) {
                        codePointer = brackets.get(codePointer);
                    }
                    break;
                case ']':
                    if (tape[tapePointer] != 0) {
                        codePointer = brackets.get(codePointer);
                    }
                    break;
                default:
                    break;
            }
            codePointer++;
        }

        reader.close();
    }
}
