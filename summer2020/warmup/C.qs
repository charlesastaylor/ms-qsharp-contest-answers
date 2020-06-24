namespace Solution {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Intrinsic;

    operation Solve_C_ (qs : Qubit[]) : Unit {
        using (ancilla = Qubit()) {
            repeat {
                // Create |00⟩ + |01⟩ + |10⟩ + |11⟩ state
                ApplyToEach(H, qs);
                // Create (|00⟩ + |01⟩ + |10⟩) ⊗ |0⟩ + |11⟩ ⊗ |1⟩
                Controlled X(qs, ancilla);
                let res = MResetZ(ancilla);
            }
            until (res == Zero)
            fixup {
                ResetAll(qs);
            }
        }
        ApplyToEach(X, qs);
    }
}

