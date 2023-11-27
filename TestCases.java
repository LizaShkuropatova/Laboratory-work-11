import org.junit.Test;
import static org.junit.Assert.assertEquals;

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
