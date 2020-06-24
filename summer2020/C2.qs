namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Intrinsic;

    operation Solve_C2 (qs : Qubit[], parity : Int) : Unit {
        let target = parity == 0 ? Zero | One;
        using (ancilla = Qubit()) {
            repeat {
                ApplyToEach(H, qs);
                for (i in 0..Length(qs) - 1) {
                    CNOT(qs[i], ancilla);
                }
                let res = MResetZ(ancilla);
            }
            until (res == target)
            fixup {
                ResetAll(qs);
            }
        }
    }
}
