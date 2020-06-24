namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;

     operation AddI (xs: LittleEndian, ys: LittleEndian) : Unit is Adj + Ctl {
        if (Length(xs!) == Length(ys!)) {
            RippleCarryAdderNoCarryTTK(xs, ys);
        }
        elif (Length(ys!) > Length(xs!)) {
            using (qs = Qubit[Length(ys!) - Length(xs!) - 1]){
                RippleCarryAdderTTK(LittleEndian(xs! + qs),
                                    LittleEndian(Most(ys!)), Tail(ys!));
            }
        }
        else {
            fail "xs must not contain more qubits than ys!";
        }
    }

    // Surely theres a simpler way...
    // This is actually wrong. I tried to implement this - https://stackoverflow.com/a/52217016/9327236
    // idea but in the step which write to output I should also be checking to see
    // if |a> =|00> (ie 0 is divisible by 3)
    // If I "fix" the above then a bunch of other stuff fails because on the second
    // addition round stuff overflows the b register
    // Should really have a second intermediate register c which is 3 qubits

    // Instead ive just hacked it by checking if we are zero state as that is only
    // one that is "broken"

    // https://algassert.com/quirk#circuit={%22cols%22:[[1,1,1,1,1,1,1,1,%22Chance%22,1,1,%22Amps4%22],[],[],[],[%22inputA2%22,1,1,1,1,1,1,1,1,1,1,%22+=A4%22],[1,1,%22inputA2%22,1,1,1,1,1,1,1,1,%22+=A4%22],[1,1,1,1,%22inputA2%22,1,1,1,1,1,1,%22+=A4%22],[1,1,1,1,1,1,%22inputA2%22,1,1,1,1,%22+=A4%22],[1,1,1,1,1,1,1,1,1,%22+=A2%22,1,%22inputA2%22],[1,1,1,1,1,1,1,1,1,%22+=A2%22,1,1,1,%22inputA2%22],[1,1,1,1,1,1,1,1,%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[1,1,1,1,1,1,1,1,1,%22Amps2%22],[],[1,1,1,1,1,1,1,1,1,%22-=A2%22,1,%22inputA2%22],[1,1,1,1,1,1,1,1,1,%22-=A2%22,1,1,1,%22inputA2%22],[%22inputA2%22,1,1,1,1,1,1,1,1,1,1,%22-=A4%22],[1,1,%22inputA2%22,1,1,1,1,1,1,1,1,%22-=A4%22],[1,1,1,1,%22inputA2%22,1,1,1,1,1,1,%22-=A4%22],[1,1,1,1,1,1,%22inputA2%22,1,1,1,1,%22-=A4%22],[1,1,1,1,1,1,1,1,1,1,1,%22Amps4%22]],%22gates%22:[{%22id%22:%22~koia%22,%22name%22:%22Z_minus%22,%22matrix%22:%22{{-1,0},{0,1}}%22},{%22id%22:%22~s4pm%22,%22name%22:%22Rz_pi%22,%22matrix%22:%22{{-i,0},{0,i}}%22},{%22id%22:%22~13u%22,%22name%22:%22I%22,%22matrix%22:%22{{1,0},{0,1}}%22},{%22id%22:%22~9t71%22,%22name%22:%22I_minus%22,%22matrix%22:%22{{-1,0},{0,-1}}%22}]}
    operation Solve_B2 (inputs : Qubit[], output : Qubit) : Unit is Adj+Ctl {
        let N = Length(inputs);
        // using ((ys, result) = (Qubit[N], Qubit[N])) {

        // }
        if (N < 8) {
            for (i in 0..3..2^N - 1) { // ***TOO SLOW***!!
                (ControlledOnInt(i, X)) (inputs, output);
            }
        } else {
            using (anc = Qubit[6]) {
                (ControlledOnInt(0, X)) (inputs, output);
                let a = LittleEndian(anc[0..1]);
                let b = LittleEndian(anc[2..5]);
                let input_1 = LittleEndian(inputs[0..1]);
                let input_2 = LittleEndian(inputs[2..3]);
                let input_3 = LittleEndian(inputs[4..5]);
                let input_4 = LittleEndian(inputs[6..7]);
                let b_1 = LittleEndian(anc[2..3]);
                let b_2 = LittleEndian(anc[4..5]);
                AddI(input_1, b);
                AddI(input_2, b);
                AddI(input_3, b);
                AddI(input_4, b);
                AddI(b_1, a);
                AddI(b_2, a);
                CCNOT(anc[0], anc[1], output);
                // X(anc[0]);
                // X(anc[1]);
                // CCNOT(anc[0], anc[1], output);
                // X(anc[0]);
                // X(anc[1]);
                Adjoint AddI(b_1, a);
                Adjoint AddI(b_2, a);
                Adjoint AddI(input_1, b);
                Adjoint AddI(input_2, b);
                Adjoint AddI(input_3, b);
                Adjoint AddI(input_4, b);
            }
        }
    }
}
