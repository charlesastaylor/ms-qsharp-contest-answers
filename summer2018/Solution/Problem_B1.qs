namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_B1 (qs : Qubit[]) : Int
    {
        body
        {
            if (IsResultOne(MeasureAllZ(qs))) {
                return 1;
            }
            return 0;
        }
    }
}