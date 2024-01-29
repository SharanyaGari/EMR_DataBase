
import java.sql.*;  
import java.util.Scanner;

class GUI{  
public static void main(String args[]){  
try{  
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection(  
	"jdbc:mysql://localhost:3306/EMR","doctor_admin","password1234");  
	// doctor_admin password "Milo!240390"
	Scanner myObj = new Scanner(System.in);	//System.out.println("Enter Details you want to display from Database EMR:" + "\n" +  "Enter Bill for Viewing patients and billiAmount data,"+ "\n" +  "Enter Insurance for viewing patients and Insurance data,"+ "\n" +  "Enter Doctor for Viewing patient and doctors data");
	System.out.println("Enter Action you want to Perform on Database EMR:" + "\n" +  "Enter Insert for Inserting Data,"+ "\n" +  "Enter Update for Updating data,"+ "\n" +  "Enter Delete for Deleting data");
	String QueryInput = myObj.nextLine();
	String Query;
	if (QueryInput == "Insert") {
		Query = "call InsertDoctor;";		 
	} else if (QueryInput == "Update") {
		Query = "call UpdateDoctor;";
	} else {
		Query = "call DeleteDoctor;";
	}
	Statement stmt=con.createStatement();  
	ResultSet rs = stmt.executeQuery(Query); 
	while(rs.next())   
	System.out.println(rs.getInt(1)+"  "+rs.getString(2));  
	System.out.println("Displaying data after Action");
	con.close();  
	myObj.close();
	}catch(Exception e)
	{ 
	  System.out.println(e);
	  } 
	}  
} 



