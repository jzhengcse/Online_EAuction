
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date" %>
	

<%
	final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	final String DB_URL = "jdbc:mysql://localhost/EAuction";

	//  Database credentials
	final String USER = "root";
	final String PASS = "";

	Connection conn = null;
	Statement stmt = null;
	Statement stmt2=null;
	try{
	   //STEP 2: Register JDBC driver
		Class.forName("com.mysql.jdbc.Driver");

		//STEP 3: Open a connection
		conn = DriverManager.getConnection(DB_URL,USER,PASS);

		//STEP 4: Execute a query
		stmt = conn.createStatement();
		stmt2 = conn.createStatement();
		String sql;
		ResultSet rs;
		ResultSet rs2;
		String email;
		String password;
				email=new String((String)request.getParameter("email"));
				password=new String((String)request.getParameter("password"));

		sql = "SELECT * FROM User U where U.emailaddress='"+email+"'";
		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		if(rs.next()) {
			if(rs.getString("Password").equals(password)) { 
				session.setAttribute("email",email); 
				session.setAttribute("password",password);
				out.print("myaccount.jsp");
			} else {
				out.println("wrong password");
			}
		}else {
			out.println("wrong email");
		}
		
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
%>







