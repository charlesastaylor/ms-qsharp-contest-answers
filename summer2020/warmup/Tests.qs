// namespace ms_sharp_clean {
    
//     open Microsoft.Quantum.Canon;
//     open Microsoft.Quantum.Diagnostics;
//     open Microsoft.Quantum.Intrinsic;
//     open Microsoft.Quantum.Arithmetic;
    
//     // open Solution

//     @Test("QuantumSimulator")
//     operation AllocateQubit () : Unit {
        
//         using (q = Qubit()) {
//             Assert([PauliZ], [q], Zero, "Newly allocated qubit must be in |0> state.");
//         }
        
//         Message("Test passed.");
//     }

//     // @Test("QuantumSimulator")
//     // operation RunTest () : Unit {
//     //     using (qs = Qubit[5]) {
//     //         let le = LittleEndian(qs);
//     //         let res = Solution.Solve(le);
//     //         ResetAll(qs);
//     //     }
//     //     Message("Test passed.");
//     // }
// }




// // Failing tests use Fact or Assert eg:
// // Fact(false, "false");