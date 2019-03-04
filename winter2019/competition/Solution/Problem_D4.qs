namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    // Circuits
    // N = 2: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting2%22],[%22Amps2%22],[],[%22%E2%80%A6%22],[%22X%22,%22%E2%80%A2%22],[1,%22H%22],[%22X%22,%22%E2%80%A2%22],[%22Amps2%22]]}
    // N = 3: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting3%22],[%22Amps3%22],[],[%22%E2%97%A6%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22%E2%80%A6%22],[%22X%22,%22X%22,%22%E2%80%A2%22],[1,1,%22H%22],[%22X%22,%22X%22,%22%E2%80%A2%22],[%22Amps3%22]]}
    // N = 4: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting4%22],[%22Amps4%22],[],[],[],[%22%E2%97%A6%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22%E2%80%A6%22],[%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[1,1,1,%22H%22],[%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22Amps4%22]]}
    // N = 5: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting5%22],[%22Amps5%22],[],[],[%22%E2%97%A6%22,%22X%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22%E2%80%A6%22],[%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[1,1,1,1,%22H%22],[%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22Amps5%22]]}
    // (N = 6: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting6%22],[%22Amps6%22],[],[],[],[],[],[%22%E2%97%A6%22,%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22%E2%80%A6%22],[%22X%22,%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[1,1,1,1,1,%22H%22],[%22X%22,%22X%22,%22X%22,%22X%22,%22X%22,%22%E2%80%A2%22],[%22Amps6%22]]})
    // TODO: Get rid if, elifs just did like that to solution done
    operation Solve_D4 (qs : Qubit[]) : Unit {
        let N = Length(qs) ;
        if (N == 3) {
            (ControlledOnBitString([false, false], ApplyToEachCA))(qs[0..0] + qs[2 .. 2], (X, qs[1..1]));
            (ControlledOnBitString([true, true], ApplyToEachCA))(qs[0..0] + qs[2 .. 2], (X, qs[1..1]));
        } elif (N == 4) {
            (ControlledOnBitString([false, false], ApplyToEachCA))(qs[0..0] + qs[3 .. 3], (X, qs[1..2]));
            (ControlledOnBitString([true, true], ApplyToEachCA))(qs[0..0] + qs[3 .. 3], (X, qs[1..2]));
            (ControlledOnBitString([true, false, false], ApplyToEachCA))(qs[0..1] + qs[3 .. 3], (X, qs[2..2]));
            (ControlledOnBitString([false, true, true], ApplyToEachCA))(qs[0..1] + qs[3 .. 3], (X, qs[2..2]));
        } elif (N == 5) {
            (ControlledOnBitString([false, false], ApplyToEachCA))(qs[0..0] + qs[4 .. 4], (X, qs[1..3]));
            (ControlledOnBitString([true, true], ApplyToEachCA))(qs[0..0] + qs[4 .. 4], (X, qs[1..3]));
            (ControlledOnBitString([true, false, false], ApplyToEachCA))(qs[0..1] + qs[4 .. 4], (X, qs[2..3]));
            (ControlledOnBitString([false, true, true], ApplyToEachCA))(qs[0..1] + qs[4 .. 4], (X, qs[2..3]));
            (ControlledOnBitString([true, true, false, false], ApplyToEachCA))(qs[0..2] + qs[4 .. 4], (X, qs[3..3]));
            (ControlledOnBitString([false, false, true, true], ApplyToEachCA))(qs[0..2] + qs[4 .. 4], (X, qs[3..3]));

        }
        Controlled ApplyToEachC(qs[0..0], (X, qs[1 .. N - 1]));
        H(qs[0]);
        Controlled ApplyToEachC(qs[0..0], (X, qs[1 .. N - 1]));        
    }
}