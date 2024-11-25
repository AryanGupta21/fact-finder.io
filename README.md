Fact-Finder.io 🌐
A Flutter-based application with AI-powered news verification to combat misinformation.

Fact-Finder.io empowers users to verify the credibility of news articles. With a sleek chat interface, it connects to a Python backend powered by a machine-learning model that classifies news as either True or Fake.

🚀 Features
  AI-Powered News Verification
  Upload a news article or input text to verify its authenticity.
  Chat Interface
  User-friendly interface for seamless communication.
  Efficient Classification
  Utilizes TF-IDF and logistic regression for accurate classification.
  📱 Tech Stack
  Frontend: Flutter
  Backend: Python (FastAPI/Flask for API integration)
  Machine Learning:
  Libraries: pandas, scikit-learn
  Vectorization: TfidfVectorizer
  Model: Logistic Regression
  Database: SQLite or Firebase (for storing user queries and logs)
  Deployment:
  Backend: Hosted on AWS/GCP/Heroku
  Mobile App: Available on Android/iOS
  🛠️ Installation
      Frontend Setup
      Install Flutter from Flutter's Official Site.
        Clone the repository:
          git clone https://github.com/<your-username>/fact-finder.io.git  
          cd fact-finder.io  
      Install dependencies:
          flutter pub get  
      Run the app:
          flutter run  
      Backend Setup
        Install Python (>= 3.8).
        Set up a virtual environment:
          python -m venv env  
          source env/bin/activate # On Windows: env\Scripts\activate  
      Install required libraries:
          pip install -r backend/requirements.txt  
      Start the server:
          python backend/app.py  
      Connecting Frontend and Backend
        Update the API endpoint in the Flutter app (e.g., base_url in your services file).
        Ensure the backend server is running and accessible to the frontend.
📂 Project Structure
    fact-finder.io/  
    ├── backend/  
    │   ├── app.py            # FastAPI/Flask application  
    │   ├── model/            # Machine learning models and preprocessing scripts  
    │   ├── requirements.txt  # Backend dependencies  
    ├── frontend/  
    │   ├── lib/              # Flutter app source code  
    │   ├── pubspec.yaml      # Flutter dependencies  
    ├── README.md             # Project documentation  
🧪 Testing
    Run unit tests for the backend:
    pytest  
    Use flutter test for frontend testing.
🛡️ Security & Privacy
    Fact-Finder.io ensures user data is encrypted and processed securely. No data is stored permanently without user consent.

👩‍💻 Contributors
    Aryan Gupta - GitHub Profile
📜 License
    This project is licensed under the MIT License.
