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
		sql = "SELECT * FROM item";
		ResultSet rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		int i=0;
		while(rs.next()){
			if(i==0) {
				out.println("<a href ='http://www.google.com'>");
				out.println("<div class='featured' >");
				out.println("<h2>" + rs.getString("Name")+"</h2>");
				out.println("<img src="+ rs.getString("Picture")+">");
				out.println("</div>");
				out.println("</a> <br />");
			} else {
				out.println("<a href = '#'>" );                                
				out.println("<div class='article'>");
				out.println("<h2 class='h2black'>"+rs.getString("Name")+" </h2>");  
				out.println("		<img src="+rs.getString("Picture")+">");
				out.println("<p class='description'>"+rs.getString("Description")+"</p>");  
				out.println("</div>");
				out.println("</a>");

			}
			i++;
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
