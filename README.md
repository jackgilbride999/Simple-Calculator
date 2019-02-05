# Simple-Calculator
ARM Assembly Language program which takes user input as a sum, computes the result and prints it to output.

The current implementation does not work as intended and contains bugs. 
Notable bug: Trailing 0s of a result fail to display in the UART #1 window. While a result ending in zero may be correctly calculated, it is incorrectly converted to ASCII output as the program assumes the number to be finished once the most significant decimal digits are gotten rid of and only reads repeated 0s, thinking that the conversion has been completed.
Notable bug: A ":" character appears in the UART #1 window in place of the substring "10". This is again due to the nature of conversion from computed result to ASCII output. 10 is wronlgy interpreted as one digit in the conversion to output, so the value 0xA is added to the ASCII code for '0', which is 0x30. This gives the code 0x40, which is ':', which is then incorrectly printed to the output.
Notable bug: The program does not output correctly for very large values due to the method of converting binary to ASCII decimal involving multiples of 10. Multiplying many high values by 10 causes overflow.
There are no notable bugs with user input or the actual calculations provided usage is correct.

Usage: A regular expression of a decimal integer, followed by +, - or * , followed by another decimal integer, followed by the carraige return character. Provided the bugs above are avoided, typing the sequence 100+99 should lead to the UART #1 window displaying "100+99=199".
