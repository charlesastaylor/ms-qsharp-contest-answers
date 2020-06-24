namespace Solution {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;


    operation Solve_E1 (p : Int, inputRegister : LittleEndian) : Unit is Adj+Ctl {
    // function ModulusI (value : Int, modulus : Int) : Int
    // operation QFTLE (qs : Microsoft.Quantum.Arithmetic.LittleEndian) : Unit
        let mod = ModulusI(p, 4);
        for (_ in 1..mod) {
            QFTLE(inputRegister);
        }
    }
}