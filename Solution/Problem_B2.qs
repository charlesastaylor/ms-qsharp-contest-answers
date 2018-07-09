namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_B2 (qs : Qubit[]) : Int
    {
        body
        {
            for (i in 1..Length(qs)-1) {
                CNOT(qs[0], qs[i]);
            }
            H(qs[0]);
           
            for (i in 0..Length(qs)-1) {
                if (IsResultOne(M(qs[i]))) {
                    return 1;
                }
            }
            return 0;
        }
    }
}