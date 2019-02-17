# Simple-Calculator
ARM Assembly Language program which takes user input as a sum, computes the result and prints it to output.

NOTE: This .s file may require additional files to be built into an executable. It was designed to work inside a simulation environment of Keil uVision. The usage and known limitations below are from testing within that environment.

USAGE: 
- Use the UART #1 window to input a regular expression of a decimal integer, followed by +, - or * , followed by another decimal integer, followed by the carraige return character. 
- The output should be displayed to the user following the calculation in the window. 
- For example, typing the sequence 100+99 should lead to the UART #1 window displaying "100+99=199".

KNOWN LIMITATIONS:
- Trailing 0s of a result fail to display in the UART #1 window. While a result ending in zero may be correctly calculated, it is incorrectly converted to ASCII output as the program assumes the number to be finished once the most significant decimal digits are gotten rid of and only reads repeated 0s, thinking that the conversion has been completed.
- A ":" character appears in the UART #1 window in place of the substring "10". This is again due to the nature of conversion from computed result to ASCII output. 10 is wronlgy interpreted as one digit in the conversion to output, so the value 0xA is added to the ASCII code for '0', which is 0x30. This gives the code 0x40, which is ':', which is then incorrectly printed to the output.
- The program does not output correctly for very large values due to the method of converting binary to ASCII decimal involving multiples of 10. Multiplying many high values by 10 causes overflow.
- There are no notable bugs with user input or the actual calculations provided usage is correct.

