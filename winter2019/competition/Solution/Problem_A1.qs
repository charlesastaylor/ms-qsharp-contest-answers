namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Convert;
    open Microsoft.Quantum.Extensions.Math;

    operation Solve_A1 (qs : Qubit[]) : Unit {
        FracSuper(3, qs[0]);
        (ControlledOnBitString([false], H))(qs[0..0], qs[1]);
    }

    operation FracSuper(denominator : Int, q : Qubit) : Unit {
        body (...) {
            if (denominator ==  1) {
                X(q);
            } else {
                let denom = ToDouble(denominator);
                let num = denom - 1.0;
                let theta = 2.0 * ArcCos(Sqrt(num / denom));
                Ry(theta, q);
            }
        }
        adjoint invert;
        controlled distribute;
        controlled adjoint distribute;
    }
}
