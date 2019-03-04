namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;

    // Pretty sure I solved how this question is supposed to be done but
    // had issues converting the Unitary I'd calculated for the POVM operators
    // into circuit. Decomposed into 2 level gates but the final gate was not a
    // standard one and wasn't quite sure what it was. 
    // Also Q# makes it hard to implement one of the gates as its around arbritary
    // axis. It's possible with combination of Rz, Ry, Rx but didn't have time to 
    // figure out.

    operation Solve (q : Qubit) : Int {

        mutable ret = 0;
        using (anc = Qubit[1]) {
            let a = anc[0];
            CNOT(q, a);
            Controlled Ry([a], (PI() / 2.0, q));
            CNOT(q, a);
            (ControlledOnBitString([false], Ry))([q], (, a));
            (ControlledOnBitString([false], H))([a], q);

            if (M(q) == Zero) {
                if (M(a) == Zero) {
                    set ret = 0;
                } else {
                    set ret = 1;
                }
            } else {
                if (M(a) == Zero) {
                    set ret = 2;
                }
            }


            Reset(a);
        }

        return ret;
    }

    operation Boop(denominator : Int, q : Qubit) : Unit {
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
