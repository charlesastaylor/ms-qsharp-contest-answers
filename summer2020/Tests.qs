namespace ms_sharp_clean {
    
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Arrays;
    open Solution;

    // Quantum Katas utils start //

    /// # Summary
    /// Returns how many times a given oracle is executed.
    /// # Input
    /// ## oracle
    /// The operation whose call count is being requested.
    operation GetOracleCallsCount<'T> (oracle : 'T) : Int { body intrinsic; }
    
    /// # Summary
    /// Resets the variable that tracks how many times an oracle
    /// is executed back to 0.
    operation ResetOracleCallsCount () : Unit { body intrinsic; }


    /// # Summary
    /// Returns the max number of qubits allocated at any given point by the simulator.
    operation GetMaxQubitCount () : Int { body intrinsic; }

    /// # Summary
    /// Resets the variable that tracks the max number of qubits
    /// allocated at any given point by the simulator.
    operation ResetQubitCount () : Unit { body intrinsic; }


    /// # Summary
    /// Returns the number of multi-qubit operations used by the simulator.
    operation GetMultiQubitOpCount () : Int { body intrinsic; }
    
    // **** Quantum Katas utils end **** //

    // **** Quantum katas distinguisih unitarss test hardness start **** //

    // "Framework" operation for testing tasks for distinguishing unitaries
    // "unitaries" is the list of unitaries that can be passed to the task
    // "testImpl" - the solution to be tested
    // "maxCalls" - max # of calls to the unitary that are allowed (-1 means unlimited)
    operation DistinguishUnitaries_Framework<'UInput> (
        unitaries : ('UInput => Unit is Adj+Ctl)[], 
        testImpl : (('UInput => Unit is Adj+Ctl) => Int),
        maxCalls : Int) : Unit {

        let nUnitaries = Length(unitaries);
        let nTotal = 100;
        mutable wrongClassifications = new Int[nUnitaries * nUnitaries]; // [i * nU + j] number of times unitary i was classified as j
        mutable unknownClassifications = new Int[nUnitaries];            // number of times unitary i was classified as something unknown
        
        for (i in 1 .. nTotal) {
            // get a random integer to define the unitary used
            let actualIndex = RandomInt(nUnitaries);
            
            ResetOracleCallsCount();

            // get the solution's answer and verify that it's a match
            let returnedIndex = testImpl(unitaries[actualIndex]);

            // check the constraint on the number of allowed calls to the unitary
            // note that a unitary can be implemented as Controlled on |1⟩, so we need to count variants as well
            if (maxCalls > 0) {
                let actualCalls = GetOracleCallsCount(unitaries[actualIndex]) + 
                                  GetOracleCallsCount(Adjoint unitaries[actualIndex]) + 
                                  GetOracleCallsCount(Controlled unitaries[actualIndex]);
                if (actualCalls > maxCalls) {
                    fail $"You are allowed to do at most {maxCalls} calls, and you did {actualCalls}";
                }
            }
            
            if (returnedIndex != actualIndex) {
                if (returnedIndex < 0 or returnedIndex >= nUnitaries) {
                    set unknownClassifications w/= actualIndex <- unknownClassifications[actualIndex] + 1;
                } else {
                    let index = actualIndex * nUnitaries + returnedIndex;
                    set wrongClassifications w/= index <- wrongClassifications[index] + 1;
                }
            }
        }
        
        mutable totalMisclassifications = 0;
        for (i in 0 .. nUnitaries - 1) {
            for (j in 0 .. nUnitaries - 1) {
                let misclassifiedIasJ = wrongClassifications[(i * nUnitaries) + j];
                if (misclassifiedIasJ != 0) {
                    set totalMisclassifications += misclassifiedIasJ;
                    Message($"Misclassified {i} as {j} in {misclassifiedIasJ} test runs.");
                }
            }
            if (unknownClassifications[i] != 0) {
                set totalMisclassifications += unknownClassifications[i];
                Message($"Misclassified {i} as unknown unitary in {unknownClassifications[i]} test runs.");
            }
        }
        // This check will tell the total number of failed classifications
        Fact(totalMisclassifications == 0, $"{totalMisclassifications} test runs out of {nTotal} returned incorrect state.");
    }

    // **** Quantum katas distinguisih unitarss test hardness start **** //

    // @Test("QuantumSimulator")
    // operation RunTest () : Unit {
    //     // Message("Inputs:");
    //     // DumpRegister((), inputs);
    //     // Message("\nOutput:");
    //     // DumpRegister((), [output]);

    //     // Solve(inputs, output);

    //     // Message("\nAll:");
    //     // DumpMachine(());
    //     // ResetAll(inputs);
    //     // Reset(output);

    //     let no_trials = 100;
    //     for (i in 1..no_trials-1) {
    //         let theta = (IntAsDouble(i) / IntAsDouble(no_trials)) * PI();
    //         let ans = Solve(1., Rz(1., _));
    //         Message($"Unitary: Rz, Theta: {theta}, ans: {ans}");
    //     }
    //     for (i in 1..no_trials-1) {
    //         let theta = (IntAsDouble(i) / IntAsDouble(no_trials)) * PI();
    //         let ans = Solve(1., Ry(1., _));
    //         Message($"Unitary: Ry, Theta: {theta}, ans: {ans}");
    //     }
    //     for (theta in [0.01 * PI(), 0.99 * PI()]) {
    //         let ans = Solve(1., Rz(1., _));
    //         Message($"Unitary: Rz, Theta: {theta}, ans: {ans}");
    //     }
    //     for (theta in [0.01 * PI(), 0.99 * PI()]) {
    //         let ans = Solve(1., Ry(1., _));
    //         Message($"Unitary: Ry, Theta: {theta}, ans: {ans}");
    //     }

    // }

    @Test("QuantumSimulator")
    operation TestTest () : Unit {
        let theta = 0.5 * PI();
        DistinguishUnitaries_Framework([Rz(theta, _), Ry(theta, _)],
            Solve(theta, _),
            -1
        );
        Message("Testtest complete");
    }
}




// // Failing tests use Fact or Assert eg:
// // Fact(false, "false");