<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Browsing Screen</title>

<%! ArrayList<String> Name=new ArrayList<String>(); %>
<%! ArrayList<String> Pic=new ArrayList<String>(); %>
<%! ArrayList<Integer> BuyItNow=new ArrayList<Integer>(0); %>
<%! ArrayList<Integer> BidPrice=new ArrayList<Integer>(0); %>
<%! ArrayList<Integer> ItemID=new ArrayList<Integer>(0); %>
<%! ArrayList<String> SubCat=new ArrayList<String>(); %>
<%! ArrayList<Integer> SubCatId=new ArrayList<Integer>(); %>

<%--
	out.println(request.getParameter("Category").toString());
--%>

<%
	final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	final String DB_URL = "jdbc:mysql://localhost/Eauction";

	//  Database credentials
	final String USER = "root";
	final String PASS = "";

	Connection conn = null;
	Statement stmt = null;
	int max_items = 24;
	int page_no = 0;
	
	// Keeping track of incoming parameters
	String category = request.getParameter("Category");
	String high = (request.getParameter("high"));
	String low = (request.getParameter("low"));	
	String how = request.getParameter("how");
	String rating = request.getParameter("Rating");
	
	if(request.getParameter("Browsing_Page_No") != null){
	page_no=Integer.parseInt(request.getParameter("Browsing_Page_No").toString());
	}
	
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
		sql = "SELECT * FROM Item WHERE CategoryID="+request.getParameter("Category");
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next()){
		   //Retrieve by column name
		   
		   Name.add(rs.getString("Name"));
		   Pic.add(rs.getString("Picture"));
		   if(rs.getInt("IsBuyItNow") == 1) {
		   		BuyItNow.add(rs.getInt("BuyItNowPrice"));
		   }
		   BidPrice.add(rs.getInt("highestbidprice"));	
		   ItemID.add(rs.getInt("ItemID"));
		   // out.println("aghh"+Name.get(i).toString());
		}
		String subCat = "SELECT * FROM Category WHERE ParentID="+request.getParameter("Category");
		ResultSet sub_cat= stmt.executeQuery(subCat);
		
		while(sub_cat.next()) {
			SubCat.add(sub_cat.getString("Name"));
			SubCatId.add(sub_cat.getInt("CategoryID"));
			
		}
		//out.println("aghh "+request.getParameter("Category").toString());
		//out.println("aghh "+rs.getFetchSize());
		//STEP 5: Extract data from result set

		while(sub_cat.next()){
			SubCat.add(sub_cat.getString("Name"));
			SubCatId.add(sub_cat.getInt("CategoryId"));
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
	}
%>

</head>
<body>
<div>
<!--  Side Bar -->
<div class="side_bar">
	<h3>Categories</h3>
	<% int in; for(in = 0; in< SubCat.size(); in++){ %>
			<ul>
				<li> <%= SubCat.get(in) %></li>
			</ul>
	<% } %>
		<!-- Number of Sub Categories: <%= SubCat.size() %> <br> for Category Id <%=request.getParameter("Category")  %> -->
	<hr class="hr4">
	<div>
		<form action="browsingscreen.jsp" method="get">
		<h4> Price: </h4> &nbsp$<input type="text" name="low" value=<%=low%>>
		to
				&nbsp$<input type="text" name="high" value=<%=high%>>
				
				
		<input type="submit" value="">	
		<input type="hidden" value="<%=category%>" name="Category"/>
		<input type="hidden" value="<%=how%>" name="How"/>
		<input type="hidden" value="<%=rating%>" name="Rating"/>
		
		</form> <!--  filter by price -->		
		<h4> Auction Type: </h4> 
		<a href="browsingscreen.jsp?Rating=<%=rating%>&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=BuyItNow"> <input type="checkbox" name="BuyItNow" <%if(how != null && how.equals("BuyItNow")){out.print("checked=\"checked\"");} %>> Buy It Now </a><br />
		<a href="browsingscreen.jsp?Rating=<%=rating %>&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=Auction"><input type="checkbox" name="Auction" <%if(how != null && how.equals("Auction")){out.print("checked=\"checked\"");} %>> Auction </a> <br />
		<a href="browsingscreen.jsp?Rating=<%=rating %>&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=Both"><input type="checkbox" name="Both" <%if(how != null && how.equals("Both")){out.print("checked=\"checked\"");} %>> Both </a> <br />
				
		<div>		
		<h4> Rating: </h4>		
		<h5> Minimum Rating</h5>
			<a href="browsingscreen.jsp?Rating=1&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=<%=how%>">  <div class="rating"> </div> </a>
			<a href="browsingscreen.jsp?Rating=2&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=<%=how%>"> <div class="rating"> </div> </a>
			<a href="browsingscreen.jsp?Rating=3&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=<%=how%>"> <div class="rating"> </div> </a>
			<a href="browsingscreen.jsp?Rating=4&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=<%=how%>"> <div class="rating"> </div> </a>
			<a href="browsingscreen.jsp?Rating=5&Category=<%=category%>&high=<%=high%>&low=<%=low%>&how=<%=how%>"> <div class="rating"> </div> </a>
		</div>
		
		<!--  filter  -->		
	</div>
	
	<div>

	
	</div>
</div> <!-- end of side bar -->

<!-- The Items Listed -->
<div>
<% 
int i;	   
for(i=page_no*max_items;i<page_no*max_items+max_items;i++) { %>
 <% if(i < Name.size()){%>
	<a href = "item.jsp?ItemID=<%=ItemID.get(i)%>">
	<div class="listItems">
					<img src=<%= Pic.get(i) %>>
			<div class="text">
					<b> <a href="item.jsp?ItemID=<%=ItemID.get(i)%>"> 	<%= Name.get(i) %> </a> </b>
					<h5>Current Bid Price $<%= BidPrice.get(i) %> 
					</h5>
			</div>
	</div>
	
	
	</a>
	<%  }  %>
<%		} %>
</div>
<!--  End of item list  -->

<div>
<% if(page_no < (Name.size()/max_items)) { %>
<br />
<a href= "browsingscreen.jsp?Category=<%=request.getParameter("Category")%>&Browsing_Page_No=<%=page_no+1%>"> Next </a>
<% } %>
</div> <!--  End of div for next  -->

</div> <!--  End of main content  -->
</body>


</html>
<%@ include file="footer.jsp" %>
<% Name.clear(); Pic.clear(); BuyItNow.clear(); BidPrice.clear(); ItemID.clear(); SubCat.clear(); SubCatId.clear();%>
