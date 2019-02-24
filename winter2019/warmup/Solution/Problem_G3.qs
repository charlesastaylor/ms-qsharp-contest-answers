namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_G3 (x : Qubit[], y : Qubit) : Unit {
        body (...) {
            if (Length(x) == 1) {
                // x is always palindrome if length 1
                X(y);
            } else {
                for (p in Palindromes(Length(x))) {
                    (ControlledOnBitString(p, X))(x, y);
                }
            }
        }
        adjoint auto;
    }

    function Palindromes (length : Int) : Bool[][] {
        let oddLength = length % 2 != 0;
        mutable noCombinations = 2^(length / 2);
        mutable palindromes = new Bool[][noCombinations];
        if (oddLength) {
            set palindromes = new Bool[][noCombinations * 2];
        }
        mutable count = 0;
        for (i in 0..noCombinations - 1) {
            let half = BoolArrFromPositiveInt(i, length / 2);
            let halfReverse = half[Length(half) - 1..-1..0];
            if (oddLength) {
                set palindromes[count] = half + [false] + halfReverse;
                set palindromes[count+1] = half + [true] + halfReverse;
                set count = count + 2;
            } else {
                set palindromes[count] = half + halfReverse;
                set count = count + 1;
            }
        }
        return palindromes;
    }
}