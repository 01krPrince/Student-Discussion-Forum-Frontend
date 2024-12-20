﻿# Student-Discussion-Forum-Frontend

This is the frontend application for the **Student Discussion Forum** project, designed to facilitate discussions and interactions among students. The frontend is developed using **Flutter**, and it interacts with the backend to fetch and display questions, answers, and more.

## Backend Repository

The backend for the **Student Discussion Forum** is available in a separate repository. The backend is developed using **Spring Boot** and handles all the business logic, including user management, question posting, and answer interactions.

You can access the backend repository here:  
[Student Discussion Forum - Backend](https://github.com/01krPrince/Student-Discussion-Forum)

## Features

- **View Questions**: Display all the questions posted by users.
- **Answer Questions**: Allow users to provide answers to questions.
- **Like Questions/Answers**: Users can like questions and answers.
- **User Authentication**: Sign in and manage user sessions.

## Getting Started

To run the frontend application, make sure the backend is running and accessible via the following URL:  
`http://localhost:8080/` (or the ngrok URL if deployed).

### Prerequisites

- Flutter SDK
- Dart SDK
- An active internet connection for fetching data from the backend

### Installation

1. Clone the frontend repository:
    ```bash
    git clone https://github.com/01krPrince/Student-Discussion-Forum-Frontend.git
    ```

2. Navigate to the frontend project folder:
    ```bash
    cd Student-Discussion-Forum-Frontend
    ```

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

4. Run the Flutter application:
    ```bash
    flutter run
    ```

### Backend Setup

Ensure that the backend is running on your local machine or a remote server. If you're using the **Student Discussion Forum - Backend** repository, follow the instructions in the backend repository's README to set it up.

### API Endpoints

The frontend communicates with the backend via the following API endpoints:

- **Get Questions**:  
  `GET /sdf/question/viewAllQuestions`
  
- **Post Answer**:  
  `POST /sdf/answer/add`

- **Like Question**:  
  `POST /sdf/question/like`

For a complete list of API endpoints, refer to the [backend repository](https://github.com/01krPrince/Student-Discussion-Forum).


Feel free to reach out if you encounter any issues or have suggestions for improvements!

