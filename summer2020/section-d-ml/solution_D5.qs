// This file is submitted by the participant
namespace Solution {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.MachineLearning;
    open Microsoft.Quantum.Math;

    // The operation that the participant has to implement
    // Has to return three things: 
    //  1) the feature engineering to perform (as an index in the array of feature engineering functions and an array of parameters to be used with it)
    //  2) circuit structure (as an array of ControlledRotation)
    //  3) and training results (circuit parameters + bias)
    //
    // The features engineering is built-in and cannot be tweaked by the participant's solution, only chosen from the list 
    // (see quantum-checker.qs for the list of available feature engineering functions)
    //
    operation Solve_D5 () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        let classifierStructure = CombinedStructure([
            LocalRotationsLayer(3, PauliY),
            CyclicEntanglingLayer(3, PauliY, 1),
            LocalRotationsLayer(3, PauliY),
            CyclicEntanglingLayer(3, PauliY, 2),
            PartialRotationsLayer([1, 2], PauliY)
        ]);

// Training complete, found optimal parameters: [5.811951866610344,2.8540262497437103,4.239545468778652,3.872445634200877,5.012427530549634,3.803525457285052,5.589686970459472,1.7847587222628245,4.718761260310533,0.2587351014005666,0.5226432645554844,5.298554233474754,3.287001553654792,4.7717210410984485],
// 0.023655211588447633 with 2 misses
        let pre = (1, [0.354, 0.354, 0.354, 0.354, 0.354, 0.354]);
        let paramaters = [5.811951866610344,2.8540262497437103,4.239545468778652,3.872445634200877,5.012427530549634,3.803525457285052,5.589686970459472,1.7847587222628245,4.718761260310533,0.2587351014005666,0.5226432645554844,5.298554233474754,3.287001553654792,4.7717210410984485];
        let bias = 0.023655211588447633;
        return (pre, 
                classifierStructure,
                (paramaters, bias));
        
    }
}

