namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

// Your task is to perform necessary operations and measurements to figure out 
// which unitary it was and to return 0 if it was the I gate or 1 if it was the Z 
// gate
    operation Solve_A2_ (unitary : (Qubit => Unit is Adj+Ctl)) : Int {
        using (qubit = Qubit()) {
            H(qubit);
            unitary(qubit);
            H(qubit);
            let result = M(qubit);
            if (result == One) {
                X(qubit);
                return 1;
            } else {
                return 0;
            }
        }
    }
}