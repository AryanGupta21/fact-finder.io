from flask import Flask, request, jsonify
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
import os

app = Flask(__name__)

# Load true news dataset
true_df = pd.read_csv('True.csv')
true_df['label'] = 0  # Label true news as 0

# Load fake news dataset
fake_df = pd.read_csv('Fake.csv')
fake_df['label'] = 1  # Label fake news as 1

# Combine the datasets
df = pd.concat([true_df, fake_df], ignore_index=True)

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(df['text'], df['label'], test_size=0.2, random_state=42)

# Train the model
model = make_pipeline(TfidfVectorizer(), MultinomialNB())
model.fit(X_train, y_train)

# Create an Excel writer object
output_file = 'news_predictions.xlsx'

# Check if the file exists to load existing data
if os.path.exists(output_file):
    existing_df = pd.read_excel(output_file)
    true_news = existing_df['True News'].dropna().tolist()
    fake_news = existing_df['Fake News'].dropna().tolist()
else:
    true_news = []
    fake_news = []


# API endpoint for predictions
@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    news_article = data.get('text')

    # Predict the class (True or Fake)
    prediction = model.predict([news_article])

    result = "true" if prediction[0] == 0 else "fake"

    # Categorize and save the news article
    if result == "true":
        true_news.append(news_article)
    else:
        fake_news.append(news_article)

    # Create a DataFrame to store the categorized news
    categorized_df = pd.DataFrame({
        'True News': pd.Series(true_news),
        'Fake News': pd.Series(fake_news)
    })

    # Write to an Excel file
    categorized_df.to_excel(output_file, index=False)

    return jsonify({"prediction": result})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
