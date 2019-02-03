	AREA	DisplayResult, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	EXPORT	start
	PRESERVE8

start

	MOV	R4, #0			;	input1 = 0;
	MOV	R6, #10			;	load value 10 into R6;
	MOV	R7, #0			;	operator = 0;
	MOV	R8, #0			;	input2 = 0;
	
while					;	while (boolean finished == false)
						;	{
	BL	getkey			;	 	read key from console
	BL	sendchar		;  		echo key back to console
	
	CMP	R0, #"+"		; 		if (key=="+")
	BNE	elsif1			; 		{
	MOV	R7, #"+"		;			operator = "+";
	B	endwh			; 			finished = true;
						;		}
elsif1
	CMP	R0, #"-"		; 		else if (key=="-")
	BNE	elsif2			; 		{
	MOV	R7, #"-"		;			operator = "-"
	B	endwh			; 			finished = true;
						;		}
elsif2
	CMP	R0, #"*"		; 		else if (key=="*")
	BNE	elsif3			; 		{
	MOV	R7, #"*"		;			operator = "*"
	B	endwh			; 			finished = true;
						;		}
elsif3					;		else {
	SUB	R0, R0, #0x30	; 			convert ASCII to numeric value
	MUL	R4, R6, R4		; 			input1 = input1 x 10;
	ADD	R4, R0, R4		; 			input1 = input1 + value;
	B	while			; 		}
endwh					; 	)
	
while2
	BL	getkey			; 	read key from console
	CMP	R0, #0x0D  		;	while (key != CR)
	BEQ	endwh2			;	{
	BL	sendchar		;		echo key back to console
	SUB	R0, R0, #0x30	;		convert ASCII to numeric value
	MUL	R8, R6, R8		;		input2 = input2 x 10;
	ADD	R8, R0, R8		;		input2 = input2 + value;
	B	while2			;	}
endwh2
	
	
	CMP	R7, #"+"		;	if (operator=="+")
	BNE	minus			;	{
	ADD	R5, R4, R8		;		answer = input1 + input2;
	B	end				;	}
minus
	CMP	R7, #"-"		;	else if (operator=="-")
	BNE	multiply		;	{
	SUB	R5, R4, R8		;		answer = input1 - input2;
	B	end				;	}
multiply
	CMP	R7, #"*"		;	else if (operator=="*")
	BNE	end				;	{
	MUL	R5, R4, R8		;		answer = input1 * input2;
end						;	}
	
	MOV	R0, #"="		;	move ASCII value for "=" to R0
	BL	sendchar		;	print "="
		
	LDR	R6, =0			;	load value 0 into R6
	LDR	R7, =0			;	load value 0 into R7
	LDR	R8, =10			;	load constant value 10 into R8
displaywh	
	CMP	R5, #0			;	while(answer>0)
	BLS	enddisplaywh	;	{
	MOV	R10, R5			;		copy value of answer to 'number' to alter in calculations
	LDR	R7, =1			;		R7 = 1;
whilea	
	CMP	R10, #10		;		while(number>10)
	BLS	endwha			;		{
	LDR	R9, =0			;			quotient = 0;
	MOV R6, R10			;			remainder = number;
whileb
	CMP	R6, R8			;			while(remainder>10)	// R6 divided by 10
	BLO	endwhb			;			{
	ADD	R9, R9, #1		;				quotient = quotient + 1;			
	SUB	R6, R6, R8		;				remainder = remainder - 10;			
	B	whileb			;			}
endwhb		
	MOV	R10, R9			;			store quotient value in 'number'
	
	CMP	R10, #0			;			if (number>0)		// finding the multiple of 10 that	
	BLS	endifa			;			{					// we should divide our answer by
	MUL	R7, R8, R7		;				R7 = 10^x
endifa 					;			}
	B	whilea			;		}
endwha					;		
	LDR	R6, =0			;		load value 0 into R6 (R6 will store remainder)
whilec
	CMP	R5, R7			;		while(answer>=10^x)		// dividing our answer by 10^x
	BLO	endwhc			;		{																															
	ADD	R6, R6, #1		;			remainder = remainder + 1;			
	SUB	R5, R5, R7		;			answer = answer - 10^x		
	B	whilec			;		}		
endwhc	
	ADD	R0, R6, #0x30	;		converting remaining number to ASCII value
	BL	sendchar		;		print ASCII value to console
	B	displaywh		;	}
enddisplaywh		

stop	B	stop

	END	
