import json

if __name__ == "__main__":
    with open('training_data2.json') as f:
        data = json.load(f)
    idx = 150
    data['TrainingData'] = {
        "Features": data["Features"][:idx],
        "Labels": data["Labels"][:idx]
    }
    data['ValidationData'] = {
        "Features": data["Features"][idx:],
        "Labels": data["Labels"][idx:]
    }