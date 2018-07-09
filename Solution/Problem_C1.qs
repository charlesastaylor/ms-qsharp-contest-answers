namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;

    operation Solve_C1 (q : Qubit) : Int
    {
        body
        {
            Ry(3.0 * PI() / 8.0, q);
            return ResultAsInt([M(q)]);
        }
    }
}