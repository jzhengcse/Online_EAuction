<%@ include file="header.jsp" %>

<div id="content">
	<!--content start-->
<%! ArrayList<String> RootDes=new ArrayList<String>(); %>
<%! ArrayList<Integer> RootID=new ArrayList<Integer>(); %>
<%! ArrayList<String> ChildDes=new ArrayList<String>(); %>
<%! ArrayList<Integer> Child=new ArrayList<Integer>(); %>

<style>
	li {
		list-style-type: none; 
		padding: 2px; 
		margin-left: 25px;
	}
	
	td {
		vertical-align:text-top;
	}
	div {padding: 4px;}
	
	h3 {color: #E42011;}
</style>

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
		String rootCategories;
		rootCategories = "SELECT Name, CategoryID FROM Category WHERE ParentID = 0 AND CategoryID <> 0";
		ResultSet rs = stmt.executeQuery(rootCategories);
		
		while(rs.next()){
			//Retrieve by column name
			RootDes.add(rs.getString("Name"));
			RootID.add(rs.getInt("CategoryID"));
		}		
		
		String sql;
		sql = "SELECT Name, ParentID FROM Category";
		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		while(rs.next()){
		   //Retrieve by column name
		   ChildDes.add(rs.getString("Name"));
		   Child.add(rs.getInt("ParentID"));

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
<%		
out.print("<table>");
for(int i = 0; i < RootID.size(); i=i+3) {
	out.println("<td style=\"width:25%\">");
	out.println("<div>");
	out.println("<h3>"+RootDes.get(i)+"</h3>");
	out.println("<ul>");	
	for(int c = 0; c < Child.size(); c++){
		if(Child.get(c) == RootID.get(i)){
			out.print("<a href=\"/categories/"+ChildDes.get(c).replace(" ", "")+"\"> <li>" + ChildDes.get(c)+"</li> </a>");
		}
		out.println("</ul>");		
	}
	out.println("</div>");
	if(i+1 < RootID.size()){
		
		out.println("<div>");
		out.println("<h3>"+RootDes.get(i+1)+"</h3>");
		out.println("<ul>");	
		for(int c = 0; c < Child.size(); c++){
			if(Child.get(c) == RootID.get(i+1)){
				out.println("<a href=\"\"> <li>"+ChildDes.get(c).replace(" ", "")+"</li> </a>");
			}
			out.println("</ul>");
		}	
		out.println("</div>");
		if(i+1 < RootID.size()) {
			
			out.println("<div>");
			out.println("<h3>"+RootDes.get(i+2)+"</h3>");
			out.println("<ul>");	
			for(int c = 0; c < Child.size(); c++){
				if(Child.get(c) == RootID.get(i+2)){
					out.println("<a href=\"\"> <li>"+ChildDes.get(c).replace(" ", "")+"</li> </a>");
				}
				out.println("</ul>");
			}
			out.println("</div>");
	}
	}
	out.println("</td>");
}
out.print("</table>");
// wasn't sure how else to make it stop repeating
RootID.clear();
Child.clear();
%>
	<!--content end-->
<%@ include file="footer.jsp" %>
