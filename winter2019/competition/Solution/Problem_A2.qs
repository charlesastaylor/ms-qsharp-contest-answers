namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    // Was pretty tired by this point and just trying anything to get it to work
    // so not quite sure how much of this is actually necessary.

    operation Solve_A2 (qs : Qubit[], bits : Bool[][]) : Unit {
        let N = Length(qs);
        let sorted = SortBitStrings(bits);
        let arranged = ArrangeBitStrings(sorted);
        ApplyToEach(H, qs[0..1]);
        for (i in 0 .. 3) {
            let control = BoolArrFromPositiveInt(i, 2);
            for (j in 2 .. N - 1) {
                if (arranged[i][j]) {
                    (ControlledOnBitString(control, X))(qs[0..1], qs[j]);
                }
            }
        }
        for (i in 0 .. 3) {
            let control = BoolArrFromPositiveInt(i, 2);
            for (k in 0 .. 1) {
                if (control[k] != arranged[i][k]) {
                    mutable c = new Bool[N - 1];
                    if (k == 0) {
                        set c = [control[1]] + arranged[i][2 .. N - 1];
                    } else {
                        set c = [arranged[i][0]] + arranged[i][2 .. N - 1];
                    }
                    (ControlledOnBitString(c, X))([qs[1 - k]] + qs[2 .. N - 1], qs[k]);
                }
            }
        }
    }

    function ArrangeBitStrings(strings : Bool[][]) : Bool[][] {
        let N = Length(strings[0]);
        mutable ret = strings;
        mutable arranged = true;
        mutable tmp = new Bool[N];
        repeat {
            for (i in 0 .. Length(ret) - 1) {
                let x = PositiveIntFromBoolArr(ret[i]);
                if (x < 4 && x != i) {
                    set tmp = ret[i];
                    set ret[i] = ret[x];
                    set ret[x] = tmp;
                    set arranged = false;
                }
            }
        } until (arranged)
        fixup {
            set arranged = true;
        }
        return ret;

    }

    function SortBitStrings(strings : Bool[][]) : Bool[][] {
        let N = Length(strings[0]);
        mutable ret = strings;
        mutable sorted = true;
        mutable tmp = new Bool[N];
        repeat {
            for (i in 0 .. Length(ret) - 2) {
                if (PositiveIntFromBoolArr(ret[i]) > PositiveIntFromBoolArr(ret[i + 1])) {
                    set tmp = ret[i];
                    set ret[i] = ret[i + 1];
                    set ret[i + 1] = tmp;
                    set sorted = false;
                }
            }
        } until (sorted)
        fixup {
            set sorted = true;
        }
        return ret;
    }
}