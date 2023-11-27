import java.sql.*;  
import oracle.jdbc.driver.*;

class AddUserPerformance {
    public static void main(String args[]){
		long t_start;
	    long t_finish;
		long t1;
	    long delta;
		int iterationNumber = 10;
		int testCaseResult = 0; // 0 = Passed -1 = Failed
        try{  
            // load Oracle JDBC-driver
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            // open connect to DB
            Connection con = DriverManager.getConnection(  
                                  "jdbc:oracle:thin:@https://185.235.218.67:1521/XEPDB1",
				   			      "student",
							      "p1234");           
            Statement cstmt2 = con.createStatement();
			cstmt2.executeUpdate("DELETE FROM Users");
            t_start = System.currentTimeMillis();
			for (int i = 1; i <= iterationNumber; i++) {
			    t1 = System.currentTimeMillis();
                // create template string with PL/SQL-function "add_user"
			    CallableStatement cstmt1 = con.prepareCall("{? = call add_user(?,?)}");
			    cstmt1.registerOutParameter(1,Types.NUMERIC);			
                // init template variables
			    cstmt1.setString(2, "user" + i);
			    cstmt1.setString(3, "a12A345678#");
			    // execute query
			    cstmt1.executeUpdate();
				delta = System.currentTimeMillis() - t1;
				System.out.println("Time" + i + " = " + delta + " (msec)");
            }
            t_finish = System.currentTimeMillis();
	        delta = Math.round((t_finish - t_start)/iterationNumber);
            System.out.println("Avg.time = " + delta + " (msec)");
			// close connect 
            con.close();  
        }
		catch(Exception e){ 
		    System.out.println(e);
		}  
	    System.exit(testCaseResult);
    }    
}  

