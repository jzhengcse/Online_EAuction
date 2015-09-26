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
        sql = "insert into user (firstname, lastname,emailaddress,password,accounttype) values ('"+request.getParameter("firstname")+"','"+request.getParameter("lastname")+"','"+request.getParameter("email")+"','"+request.getParameter("password")+"','Individual')";
		//out.print("<p>"+sql+"</p>");
		//out.print("<p>"+request.getParameter("firstname")+"</p>");
		//out.print("<p>"+request.getParameter("lastname")+"</p>");
		//out.print("<p>"+request.getParameter("email")+"</p>");
		//out.print("<p>"+request.getParameter("password")+"</p>");
		
        out.print("<div class='featured'>");
			
        //STEP 5: Extract data from result set
        if(stmt.executeUpdate(sql)==1) {
            out.print("<p>succes</p>");
			sql="insert into individual (emailaddress) values ('"+request.getParameter("email")+"')";
			stmt.executeUpdate(sql);
        }else {
            out.println("<p>fail</p>");
        }
		out.print("</div>");

        //STEP 6: Clean-up environment
        //rs.close();
        stmt.close();
        conn.close();
    }catch(SQLException se){
       //Handle errors for JDBC
	   out.println("<script>alert('register erro')</script>");
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
