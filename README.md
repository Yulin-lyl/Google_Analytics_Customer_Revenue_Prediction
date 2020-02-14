# Google_Analytics_Customer_Revenue_Prediction

This project aims to help Google Analytics predict the revenue of small business so that they can identify potential customers.

Structure of Analysis:
1. data cleaning and transformation
 - flatten json
 - transform categorical data into numerical ones
 - deal with missing values
2. feature engineering
 - drop features
 - feature selection (lightBGM, XGBoost, Random Forest)
 - feature aggregation (convert visit to visitor and make data tidy)
3. data split by time frame
 - split train and validation data based on the time structure of test data
4. model selection and hyperparameter tuning
 - use lightGBM and XGBoost to train and test the data
 - try two ways of doing modeling (classification + regression, regression)

The model performance ranks high and the score is 0.88461. The best score in this competition is 0.88140.

Future Improvement: The most important improvement is to get the model compatible with streaming data. It is not very efficient to train the model again and again once new data comes in, but I only want to make prediction on the new part and update our existing results. If that is viable, the next step is to detect decaying model. Streaming data will vary from day to day, which means that the good model today might not perform as well tomorrow. Thus, it is necessary to develop certain metrics to track model performance and warn us once it decays. Then I can modify the model and ensure that it remains well functional.
