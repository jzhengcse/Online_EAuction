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
		sql = "SELECT emailaddress FROM watch where itemid="+session.getAttribute("itemid")+ " and emailaddress='"+session.getAttribute("email")+"'";
		//out.println(sql);	

		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		if(rs.next()) {
			out.println("It's already in your watch list");
			} else {
		

		sql="insert into watch (emailaddress,itemid) values ('"+session.getAttribute("email")+"',"+session.getAttribute("itemid")+")";
		stmt.executeUpdate(sql);

		sql="update item set watch=watch+1  where itemid="+session.getAttribute("itemid");
		stmt.executeUpdate(sql);
		out.println("Successfully add it to your list");
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


