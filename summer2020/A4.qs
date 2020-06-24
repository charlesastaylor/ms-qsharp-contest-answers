namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;

// Your task is to perform necessary operations and measurements to figure out
//  which unitary it was and to return 0 if it was the Rz gate or 1 if it was the R1 gate
    operation Solve_A4 (unitary : ((Double, Qubit) => Unit is Adj+Ctl)) : Int {
        using (qs = Qubit[2]) {
            H(qs[0]);
            CNOT(qs[0], qs[1]);
            Controlled unitary(qs[0..0], (2. * PI() ,qs[1]));
            CNOT(qs[0], qs[1]);
            H(qs[0]);
            return MResetZ(qs[0]) == One ? 0 | 1;
        }
    }
}

    