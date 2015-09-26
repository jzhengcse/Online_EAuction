<%
    if(session.getAttribute("email")==null) {
        out.print("signin.jsp");
        return;
    }
%>

<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date" %>
<%
	final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	final String DB_URL = "jdbc:mysql://localhost/Eauction";

	//  Database credentials
	final String USER = "root";
	final String PASS = "";

	Connection conn = null;
	Statement stmt = null;
	try{
	   //STEP 2: Register JDBC driver
		Class.forName("com.mysql.jdbc.Driver");

		//STEP 3: Open a connection
		//out.println("<p>Connecting to database...</p>");
		conn = DriverManager.getConnection(DB_URL,USER,PASS);

		//STEP 4: Execute a query
		//out.println("<p>Creating statement...</p>");
		stmt = conn.createStatement();
		ResultSet rs;
		String sql;
		sql = "SELECT winnerid,emailaddress FROM item where itemid="+session.getAttribute("itemid");
		//out.println(sql);	

		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		rs.next();
		if(rs.getString("emailaddress").equals(session.getAttribute("email"))) {
			out.println("You can't buy your own item");

		} else {
			if(rs.getString("winnerid")==null) {
				sql="update item set winnerid='"+session.getAttribute("email")+"', endtime='"+new Timestamp((new Date()).getTime())+ "' where itemid="+session.getAttribute("itemid");

				stmt.executeUpdate(sql);
				out.println("Successfully buy it");			
			} else {
				out.println("This item is no longer available");

			}


		}
		

			

		//out.println(sql);
		//STEP 6: Clean-up environment
		rs.close();
		stmt.close();
		conn.close();
	}catch(SQLException se){
	   //Handle errors for JDBC
	   se.printStackTrace();
	}catch(Exception e){
	   //Handle errors for Class.forName
	   e.printStackTrace();
	}finally{
	   //finally block used to close resources
	   try{
		  if(stmt!=null)
			 stmt.close();
	   }catch(SQLException se2){
	   }// nothing we can do
	   try{
		  if(conn!=null)
			 conn.close();
	   }catch(SQLException se){
		  se.printStackTrace();
	   }//end finally try
	}//end try
	//out.println("<p>Goodbye!</p>");
%>


