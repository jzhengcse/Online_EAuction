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
		sql = "SELECT * FROM item where itemid="+request.getParameter("itemid")+ " and endTime >'"+time2+"'";
		//out.print(sql);
		ResultSet rs = stmt.executeQuery(sql);
	
		session.setAttribute("itemid",request.getParameter("itemid"));
		//STEP 5: Extract data from result set
		while(rs.next()){ %>
				<div class='item' >
					<img src="<%= rs.getString("Picture") %>" >
					<h2><%= rs.getString("Name") %></h2>
					<%
					Timestamp time1=rs.getTimestamp("endtime");
					%>
					<p style="color:red;"><b>End Time: <% if(time1.before(time2))
						out.print("Over");
						else 
						out.print(rs.getTimestamp("endtime")); %></b></p>
					<p class="idescription"><%= rs.getString("description") %></p>
					<b> Highest Bid: $<%= rs.getDouble("highestbidprice") %> </b><br>
					<input id="bidprice" type="text" name="bidprice" value="Your best offer"><br>
					<input id="bidbutton" type="button" value="Bid" ><br>
					<b>Buy It Now Price: $<%= rs.getDouble("buyitnowprice") %></b><br>
					<input id="buybutton" type="button"  name="buyitnow" value="Buy It Now"><br>
					<input id="watchbutton" type="button"  name="watch" value="Add to watch list">
				</div>
<%
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
