namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Extensions.Math;
    open Microsoft.Quantum.Extensions.Convert;
 
    operation Solve_A4_alt (qs: Qubit[]) : () {
        body {
            let N = Length(qs);
            let k = Round(Lg(ToDouble(N)));
            let controls = qs[0 .. k - 1];
            let targets = qs[k .. N - 1];
            // Create equal superposition
            ApplyToEachCA(H, controls);
            // Now permute to required state
            mutable current_target = 0;
            for (i in 0 .. N - 1) {
                if(!IsPowerOfTwo(i)) {
                    // Flip desired bit
                    let c_bits = Reverse(BoolArrFromPositiveInt(i, Length(controls)));
                    (ControlledOnBitString(c_bits, X))(controls, targets[current_target]);
                    // Set all other bits to zero
                    for (j in 0 .. Length(c_bits) - 1) {
                        if (c_bits[j]) {
                            CNOT(targets[current_target], controls[j]);
                        }
                    }
                    set current_target = current_target + 1;
                }
            }
        }
    }

    function IsPowerOfTwo (x: Int) : Bool {
        if (x == 0) {
            return false;
        }
        return (x &&& (x - 1)) == 0;
    }

    operation Solve_A4 (qs : Qubit[]) : ()
    {
        body
        {
            let N = Length(qs);
            for (i in 0 .. N - 1) {
                if (i == 0) {
                    G(N - i, qs[i]);
                } else {
                    let controls = qs[0 .. i - 1];
                    let target = qs[i];
                    (ControlledOnBitString(new Bool[i], G))(controls, (N - i, target));
                }
            }
        }
    }

    operation G (x: Int, q : Qubit) : () {
        body {
            if (x == 1) {
                X(q);
            } elif (x == 2) {
                H(q);
            } else {
                let theta = 2.0 * ArcSin(1.0 / Sqrt(ToDouble(x)));
                Ry(theta, q);
            }
        }

        adjoint auto
        controlled auto
        controlled adjoint auto
    }    
}