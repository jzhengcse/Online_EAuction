<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date" %>
<%
	final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	final String DB_URL = "jdbc:mysql://localhost/Eauction";

	//  Database credentials
	final String USER = "root";
	final String PASS = "";

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs;
	try{
	   //STEP 2: Register JDBC driver
		Class.forName("com.mysql.jdbc.Driver");

		//STEP 3: Open a connection
		//out.println("<p>Connecting to database...</p>");
		conn = DriverManager.getConnection(DB_URL,USER,PASS);

		//STEP 4: Execute a query
		//out.println("<p>Creating statement...</p>");
		stmt = conn.createStatement();
		String sql;
		
		//STEP 5: Extract data from result set

		//sql = "SELECT LAST_INSERT_ID() AS id FROM item";
		//stmt.executeUpdate(sql);

		sql="select max(itemid) from item";
		rs=stmt.executeQuery(sql);
		rs.next();
		int itemid=(int)rs.getInt(1)+1;
		//out.println(itemid);	
		sql="insert into item (emailaddress,name,categoryid,buyitnowprice,description,endtime,url,picture) values ('"+session.getAttribute("email")+"','"+request.getParameter("name")+"',"+request.getParameter("categoryid")+","+ request.getParameter("buyitnowprice") +",'"+request.getParameter("description")+"',now()+interval 7 day,'item.jsp?itemid="+itemid+"','"+request.getParameter("picture")+"')";


		//out.println(sql);	
		stmt.executeUpdate(sql);

		out.println("You added item "+ request.getParameter("name"));

		//STEP 6: Clean-up environment
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


