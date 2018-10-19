import turicreate as tc

#Load SFrame data...
data = tc.SFrame("appleVSorange.sframe")

#Split the data...
train_data, test_data = data.random_split(0.8)

#Create the model...
model = tc.image_classifier.create(train_data,target = "label")

predicts = model.predict(test_data)

metrics = model.evaluate(test_data)

print(metrics["accuracy"])

model.save("FruitClassifierModel.model")

#Export to mlmodel format...
model.export_coreml("AppleOrangeClassifier.mlmodel")
