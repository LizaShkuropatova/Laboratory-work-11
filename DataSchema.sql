CREATE TABLE Users (
    User_Id INT PRIMARY KEY,
    User_Name VARCHAR(100),
    User_Login VARCHAR(100) UNIQUE,
    User_Password VARCHAR(100),
    Date_Birth DATE
);

CREATE TABLE Consumers (
    Consumer_Id INT PRIMARY KEY,
    User_Id INT REFERENCES Users (User_Id)
);

CREATE TABLE EmotionRecording (
    Recording_Id INT PRIMARY KEY,
    Recorder_Emotion VARCHAR(255),
    Recording_Comment CLOB,
    Consumer_Id INT REFERENCES Consumers (Consumer_Id)
);

CREATE TABLE Emotion (
    Emotion_Id INT PRIMARY KEY,
    Emotion_Name VARCHAR(255) UNIQUE
);

CREATE TABLE EmotionStatistic (
    Statistic_Id INT PRIMARY KEY,
    Number_Repetitions INT,
    Percentage_Ratio FLOAT,
    Emotion_Id INT REFERENCES Emotion (Emotion_Id)
);

CREATE TABLE EmotionStatistics (
    Statistics_Id INT PRIMARY KEY,
    Total_Recorded_Emotions INT,
    Consumer_Id INT REFERENCES Consumers (Consumer_Id)
);

CREATE TABLE HumidityEnvironment (
    Humidity_Id INT PRIMARY KEY,
    Temperature FLOAT,
    Water_Vapor_Elasticity FLOAT,
    Relative_Humidity FLOAT,
    Moisture_Deficit FLOAT,
    Dewpoint FLOAT,
    Temperature_Felt FLOAT
);

CREATE TABLE Weather (
    Weather_Id INT PRIMARY KEY,
    Temperature FLOAT,
    Weather_Description VARCHAR(255)
);

ALTER TABLE Users
ADD CONSTRAINT USER_LOGIN_FORMAT
CHECK (REGEXP_LIKE(User_Login, '^[a-z0-9._-]+@[a-z]+\.[a-z]{2,4}$'));

ALTER TABLE HumidityEnvironment
ADD CONSTRAINT HUMIDITYENVIRONMENTRANGE
CHECK (Temperature_Felt BETWEEN -50.0 AND 50.0);
