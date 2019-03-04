namespace Solution {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    // Circuits
    // N = 2: https://algassert.com/quirk#circuit={%22cols%22:[[%22Amps2%22],[],[%22H%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22H%22],[%22H%22,%22%E2%97%A6%22],[%22X%22],[%22%E2%80%A6%22],[%22Amps2%22]],%22gates%22:[{%22id%22:%22~rd14%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22}]}
    // N = 3: https://algassert.com/quirk#circuit={%22cols%22:[[%22Counting3%22],[%22Amps3%22],[],[%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[1,1,1,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[1,1,1,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22H%22,%22%E2%80%A2%22],[%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[1,1,1,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22H%22],[1,1,1,%22%E2%80%A6%22],[%22H%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22H%22,%22%E2%97%A6%22],[%22H%22,%22%E2%97%A6%22,%22%E2%97%A6%22],[%22%E2%80%A6%22],[%22X%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22Amps3%22]],%22gates%22:[{%22id%22:%22~rd14%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~vep6%22,%22name%22:%22XHX%22,%22circuit%22:{%22cols%22:[[%22X%22],[%22H%22],[%22X%22]]}}]}
    // N = 4: https://algassert.com/quirk#circuit={%22cols%22:[[%22Amps4%22,1,1,1,%22%E2%80%A6%22],[],[],[],[%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22H%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22H%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22H%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22],[%22%E2%97%A6%22,%22%E2%97%A6%22,%22H%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%97%A6%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22H%22,%22%E2%80%A6%22],[1,%22%E2%80%A6%22],[%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22H%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22%E2%97%A6%22,%22H%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22H%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22H%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22H%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22H%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A6%22],[%22%E2%80%A6%22],[%22X%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%97%A6%22],[%22%E2%80%A2%22,%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22X%22,%22%E2%97%A6%22,%22%E2%97%A6%22,%22%E2%80%A2%22],[%22X%22,%22%E2%80%A2%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22%E2%80%A2%22,%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22X%22,%22%E2%97%A6%22,%22%E2%80%A2%22,%22%E2%80%A2%22],[1,%22%E2%80%A6%22],[%22X%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A2%22,%22%E2%80%A6%22],[%22Amps4%22]],%22gates%22:[{%22id%22:%22~rd14%22,%22name%22:%22G%22,%22matrix%22:%22{{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93},{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94}}%22},{%22id%22:%22~vep6%22,%22name%22:%22XHX%22,%22circuit%22:{%22cols%22:[[%22X%22],[%22H%22],[%22X%22]]}},{%22id%22:%22~4h91%22,%22name%22:%22_%22,%22matrix%22:%22{{%E2%88%9A%E2%85%93,%E2%88%9A%E2%85%94},{%E2%88%9A%E2%85%94,-%E2%88%9A%E2%85%93}}%22},{%22id%22:%22~e0iq%22,%22name%22:%22_%22,%22matrix%22:%22{{%E2%88%9A%E2%85%95,%E2%88%9A%E2%85%98},{%E2%88%9A%E2%85%98,-%E2%88%9A%E2%85%95}}%22},{%22id%22:%22~tji0%22,%22name%22:%22H_9%22,%22matrix%22:%22{{%E2%88%9A%E2%85%92,0.9486833},{0.9486833,-%E2%88%9A%E2%85%92}}%22},{%22id%22:%22~ml28%22,%22name%22:%22H_4%22,%22matrix%22:%22{{%C2%BD,%E2%88%9A%C2%BE},{%E2%88%9A%C2%BE,-%C2%BD}}%22},{%22id%22:%22~juh0%22,%22name%22:%22H_9/10%22,%22matrix%22:%22{{0.9486833,%E2%88%9A%E2%85%92},{%E2%88%9A%E2%85%92,-0.9486833}}%22},{%22id%22:%22~jbb0%22,%22name%22:%22G_9/10%22,%22matrix%22:%22{{0.9486833,-%E2%88%9A%E2%85%92},{%E2%88%9A%E2%85%92,0.9486833}}%22}]}

    // TODO: work out how to generalise rather than hard coding for each N...
    operation Solve_D6 (qs : Qubit[]) : Unit {
        let N = Length(qs);
        if (N == 2) {
            Controlled H([qs[1]], qs[0]);
            Controlled H([qs[0]], qs[1]);
            (ControlledOnBitString([false], H))([qs[1]], qs[0]);
            X(qs[0]);
        } elif (N == 3) {
            // TODO: Don't need to use ControlledOnBitString when no anti controls
            Controlled H(qs[1..2], qs[0]);
            CCNOT(qs[0], qs[2], qs[1]);
            (ControlledOnBitString([true, true], H))(qs[1..2], qs[0]);
            (ControlledOnBitString([false, true], H))([qs[0]] + [qs[2]], qs[1]);
            CCNOT(qs[1], qs[2], qs[0]);
            (ControlledOnBitString([true, true], H))(qs[0..1], qs[2]);
            (ControlledOnBitString([true, false], H))(qs[1..2], qs[0]);
            (ControlledOnBitString([true, false], H))(qs[0..0] + qs[2..2], qs[1]);
            (ControlledOnBitString([false, false], H))(qs[1..2], qs[0]);

            (ControlledOnBitString([true, false], X))(qs[1..2], qs[0]);
            CCNOT(qs[0], qs[2], qs[1]);
            (ControlledOnBitString([false, true], X))(qs[1..2], qs[0]);
        } elif (N == 4) {
            // 16
            Controlled H(qs[1..3], qs[0]);
            // 15
            (ControlledOnBitString([false, true, true], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, true, true], H))(qs[1..3], qs[0]);
            // 14
            (ControlledOnBitString([false, true, true], H))(qs[0..0] + qs[2..3], qs[1]);
            // 13
            (ControlledOnBitString([false, false, true], X))(qs[0..1] + qs[3..3], qs[2]);
            (ControlledOnBitString([true, false, true], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, false, true], H))(qs[1..3], qs[0]);
            (ControlledOnBitString([true, false, true], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, false, true], X))(qs[0..1] + qs[3..3], qs[2]);
            // 12
            (ControlledOnBitString([false, true, true], X))(qs[0..1] + qs[3..3], qs[2]);
            (ControlledOnBitString([false, true, true], H))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, true, true], X))(qs[0..1] + qs[3..3], qs[2]);
            // 11
            (ControlledOnBitString([true, false, true], X))(qs[0..1] + qs[3..3], qs[2]);
            (ControlledOnBitString([false, true, true], H))(qs[1..3], qs[0]);
            (ControlledOnBitString([true, false, true], X))(qs[0..1] + qs[3..3], qs[2]);
            // 10
            (ControlledOnBitString([false, false, true], H))(qs[0..1] + qs[3..3], qs[2]);
            (ControlledOnBitString([false, true, true], X))(qs[0..0] + qs[2..3], qs[1]);
            Controlled X(qs[1..3], qs[0]);
            // 9
            Controlled H(qs[0..2], qs[3]);
            // 8
            (ControlledOnBitString([true, true, false], H))(qs[1..3], qs[0]);
            // 7
            (ControlledOnBitString([true, true, false], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([true, true, false], H))(qs[1..3], qs[0]);
            // 6
            (ControlledOnBitString([false, true, false], H))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([true, true, false], X))(qs[1..3], qs[0]);
            // 5
            (ControlledOnBitString([true, true, false], H))(qs[0..1] + qs[3..3], qs[2]);
            // 4
            (ControlledOnBitString([true, false, false], H))(qs[1..3], qs[0]);
            // 3
            (ControlledOnBitString([true, false, false], H))(qs[0..0] + qs[2..3], qs[1]);
            // 2
            (ControlledOnBitString([false, false, false], H))(qs[1..3], qs[0]);

            // Fix Rows
            // 2-8
            (ControlledOnBitString([true, false, false], X))(qs[1..3], qs[0]);
            (ControlledOnBitString([true, true, false], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, true, false], X))(qs[1..3], qs[0]);
            // 9-16?
            //
            Controlled X(qs[0..1] + qs[3..3], qs[2]);
            (ControlledOnBitString([true, false, true], X))(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, false, true], X))(qs[1..3], qs[0]);
            //
            (ControlledOnBitString([true, false, true], X))(qs[1..3], qs[0]);
            //
            Controlled X(qs[0..0] + qs[2..3], qs[1]);
            (ControlledOnBitString([false, true, true], X))(qs[1..3], qs[0]);
            Controlled X(qs[1..3], qs[0]);
        }
    }
}

// operation Solve__ (qs : Qubit[]) : Unit {
//     let N = Length(qs);
//     if (N == 2) {
//         using (anc = Qubit[2]) {
//             (ControlledOnBitString([true, false], X))(qs, anc[0]);
//             CNOT(qs[1], anc[1]);
//             Controlled H(anc[1..1], qs[1]);
//             H(qs[0]);
//             (ControlledOnBitString([false, true], H))([qs[0], anc[0]], qs[1]);
//         }
//     }
// }