import json
import sys

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors
import matplotlib.cm as cmx
plt.style.use('ggplot')

import qsharp
qsharp.packages.add("Microsoft.Quantum.MachineLearning::0.11.2004.2825")
qsharp.reload()

from Microsoft.Quantum.Problem import TestOperation, ClassifyModel, TrainModel, ValidateModel, TestOperation_params

from myhost import plot_data as pd
from myhost import finish_alert


# Plotting configuration
# We'll plot four cases:
# - actually 0, classified as 0
# - actually 0, classified as 1
# - actually 1, classified as 1
# - actually 1, classified as 0
cases = [(0, 0), (0, 1), (1, 1), (1, 0)]
markers = [
    '.' if actual == classified else 'X'
    for (actual, classified) in cases
]
colormap = cmx.ScalarMappable(colors.Normalize(vmin=0, vmax=len(cases) - 1))
colors = [colormap.to_rgba(idx_case) for (idx_case, case) in enumerate(cases)]
# colors = ['blue', 'blue', 'red', 'red']
figure_count = 1
def plot_data (features : list, actual_labels : list, classified_labels : list = None,
               extra_lines : list = None, normalize=False):
    """Plots the data, labeling it with actual labels if there are no classification results provided, 
    and with the classification results (indicating their correctness) if they are provided.
    """
    samples = np.array(features)
    print(samples)
    if normalize:
        norms = np.linalg.norm(samples, axis=1)
        l=[]
        for i, s in enumerate(samples):
            l.append(s/norms[i])
        samples = np.array(l)
        
    plt.figure(figsize=(8, 8))
    for (idx_case, ((actual, classified), marker, color)) in enumerate(zip(cases, markers, colors)):
        mask = np.logical_and(np.equal(actual_labels, actual), 
                              np.equal(actual if classified_labels == None else classified_labels, classified))
        if not np.any(mask): continue
        plt.scatter(
            samples[mask, 0], samples[mask, 1],
            label = f"Class {actual}" if classified_labels == None else f"Was {actual}, classified {classified}",
            marker = marker, s = 300, c = [color],
        )
    # Add the lines to show the true classes boundaries, if provided
    if extra_lines != None:
        for line in extra_lines:
            plt.plot(line[0], line[1], color = 'gray')
    plt.legend()

if __name__ == "__main__":
    # fname = 'training_data1.json'
    # fname = 'training_data2.json'
    # fname = 'training_data3.json'
    # fname = 'training_data4.json'
    # fname = 'training_data5.json'
    fname = 'training_data6.json'
    # fname = 'training_data7.json'
    # fname = "mytrainingdata.json"
    with open(fname) as f:
        data = json.load(f)
    feats = data["Features"]
    labels = data["Labels"]

    FUDGE = len(sys.argv) > 1
    if FUDGE:
        mode = 1
        winners = []
        # let pre = (4, [1., -1.]);
        # for ps in [
        #     [1.0555555555555556, -1.011111111111111],
        #     [1.077777777777778, -1.0555555555555556],
        #     [1.077777777777778, -1.0333333333333334],
        #     [1.077777777777778, -0.9888888888888889],
        #     [1.1, -1.077777777777778],
        #     [1.1, -1.0555555555555556]
        # ]:
        #     b = TestOperation_params.simulate(features=feats, labels=labels, 
        #         engineeringMode=mode, engineeringParameters=ps)
        #     print(f'x: {ps[0]}, y: {ps[1]}, {"WINNER WINNER" if b else "fail"}')
        #     if (b):
        #         winners.append(ps)
        min_ = float("inf")
        min_params = None
        for x in np.linspace(0.2, 0.3, 10):
            for y in np.linspace(0.2, 0.3, 10):
                ps = [x, y]
                ps = [0., 0., 0., 0., x, y]
                b, error_rate = TestOperation_params.simulate(features=feats, labels=labels, 
                engineeringMode=mode, engineeringParameters=ps)
                print(f"Error rate: {error_rate}")
                print(f'x: {x}, y: {y}, {"WINNER WINNER" if b else "fail"}')
                min_ = min(min_, error_rate)
                if (b):
                    if error_rate == min_:
                        min_params = (x,y)
                    winners.append(ps)
        print(winners)
        print(f"min error rate: {error_rate}, with params {min_params}")

    else: 
        b = TestOperation.simulate(features=feats, labels=labels)
        print("Fuck yeah boi!" if b else "you suck")
    finish_alert()
