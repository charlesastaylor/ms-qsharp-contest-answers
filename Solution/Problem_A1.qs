namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_A1 (qs : Qubit[]) : ()
    {
        body
        {
            ApplyToEachCA(H, qs);
        }
    }
}