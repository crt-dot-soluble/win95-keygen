// WINDOWS 95 OEM PRODUCT FORMAT
// [XXX][YY]-[OEM]-[NNNNNNN]-[ZZZZZ]
// WHERE [XXX] IS A THREE DIGIT INTEGER BETWEEN 001 AND 366 (ZERO-PADDED TO THE LEFT, FOR NUMBERS LOWER THAN 100)
// WHERE [YY] IS THE RIGHT TWO DIGITS OF A NUMBER BETWEEN 095 AND 103
// WHERE [OEM] REMAINS IN PLACE AND NEEDS NO HELP
// WHERE [NNNNNNN] BEGINS WITH 00 & THE REMAINING 5 DIGITS MUST HAVE A MODULUS OF 0 (REMAINDER OF 0) WHEN DIVIDED BY 7
// WHERE [ZZZZZ] IS ANY SERIES OF DIGITS


module main
import rand


struct Segments {
	x string
	y string
	o string
	n string
	z string
}


fn main() {
	s := Segments{
		x:    '${x()!:03}'        // Apply '0' as left padding for numbers lower than 100
		y:    '${y()!:02}'        // Apply '0' as left padding for numbers lower than 10
		o:    'OEM'               // Insert segment 'o' as is
		n:    '${n()!:07}'
		z:    '${z()!:05}'
	}

	println("\n-------CRT.SOLUBLES ~ WIN95 KEYGEN-------")
	println("--------------------^--------------------")
	println("----[XXX][YY]-[OEM]-[NNNNNNN]-[ZZZZZ]----\n")

	//print(s)
	println("Product ID: ${s.x}${s.y}-${s.o}-${s.n}-${s.z}\n")
}


fn x() !int{
	return rand.int_in_range(0,366)!
}


fn y() !int{
	mut raw_segment 	:= rand.int_in_range(95,103)!
	mut array_segment 		:= []int{}
	mut reversed_segment	:= []int{}

	// println("\nY segment untouched: ${raw_segment}")

	// Inside the loop, we use the modulus operator % to get the rightmost digit of raw_segment
	//
	// raw_segment = 103
	// a_s [0] = 0
	// a_s [1] = 3
 	// a_s [2] =
	//
	// We store that digit in the new array (array_segment)
	// and we use the integer division operator / to remove the rightmost digit from raw_segment.
	// repeat until all the digits are accounted for

	for raw_segment > 0 {
		digit 		:= raw_segment 	% 10
		raw_segment 	= raw_segment 	/ 10
		array_segment 	<< digit
	}

	if (array_segment.len) == 3 {
		array_segment.delete_last()
	}
	reversed_segment= array_segment.reverse()
	// println("Y segment after copy: ${reversed_segment}")
	return array_to_int(reversed_segment)
}


fn n() !int {
	mut segment := rand.int_in_range(10000, 99999)!
	mut splits := int_to_array(segment)
	mut sum 	:= 8
	// mut iter 	:= 0

	//println("Testing for [segment] % 7 to equal 0")

	for sum % 7 != 0 {
		sum 	= 0
		segment = rand.int_in_range(0, 99999)!
		splits 	= int_to_array(segment)

		for n in splits {
			sum += n
		}

		// iter++
		// println("Attempt: ${iter}")


	}

	// println('Sum: ${sum}')
	// println('Found N segment: ${segment}')
	return segment
}

fn z() !int {
	return rand.int_in_range(0, 99999)!
}


// array_to_int Define a function called array_to_int that takes an integer array as input and returns an integer.
// Inside the function, we initialize a mutable integer variable result to 0 and a mutable integer
// variable factor to 1.
// We then iterate through the elements of the input array in reverse order using a for loop, and for each element,
// we multiply it by factor and add the result to result.
// We then multiply factor by 10 to shift the decimal place to the left.
// Return result as the output of the function.
fn array_to_int(arr []int) int {
	mut result := 0
	mut factor := 1
	for i in arr.reverse() {
		result += i * factor
		factor *= 10
	}
	return result
}


// takes an integer as an argument and converts it into a string. Then it iterates over each character of the string
// and converts it back into an integer by subtracting the ASCII value of 0 from the ASCII value of the character.
// Finally, it appends the resulting integer to an array and returns the array.
fn int_to_array(n int) []int {
	mut arr := []int{}
	for c in n.str().bytes() {
		arr << int(c - `0`)
	}
	return arr
}

