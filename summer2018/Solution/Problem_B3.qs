namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_B3 (qs : Qubit[]) : Int
    {
        body
        {
            ApplyToEachCA(H, qs);

            return ResultAsInt( [M(qs[1]);M(qs[0])] );
        }
    }
}