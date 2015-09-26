

<%@ include file="header.jsp" %>
	
<div id="content">
<!--content start-->

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
		//out.println("<p>Connecting to database...</p>");
		conn = DriverManager.getConnection(DB_URL,USER,PASS);

		//STEP 4: Execute a query
		//out.println("<p>Creating statement...</p>");
		stmt = conn.createStatement();
		stmt2 = conn.createStatement();
		String sql;
		ResultSet rs;
		ResultSet rs2;
		
		sql = "SELECT * FROM User U where accounttype='Individual'";
		rs = stmt.executeQuery(sql);
		%>
		<div class='featured longer'>
		<table>
			
			
		<tr> <th>First Name</th> <th>Last Name</th> <th>E-mail</th><th>Address</th><th>Phone</th><th>Age</th><th>Gender</th><th>Annual Income</th></tr>
                            <%
							//STEP 5: Extract data from result set
                            while(rs.next()) {
                            %>
							<tr> <td><%= rs.getString("firstname") %></td> <td><%= rs.getString("lastname") %></td><td><%= rs.getString("emailaddress") %></td> <td> <%= rs.getString("city") %> <%= rs.getString("State") %> <%= rs.getString("zipcode") %> </td> <td> <%= rs.getString("phone") %></td> 
<%
							sql="select * from individual I where i.emailaddress='"+rs.getString("emailaddress") +"'";
							rs2=stmt2.executeQuery(sql);
							rs2.next(); %>
							<td> <%= rs2.getString("age") %></td> <td> <%= rs2.getString("gender") %></td> <td> <%= rs2.getString("annualincome") %> </td> </tr> 


                            <% }    %>
                            </table>
						</div>
<!--content end-->
</div>

	<%	
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



<%@ include file="footer.jsp" %>


