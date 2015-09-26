<%@ include file="header.jsp" %>
<div id="content">
	<!--content start-->


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
		String sql;
		Timestamp time2=new Timestamp((new Date()).getTime());
		String search="%" + request.getParameter("key") + "%";
        sql = "SELECT * FROM item where endTime >'"+time2+"' order by bid desc";
		ResultSet rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		while(rs.next()){ %>
				<a href="<%= rs.getString("URL") %>">
					
				<div class='search'>
				<img src="<%= rs.getString("Picture") %>" >
				<%
				out.println("<h2 class='h2black'>"+rs.getString("Name")+" </h2>");  %>
				<p>End time: $<%= rs.getString("endtime") %> </p>
				<p>Highest Bid Price: $<%= rs.getString("highestbidprice") %> </p>
				<p>Buy It Now Price: $<%= rs.getString("highestbidprice") %> </p>
				<p>Bid Count: <%= rs.getString("bid") %> </p>
				<p>Watch Count: <%= rs.getString("watch") %> </p>
<%
				out.println("</div>");
				out.println("</a>");

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
	//out.println("<p>Goodbye!</p>");
%>


	<!--content end-->
	</div>
<%@ include file="footer.jsp" %>
