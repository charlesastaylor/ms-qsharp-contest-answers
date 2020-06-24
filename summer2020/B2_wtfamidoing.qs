// namespace Solution {
//     open Microsoft.Quantum.Intrinsic;
//     open Microsoft.Quantum.Arithmetic;
//     open Microsoft.Quantum.Diagnostics;
//     open Microsoft.Quantum.Arrays;
//     open Microsoft.Quantum.Canon;

//     operation AddI (xs: LittleEndian, ys: LittleEndian) : Unit is Adj + Ctl {
//         if (Length(xs!) == Length(ys!)) {
//             RippleCarryAdderNoCarryTTK(xs, ys);
//         }
//         elif (Length(ys!) > Length(xs!)) {
//             using (qs = Qubit[Length(ys!) - Length(xs!) - 1]){
//                 RippleCarryAdderTTK(LittleEndian(xs! + qs),
//                                     LittleEndian(Most(ys!)), Tail(ys!));
//             }
//         }
//         else {
//             fail "xs must not contain more qubits than ys!";
//         }
//     }

//     operation DivideI (xs: LittleEndian, ys: LittleEndian,
//                                result: LittleEndian) : Unit {
//         body (...) {
//             (Controlled DivideI) (new Qubit[0], (xs, ys, result));
//         }
//         controlled (controls, ...) {
//             let n = Length(result!);

//             EqualityFactI(n, Length(ys!), "Integer division requires
//                            equally-sized registers ys and result.");
//             EqualityFactI(n, Length(xs!), "Integer division
//                             requires an n-bit dividend registers.");
//             AssertAllZero(result!);

//             let xpadded = LittleEndian(xs! + result!);

//             for (i in (n-1)..(-1)..0) {
//                 let xtrunc = LittleEndian(xpadded![i..i+n-1]);
//                 (Controlled CompareGTI) (controls, (ys, xtrunc, result![i]));
//                 // if ys > xtrunc, we don't subtract:
//                 (Controlled X) (controls, result![i]);
//                 (Controlled Adjoint AddI) ([result![i]], (ys, xtrunc));
//             }
//         }
//         adjoint auto;
//         adjoint controlled auto;
//     }

//     operation CompareGTI (xs: LittleEndian, ys: LittleEndian,
//                             result: Qubit) : Unit is Adj + Ctl {
//         GreaterThan(xs, ys, result);
//     }

//     operation MultiplyI (xs: LittleEndian, ys: LittleEndian,
//                          result: LittleEndian) : Unit {
//         body (...) {
//             let n = Length(xs!);

//             EqualityFactI(n, Length(ys!), "Integer multiplication requires
//                            equally-sized registers xs and ys.");
//             EqualityFactI(2 * n, Length(result!), "Integer multiplication
//                             requires a 2n-bit result registers.");
//             AssertAllZero(result!);

//             for (i in 0..n-1) {
//                 (Controlled AddI) ([xs![i]], (ys, LittleEndian(result![i..i+n])));
//             }
//         }
//         controlled (controls, ...) {
//             let n = Length(xs!);

//             EqualityFactI(n, Length(ys!), "Integer multiplication requires
//                            equally-sized registers xs and ys.");
//             EqualityFactI(2 * n, Length(result!), "Integer multiplication
//                             requires a 2n-bit result registers.");
//             AssertAllZero(result!);

//             using (anc = Qubit()) {
//                 for (i in 0..n-1) {
//                     (Controlled CNOT) (controls, (xs![i], anc));
//                     (Controlled AddI) ([anc], (ys, LittleEndian(result![i..i+n])));
//                     (Controlled CNOT) (controls, (xs![i], anc));
//                 }
//             }
//         }
//         adjoint auto;
//         adjoint controlled auto;
//     }

//     operation Solve_wtfamidoing (inputs : Qubit[], output : Qubit) : Unit is Adj+Ctl {
//         // operation DivideI (xs : Microsoft.Quantum.Arithmetic.LittleEndian,
//         //                    ys : Microsoft.Quantum.Arithmetic.LittleEndian,
//         //                result : Microsoft.Quantum.Arithmetic.LittleEndian) : Unit

//         // operation MultiplyI (xs : Microsoft.Quantum.Arithmetic.LittleEndian,
//         //                      ys : Microsoft.Quantum.Arithmetic.LittleEndian,
//         //                  result : Microsoft.Quantum.Arithmetic.LittleEndian) : Unit
//         let N = Length(inputs);
//         using ((ys, result) = (Qubit[N], Qubit[N])) {
//             let inputs_le = LittleEndian(inputs);
//             X(ys[0]);
//             X(ys[1]);
//             let ys_le = LittleEndian(ys);
//             let result_le = LittleEndian(result);
//             DivideI(inputs_le, ys_le, result_le);
//             (ControlledOnInt(0, X)) (inputs, output);
//             // MultiplyI(ys_le, inputs_le, ys_le, result_le); 
//             // AddI
//         }


//         // for (i in 0..3..2^N - 1) { // ***TOO SLOW***!!
//         //     (ControlledOnInt(i, X)) (inputs, output);
//         // }
//     }
// }
