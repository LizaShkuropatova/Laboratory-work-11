CREATE OR REPLACE TYPE T_HumidityEnvironment AS OBJECT (
    temperature FLOAT,
    water_vapor_elasticity FLOAT,
    relative_humidity FLOAT,
    moisture_deficit FLOAT,
    dewpoint FLOAT,
    temperature_felt FLOAT
);

CREATE OR REPLACE FUNCTION observeHumidity(humidityData IN OBJ_HumidityEnvironment) RETURN VARCHAR2 IS
   result VARCHAR2(100);
BEGIN
   -- Перевірка вхідних параметрів
   IF humidityData.temperature < -50.0 OR humidityData.temperature > 50.0 OR
      humidityData.water_vapor_elasticity <= 0 OR
      humidityData.relative_humidity < 0 OR humidityData.relative_humidity > 100 OR
      humidityData.moisture_deficit < 0 OR
      humidityData.dewpoint < -50.0 OR humidityData.dewpoint > 50.0 OR
      humidityData.temperature_felt < -50.0 OR humidityData.temperature_felt > 50.0 THEN
      result := 'Значення параметрів виходять за допустимі межі';
      RETURN result;
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      result := 'Помилка: ' || SQLERRM;
      RETURN result;
END;

CREATE OR REPLACE TRIGGER HumidityEnvironment_Check
BEFORE INSERT ON HumidityEnvironment
FOR EACH ROW
DECLARE
   result VARCHAR2(100);
BEGIN
   result := observeHumidity(OBJ_HumidityEnvironment(
      :new.temperature,
      :new.water_vapor_elasticity,
      :new.relative_humidity,
      :new.moisture_deficit,
      :new.dewpoint,
      :new.temperature_felt
   ));

   IF result <> 'OK' THEN
      RAISE_APPLICATION_ERROR(-20001, result);
   END IF;
END;

CREATE OR REPLACE TRIGGER HumidityEnvironment_Check_Update
BEFORE UPDATE ON HumidityEnvironment
FOR EACH ROW
DECLARE
   result VARCHAR2(100);
BEGIN
   result := observeHumidity(OBJ_HumidityEnvironment(
      :new.temperature,
      :new.water_vapor_elasticity,
      :new.relative_humidity,
      :new.moisture_deficit,
      :new.dewpoint,
      :new.temperature_felt
   ));

   IF result <> 'OK' THEN
      RAISE_APPLICATION_ERROR(-20002, result);
   END IF;
END;

-- Функція для перевірки обмежень вологості
  MEMBER FUNCTION checkHumidityLimits(humidityData IN OBJ_HumidityEnvironment) RETURN VARCHAR2 IS
    result VARCHAR2(100);
  BEGIN
    IF humidityData.temperature < -50.0 OR humidityData.temperature > 50.0 OR
       humidityData.water_vapor_elasticity <= 0 OR
       humidityData.relative_humidity < 0 OR humidityData.relative_humidity > 100 OR
       humidityData.moisture_deficit < 0 OR
       humidityData.dewpoint < -50.0 OR humidityData.dewpoint > 50.0 OR
       humidityData.temperature_felt < -50.0 OR humidityData.temperature_felt > 50.0 THEN
      result := 'Значення параметрів виходять за допустимі межі';
    ELSE
      result := 'Спостереження за вологістю успішне';
    END IF;
    RETURN result;
  END checkHumidityLimits;
