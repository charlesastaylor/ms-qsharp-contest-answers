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
    operation Solve () : ((Int, Double[]), ControlledRotation[], (Double[], Double)) {
        // let classifierStructure = CombinedStructure([
        //         LocalRotationsLayer(2, PauliY),
        //         CyclicEntanglingLayer(2, PauliY, 1),
        //         PartialRotationsLayer([1], PauliY)
        //     ]);

        // let classifierStructure = [
        //     ControlledRotation((0, new Int[0]), PauliX, 4),
        //     ControlledRotation((0, new Int[0]), PauliZ, 5),
        //     ControlledRotation((1, new Int[0]), PauliX, 6),
        //     ControlledRotation((1, new Int[0]), PauliZ, 7),
        //     ControlledRotation((0, [1]), PauliX, 0),
        //     ControlledRotation((1, [0]), PauliX, 1),
        //     ControlledRotation((1, new Int[0]), PauliZ, 2),
        //     ControlledRotation((1, new Int[0]), PauliX, 3)
        // ];

        // // D4 Custom
        // let classifierStructure = [
        //     ControlledRotation((0, new Int[0]), PauliX, 4),
        //     ControlledRotation((0, new Int[0]), PauliZ, 5),
        //     ControlledRotation((1, new Int[0]), PauliX, 6),
        //     ControlledRotation((1, new Int[0]), PauliZ, 7),
        //     ControlledRotation((0, [1]), PauliX, 0),
        //     ControlledRotation((1, [0]), PauliX, 1),
        //     ControlledRotation((0, new Int[0]), PauliZ, 2),
        //     ControlledRotation((0, new Int[0]), PauliX, 3),
        //     ControlledRotation((1, new Int[0]), PauliZ, 8),
        //     ControlledRotation((1, new Int[0]), PauliX, 9)
        // ];

        // D4 Custom n = 3 ys
        let classifierStructure = [
            ControlledRotation((0, new Int[0]), PauliY, 6),
            ControlledRotation((1, new Int[0]), PauliY, 7),
            ControlledRotation((2, new Int[0]), PauliY, 8),
            ControlledRotation((0, [2]), PauliY, 0),
            ControlledRotation((1, [0]), PauliY, 1),
            ControlledRotation((2, [1]), PauliY, 2),
            ControlledRotation((1, [2]), PauliY, 3),
            ControlledRotation((0, [1]), PauliY, 4),
            ControlledRotation((2, [0]), PauliY, 5),
            ControlledRotation((2, new Int[0]), PauliY, 9)
        ];

// Training complete, found optimal parameters: [5.065965559316054,3.389238116140529,1.5587461804910145,5.499934147604832,3.0627514398650146], -0.13142520703131882 with 9 misses
        // let pre = (3, [1.]);
        // let paramaters = [5.065965559316054,3.389238116140529,1.5587461804910145,5.499934147604832,3.0627514398650146];
        // let bias = -0.13142520703131882;
// Training complete, found optimal parameters: [6.081291241533705,1.820874228771819,2.870863665056249,4.236431122340136,5.9093257900475304], -0.06554673029840949 with 14 misses
        // let pre = (3, [1.]);
        // let paramaters = [6.081291241533705,1.820874228771819,2.870863665056249,4.236431122340136,5.9093257900475304];
        // let bias = -0.06554673029840949;
// Training complete, found optimal parameters: [6.246249804863535,1.8273634409942616,2.8705765786897435,4.236007479227902,5.930097162156028], -0.016789614699023098 with 18 misses
        // let pre = (3, [1.]);
        // let paramaters = [6.246249804863535,1.8273634409942616,2.8705765786897435,4.236007479227902,5.930097162156028];
        // let bias = -0.016789614699023098;
// Training complete, found optimal parameters: [6.168191241533705,1.9077742287718191,2.870863665056249,4.236431122340136,5.99622579004753], -0.03878108091477092 with 24 misses
        // let pre = (3, [1.]);
        // let paramaters = [6.168191241533705,1.9077742287718191,2.870863665056249,4.236431122340136,5.99622579004753];
        // let bias = -0.03878108091477092;
// Training complete, found optimal parameters: [2.648373181175108,3.725591472379853,1.8440418621425427,0.12023959330538019,2.1894788094088087], -0.024202897383086834 with 24 misses
        // let pre = (3, [1.]);
        // let paramaters = [2.648373181175108,3.725591472379853,1.8440418621425427,0.12023959330538019,2.1894788094088087];
        // let bias = -0.024202897383086834;
// Training complete, found optimal parameters: [3.480269557181258,4.663014620227351,8.511765246973651,3.275715458708993,9.5317374673231,7.955975289576789,6.4253549469116775,6.203433743293298], 0.03200241623239101 with 18 misses
        // let pre = (4, [1., -1.]);
        // let paramaters = [3.480269557181258,4.663014620227351,8.511765246973651,3.275715458708993,9.5317374673231,7.955975289576789,6.4253549469116775,6.203433743293298];
        // let bias = 0.03200241623239101;
// Training complete, found optimal parameters: [3.480965715514704,4.7581685219101955,8.645196589341019,3.1474901555508628,9.668561332668936,7.818425281946432,6.282076274489214,6.3161049727916385], -0.05119764151909982 with 16 misses
        // let pre = (4, [1., -1.]);
        // let paramaters = [3.480965715514704,4.7581685219101955,8.645196589341019,3.1474901555508628,9.668561332668936,7.818425281946432,6.282076274489214,6.3161049727916385];
        // let bias = -0.05119764151909982;
// Training complete, found optimal parameters: [3.480965715514704,4.7581685219101955,8.70650908934102,3.1736464055508633,9.601905082668935,7.8797377819464325,6.308232524489214,6.342261222791639], -0.041900614513306886 with 14 misses
        // let pre = (4, [1., -1.]);
        // let pre = (4, [1.077777777777778, -1.0555555555555556]); // passed locally failed oline
        // let pre = (4, [1.077777777777778, -1.0333333333333334]); // passed locally failed online
        // let pre = (4, [1.1, -1.077777777777778]); // passed locally failed online
        // let pre = (4, [1.1, -1.0555555555555556]); // 
        // let paramaters = [3.480965715514704,4.7581685219101955,8.70650908934102,3.1736464055508633,9.601905082668935,7.8797377819464325,6.308232524489214,6.342261222791639];
        // let bias = -0.041900614513306886;
// Training complete, found optimal parameters: [3.480965715514704,4.7581685219101955,8.564021589341015,3.2711151555508544,9.587386332668933,7.975250281946426,6.252626274489203,6.357854972791629], -0.00452885678784381 with 8 misses
        // let pre = (4, [1., -1.]); // 
        // let paramaters = [3.480965715514704,4.7581685219101955,8.564021589341015,3.2711151555508544,9.587386332668933,7.975250281946426,6.252626274489203,6.357854972791629];
        // let bias = -0.00452885678784381;
// Training complete, found optimal parameters: [0.,4.710115778007425,8.695895205867965,3.364328917689718,9.813740455168212,7.819584325251481,6.513557097747564,6.444613169628237], -0.08642743485886994 with 18 misses
        // let pre = (4, [1., -1.]); // 
        // let paramaters = [0.,4.710115778007425,8.695895205867965,3.364328917689718,9.813740455168212,7.819584325251481,6.513557097747564,6.444613169628237];
        // let bias = -0.08642743485886994;

// D4 Custom
// Training complete, found optimal parameters: [3.1409643664750013,3.204418192060355,1.3799206679337979,0.4151689967283847,2.2021587722140934,3.2985756663322143,2.4566692675601804,-0.2694907510776696,6.139383895925457,2.4522802672751816], 0.04735113227739064 with 26 misses
        // let pre = (4, [1., -1.]);
        // let paramaters = [3.1409643664750013,3.204418192060355,1.3799206679337979,0.4151689967283847,2.2021587722140934,3.2985756663322143,2.4566692675601804,-0.2694907510776696,6.139383895925457,2.4522802672751816];
        // let bias = 0.04735113227739064;
// Training complete, found optimal parameters: [3.141592653589793,5.118780591959606,5.503345692731829,6.06716064235539,3.2873007527840947,10.027916915958723,9.608718657554299,7.981064492601618,9.15623333930787,4.698703156218947], -0.009581706107799511 with 30 misses
        // let pre = (4, [1., -1.]);
        // let paramaters = [3.141592653589793,5.118780591959606,5.503345692731829,6.06716064235539,3.2873007527840947,10.027916915958723,9.608718657554299,7.981064492601618,9.15623333930787,4.698703156218947];
        // let bias = -0.009581706107799511;

// D4 Custom n = 3 ys
// Training complete, found optimal parameters: [2.619576218918723,5.384432254707694,1.3502676449550648,4.55701330425737,0.7693503522669761,4.395377842931358,3.004781078642896,5.104129209394669,0.351976475458591,2.891136597758518], -0.0833579198132824 with 31 misses
        // let pre = (1, [0., 0.353, 0.353, 0.353, 0.353, 0.353]);
        // let paramaters = [2.619576218918723,5.384432254707694,1.3502676449550648,4.55701330425737,0.7693503522669761,4.395377842931358,3.004781078642896,5.104129209394669,0.351976475458591,2.891136597758518];
        // let bias = -0.0833579198132824;
// manually tweaking lol
        let pre = (1, [0., 0., 0., 0., 0.3, 0.3]);
        let paramaters = [3.6044908621217573,4.9157658869032295,4.338500781637337,5.167303114267877,0.23636764210777347,2.4417917393399917,0. ,2.2572489125567308,  3.3058205779995875, 5.4];
        let bias = -0.061849357878;
        return (pre, 
                classifierStructure,
                (paramaters, bias));
        
    }
}