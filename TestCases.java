import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class HumidityObservation {

    public static String observeHumidity(T_HumidityEnvironment humidityData) {
        String result;

        // Establish a database connection
        try (Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/yourdatabase", "username", "password")) {
            // Create a prepared statement with the function call
            String sql = "SELECT observeHumidity(?, ?, ?, ?, ?, ?) FROM DUAL";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setFloat(1, humidityData.getTemperature());
                statement.setFloat(2, humidityData.getWaterVaporElasticity());
                statement.setFloat(3, humidityData.getRelativeHumidity());
                statement.setFloat(4, humidityData.getMoistureDeficit());
                statement.setFloat(5, humidityData.getDewpoint());
                statement.setFloat(6, humidityData.getTemperatureFelt());

                // Execute the query
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        result = resultSet.getString(1);
                    } else {
                        result = "No result";
                    }
                }
            }
        } catch (SQLException e) {
            result = "SQL Error: " + e.getMessage();
        }

        return result;
    }

    public static void main(String[] args) {
        // Example usage
        T_HumidityEnvironment humidityData = new T_HumidityEnvironment(20.0f, 7.0f, 30.0f, 5.0f, 10.0f, 25.0f);
        String observationResult = observeHumidity(humidityData);
        System.out.println("Observation Result: " + observationResult);
    }
}

public class HumidityObservationTest {
    
    @Test
    public void testObserveHumidity() {
        // TC1.1: Правильний тест
        T_HumidityEnvironment humidityData1 = new T_HumidityEnvironment(20, 7, 20, 0, -10, 5);
        assertEquals("1", observeHumidity(humidityData1));

        // TC1.2: Порушення умови (температура за межами)
        humidityData1 = new T_HumidityEnvironment(52, 7, 20, 0, -10, 5);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));

        // TC1.3: Порушення умови (еластичність пари за межами)
        humidityData1 = new T_HumidityEnvironment(20, 0, 20, 0, -10, 5);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));

        // TC1.4: Порушення умови (відносна вологість за межами)
        humidityData1 = new T_HumidityEnvironment(20, 7, 120, 0, -10, 5);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));

        // TC1.5: Порушення умови (вологий дефіцит менше 0)
        humidityData1 = new T_HumidityEnvironment(20, 7, 20, -5, -10, 5);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));

        // TC1.6: Порушення умови (точка роси за межами)
        humidityData1 = new T_HumidityEnvironment(20, 7, 20, 0, 111111, 5);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));

        // TC1.7: Порушення умови (відчутна температура за межами)
        humidityData1 = new T_HumidityEnvironment(20, 7, 20, 0, -10, 111111);
        assertEquals("Значення параметрів виходять за допустимі межі", observeHumidity(humidityData1));
    }
}

class T_HumidityEnvironment {
    private float temperature;
    private float waterVaporElasticity;
    private float relativeHumidity;
    private float moistureDeficit;
    private float dewpoint;
    private float temperatureFelt;

    public T_HumidityEnvironment(float temperature, float waterVaporElasticity, float relativeHumidity,
                                 float moistureDeficit, float dewpoint, float temperatureFelt) {
        this.temperature = temperature;
        this.waterVaporElasticity = waterVaporElasticity;
        this.relativeHumidity = relativeHumidity;
        this.moistureDeficit = moistureDeficit;
        this.dewpoint = dewpoint;
        this.temperatureFelt = temperatureFelt;
    }

    // Add getters for each attribute
    // Example:
    public float getTemperature() {
        return temperature;
    }
