CREATE TABLE Users(
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    user_login VARCHAR(100) UNIQUE,
    user_password VARCHAR(100),
    date_birth DATE
);

CREATE TABLE Consumers (
    consumer_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id)
);

CREATE TABLE EmotionRecording (
    recording_id INT PRIMARY KEY,
    recorder_emotion VARCHAR(255),
    recording_comment CLOB,
    consumer_id INT REFERENCES Consumers(consumer_id)
);

CREATE TABLE Emotion (
    emotion_id INT PRIMARY KEY,
    name VARCHAR(255) UNIQUE
);

CREATE TABLE EmotionStatistic (
    statistic_id INT PRIMARY KEY,
    number_repetitions INT,
    percentage_ratio FLOAT,
    emotion_id INT REFERENCES Emotion(emotion_id)
);

CREATE TABLE EmotionStatistics (
    statistics_id INT PRIMARY KEY,
    total_recorded_emotions INT,
    consumer_id INT REFERENCES Consumers(consumer_id)
);

CREATE TABLE HumidityEnvironment (
    humidity_id INT PRIMARY KEY,
    temperature FLOAT,
    water_vapor_elasticity FLOAT,
    relative_humidity FLOAT,
    moisture_deficit FLOAT,
    dewpoint FLOAT,
    temperature_felt FLOAT
);

CREATE TABLE Weather (
    weather_id INT PRIMARY KEY,
    temperature FLOAT,
    weather_description VARCHAR(255)
);

ALTER TABLE Users 
ADD CONSTRAINT User_login_format 
CHECK (REGEXP_LIKE(login, '^[a-z0-9._-]+@[a-z]+\.[a-z]{2,4}$'));

ALTER TABLE HumidityEnvironment
ADD CONSTRAINT HumidityEnvironmentRange
CHECK (temperature_felt BETWEEN -50.0 AND 50.0);