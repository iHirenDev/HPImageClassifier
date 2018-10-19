import turicreate as tc

#Convert training data into SFrame...
data = tc.image_analysis.load_images("trainingData", with_path = True)

#Set the lable for data
data["label"] = data["path"].apply(lambda path:"apple" if "apple" in path else "orange")

data.save("appleVSorange.sframe")



data.explore()
