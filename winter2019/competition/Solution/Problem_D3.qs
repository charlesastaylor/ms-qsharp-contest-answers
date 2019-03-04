namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Solve_D3_noancillia (qs : Qubit[]) : Unit {
        let N = Length(qs);
        for (q in qs[1 .. N - 1]) {
            CNOT(qs[0], q);
        }
        H(qs[0]);        
        for (q in qs[1 .. N - 1]) {
            CNOT(qs[0], q);
        }
    }

    
    // Circuits
    // N = 2: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting2%22],[%22Amps2%22],[],[%22%E2%80%A6%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22X%22,1,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A6%22],[1,%22H%22],[%22X%22,%22%E2%80%A2%22],[%22%E2%80%A6%22],[%22Amps2%22,1,%22Amps2%22]],%22gates%22:[{%22id%22:%22~egm%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~rv4f%22,%22name%22:%22w%22,%22matrix%22:%22{{1,0},{0,-%C2%BD+%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~b300%22,%22name%22:%22w^2%22,%22matrix%22:%22{{1,0},{0,-%C2%BD-%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~p0b9%22,%22name%22:%22GA%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,%E2%88%9A%E2%85%93},{-%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22}]}
    // N = 3: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting3%22],[%22Amps3%22],[],[%22%E2%80%A6%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22X%22,%22X%22,1,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22],[%22%E2%80%A6%22],[%22%E2%80%A6%22],[1,1,%22H%22],[%22X%22,1,%22%E2%80%A2%22],[1,%22X%22,%22%E2%80%A2%22],[%22Amps3%22,1,1,%22Amps4%22]],%22gates%22:[{%22id%22:%22~egm%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~rv4f%22,%22name%22:%22w%22,%22matrix%22:%22{{1,0},{0,-%C2%BD+%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~b300%22,%22name%22:%22w^2%22,%22matrix%22:%22{{1,0},{0,-%C2%BD-%E2%88%9A%C2%BEi}}%22},{%22id%22:%22~p0b9%22,%22name%22:%22GA%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,%E2%88%9A%E2%85%93},{-%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22}]}
    operation Solve_D3_ancilla (qs : Qubit[]) : Unit {
    // Can cut down number of gates by combining pairs of opposite strings and
    // means can also do one big loop probs
        let N = Length(qs);
        let noAnc = 2^N / 2;
        let controlStrings = ControlStrings(N);
        using (anc = Qubit[1]) {
            for (i in 0 .. Length(controlStrings) - 1) {
                (ControlledOnBitString(controlStrings[i], X))(qs[0..N-1], anc[0]);
            }
            Controlled ApplyToEachC(anc[0..0], (X, qs[0 .. N - 2]));
            for (i in 0 .. Length(controlStrings) - 1) {
                (ControlledOnBitString(controlStrings[i], X))(qs[0..N-1], anc[0]);
            }
            H(qs[N - 1]);
            for (q in qs[0 .. N - 2]) {
                CNOT(qs[N-1], q);
            }
        }
    }

    function ControlStrings(N : Int) : Bool[][] {
        mutable strings = new Bool[][2^N / 2];
        for (i in 0 .. 2^N / 2 - 1) {
            set strings[i] = BoolArrFromPositiveInt(i + 2^N / 2, N);
        }
        return strings;
    }
}