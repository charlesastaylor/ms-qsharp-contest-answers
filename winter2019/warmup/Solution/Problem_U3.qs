namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve (qs : Qubit[]) : Unit {
        ApplyToEach(X, qs[0..Length(qs) - 2]);
        // for (i in 0..Length(qs) - 2) {
        //     Controlled H([qs[Length(qs) - 1]], qs[i]);
        // }
        Controlled ApplyToEachC([qs[Length(qs) - 1]], (H, qs[0..Length(qs) - 2]));
    }
}