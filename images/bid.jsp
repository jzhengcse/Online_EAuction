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
		sql = "SELECT emailaddress,highestbidprice,name  FROM item where itemid="+session.getAttribute("itemid");
		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		rs.next();

		//if(session.getAttribute("email").equals(rs.getString("emailaddress"))) {
		//	out.println("You can't bid your item");
		//	return;
		//	}

		double highest=(double)rs.getDouble("highestbidprice");
		double mybid=Double.parseDouble(request.getParameter("price"));
		if(mybid<=0) {

			out.println("Are you serious?");
			return;
		} else {
			if(mybid>highest*1.05)
				out.println("You bid it " + rs.getString("name")+ " for "+mybid);
			else {
				out.println("It need to be 5% higher than "+ highest);	
				return;
			}
		}

		sql="insert into bid (emailaddress,itemid,bidprice,bidtime) values ('"+session.getAttribute("email")+"',"+session.getAttribute("itemid")+","+mybid+",'"+ new Timestamp((new Date()).getTime()) +"')";


		//out.println(sql);	

		stmt.executeUpdate(sql);
		sql="update item set highestbidprice="+mybid+" where itemid="+session.getAttribute("itemid");
		stmt.executeUpdate(sql);
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


