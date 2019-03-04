namespace Solution
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Extensions.Convert;

    operation HelloQ () : Unit {
        let bits = [[false, false, false], [false, true, false], [true, false, true], [true, true, false]];
        let sorted = SortBitStrings(bits);
        for (b in sorted) {
            PrintBitString(b);
        }
        Message("_____");
        let arranged = ArrangeBitStrings(bits);
        for (b in arranged) {
            PrintBitString(b);
        }
    }
    function PrintArrayI(arr : Int[]) : Unit {
        mutable s = "";
        for (x in arr) {
            set s = s + ToStringI(x) + " ";
        }
        Message(s);
    }

    function PrintBitString(bits : Bool[]) : Unit {
        mutable s = "";
        for (bit in bits) {
            set s = s + ToStringB(bit) + " ";
        }
        Message(s);
    }

    function IsPowerOfTwo(x : Int) : Bool {
        return (x != 0) && (x &&& (x - 1)) == 0;
    }


    function Disallowed(N : Int) : Int[] {
        mutable disallowed = new Int[(N - 1) * 2];
        mutable idx = 0;
        for (i in 1 .. N - 1) {
            set disallowed[idx] = 2^i - 1;
            set disallowed[idx + 1] = 2^N - 1 - disallowed[idx];
            set idx = idx + 2;
        }
        return disallowed;
    }

    function IntInArray(n : Int, arr : Int[]) : Bool {
        for (x in arr) {
            if (x == n) {
                return true;
            }
        }
        return false;
    }
    function PeriodicBitStrings(N : Int) : Bool[][] {
        // **** INCOMPLETE doesnt account for substrings betwen periodic
        // parts
        let PMax = N - 1;
        mutable bitStrings = new Bool[][PMax * 2];
        mutable P = 1;
        for (i in 0 .. 2 .. Length(bitStrings) - 1) {
            set bitStrings[i] = new Bool[N];
            for (j in 0 .. P .. N - 1){
                set bitStrings[i][j] = true;
            }
            set bitStrings[i+1] = InvertBitString(bitStrings[i]);
            set P = P + 1;
        }
        return bitStrings;
    }

    function InvertBitString(bits : Bool[]) : Bool[] {
        mutable retBits = new Bool[Length(bits)];
        for (i in 0 .. Length(bits) - 1) {
            set retBits[i] = not bits[i];
        }
        return retBits;
    }
}
