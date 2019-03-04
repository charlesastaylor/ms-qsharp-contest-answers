namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    // Circuit: https://algassert.com/quirk#circuit=%7B%22cols%22%3A%5B%5B%22Counting3%22%5D%2C%5B%22Amps3%22%5D%2C%5B%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%97%A6%22%2C%22%E2%80%A2%22%2C%22X%22%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%80%A2%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B1%2C%22X%22%2C%22X%22%2C%22%E2%80%A2%22%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%97%A6%22%2C%22%E2%80%A2%22%2C%22X%22%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%80%A2%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B%22%E2%80%A6%22%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B%22%E2%80%A2%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B%22%E2%80%A6%22%5D%2C%5B%22H%22%2C%22H%22%2C%22%E2%80%A2%22%5D%2C%5B%22H%22%2C%22%E2%80%A2%22%2C%22%E2%97%A6%22%5D%2C%5B%22H%22%2C%22%E2%97%A6%22%2C%22%E2%97%A6%22%5D%2C%5B%22%E2%80%A6%22%5D%2C%5B%22%E2%97%A6%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B%22%E2%80%A2%22%2C%22%E2%97%A6%22%2C%22X%22%5D%2C%5B%22Amps3%22%2C1%2C1%2C%22Amps1%22%5D%5D%7D
    operation Solve_D5 (qs : Qubit[]) : Unit {

        using(anc = Qubit[1]) {
            (ControlledOnBitString([false, false, true], X))(qs, anc[0]);
            (ControlledOnBitString([false, true, false], X))(qs, anc[0]);
            CNOT(anc[0], qs[1]);
            CNOT(anc[0], qs[2]);
            (ControlledOnBitString([false, false, true], X))(qs, anc[0]);
            (ControlledOnBitString([false, true, false], X))(qs, anc[0]);
        }
        
        (ControlledOnBitString([false, false], X))(qs[0..1], qs[2]);
        (ControlledOnBitString([true, false], X))(qs[0..1], qs[2]);

        Controlled ApplyToEachC(qs[2..2], (H, qs[0..1]));
        (ControlledOnBitString([true, false], H))(qs[1..2], qs[0]);
        (ControlledOnBitString([false, false], H))(qs[1..2], qs[0]);

        (ControlledOnBitString([false, false], X))(qs[0..1], qs[2]);
        (ControlledOnBitString([true, false], X))(qs[0..1], qs[2]);

    }
}