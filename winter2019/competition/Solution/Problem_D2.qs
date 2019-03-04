namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_D2 (qs : Qubit[]) : Unit {
        let N = Length(qs);
        for (i in 1 .. N - 1) {
            let bits = BoolArrFromPositiveInt(1, i);
            (ControlledOnBitString(bits, ApplyToEachCA))(qs[N - 1 - (i - 1) .. N - 1], (H, qs[0 .. N - 1 - i]));
        }
    }
}