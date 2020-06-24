import random
import json
from typing import List

import numpy as np
from matplotlib import pyplot
pyplot.style.use('ggplot')

# import warnings
# warnings.simplefilter('ignore')

# Plotting configuration
cases = [(0, 0), (0, 1), (1, 1), (1, 0)]
markers = [
    '.' if actual == classified else 'X'
    for (actual, classified) in cases
]
colors = ['blue', 'blue', 'red', 'red']


def plot_data (features : list, actual_labels : list, classified_labels : list = None, extra_lines : list = None):
    """Plots the data, labeling it with actual labels if there are no classification results provided, 
    and with the classification results (indicating their correctness) if they are provided.
    """
    samples = np.array(features)
    pyplot.figure(figsize=(8, 8))
    for (idx_case, ((actual, classified), marker, color)) in enumerate(zip(cases, markers, colors)):
        mask = np.logical_and(np.equal(actual_labels, actual), 
                              np.equal(actual if classified_labels == None else classified_labels, classified))
        if not np.any(mask): continue
        pyplot.scatter(
            samples[mask, 0], samples[mask, 1],
            label = f"Class {actual}" if classified_labels == None else f"Was {actual}, classified {classified}",
            marker = marker, s = 300, c = [color],
        )
    # Add the lines to show the true classes boundaries, if provided
    if extra_lines != None:
        for line in extra_lines:
            pyplot.plot(line[0], line[1], color = 'gray')
    pyplot.legend()

    
def separation_endpoint (angle : float) -> (float, float):
    if (angle < math.pi / 4):
        return (1, math.tan(angle))
    return (1/math.tan(angle), 1)

# Set up lines that show class separation
# separation_lines = list(zip([(0,0), (0,0)], list(map(separation_endpoint, separation_angles))))
# extra_lines = []
# for line in separation_lines:
#     extra_lines.append([[line[0][0], line[1][0]], [line[0][1], line[1][1]]])

    


if __name__ == "__main__":
    indicies = [6]
    # indicies = list(range(3,8))
    for idx in indicies:
        fname = f'training_data{idx}.json'
        with open(fname) as f:
            data = json.load(f)
        # 400 data points
        idx = 400
        feats = data["Features"]
        labels = data["Labels"]
        extra_lines = []
        extra_lines.append([[-1., 1.], [-1., 1.]])
        extra_lines.append([[-1., 1.], [1., -1.]])
        plot_data(feats, labels, extra_lines = extra_lines)
        # print(len(feats))
        # new_feats = []
        # for i, feat in enumerate(feats):
        #     if labels[i] == 1:
        #         new_feats.append([feat[0], -feat[1]])
        # feats += new_feats
        # labels += [1] * len(new_feats)
        # plot_data(feats, labels)

    #     # art_feats, art_labels = [], []
    #     # r = 0.25
    #     # for x in np.linspace(-1, 1, 40):
    #     #     for y in np.linspace(-1, 1, 40):
    #     #         p = [x, y]
    #     #         l = 1 if x**2 - y**2 < -r**2 else 0
    #     #         art_feats.append(p)
    #     #         art_labels.append(l)
    #     # with open("mytrainingdata1600.json", "w") as f:
    #     #     json.dump({"Features": art_feats, "Labels": art_labels}, f)
    #     # plot_data(art_feats, art_labels, extra_lines = extra_lines)
    # valid_fname = "mytrainingdata1600.json"
    # with open(valid_fname) as f:
    #     data = json.load(f)
    # r = 0.25
    # valid_feats = data["Features"]
    # valid_labels = data["Labels"]
    # near_boundary = []
    # for i in range(len(valid_feats)):
    #     x, y = valid_feats[i]
    #     print(x, y, x**2 - y**2 + r**2)
    #     if -0.1 < x**2 - y**2 + r**2 < 0.1:
    #         near_boundary.append(i)
    # print(len(near_boundary))
    # boundary_feats = [valid_feats[i] for i in near_boundary]
    # boundary_labels = [valid_labels[i] for i in near_boundary]

    # plot_data(valid_feats, valid_labels)
    # plot_data(boundary_feats, boundary_labels)

    pyplot.show()
    