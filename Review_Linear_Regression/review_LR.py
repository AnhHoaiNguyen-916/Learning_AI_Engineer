import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from sklearn import linear_model

df = pd.read_csv("https://content.codecademy.com/programs/data-science-path/linear_regression/honeyproduction.csv")
# Check the dataset:
print(df.head())

# Calculate the average total production per year: 
prod_per_year = df.groupby('year').totalprod.mean().reset_index()
print(prod_per_year)

# The x-values of scatterplot: Year
X = prod_per_year['year'].values.reshape(-1, 1)
print(X)
# The y-values of scatterplot: Avg. Total Production
y = prod_per_year['totalprod']
print(y)

# Draw the scatterplot out:
plt.scatter(X, y)
plt.show()

# Create a LinearRegression model:
regr = linear_model.LinearRegression()
regr.fit(X, y)

print(f"Slope of the best fit line: {regr.coef_}")
print(f"Intercept of the best fit line: {regr.intercept_}")

# Predict based on the X data:
y_predict = regr.predict(X)
plt.plot(X, y_predict)
plt.show()

# Give the prediction of honey production for the year 2050:
X_future = np.array(range(2013, 2051)).reshape(-1, 1)
print(X_future)

future_to_2050_predict = regr.predict(X_future)
print(future_to_2050_predict)
print(f"The total production in 2050: {future_to_2050_predict[-1]}")

plt.plot(X_future, future_to_2050_predict)
plt.show()