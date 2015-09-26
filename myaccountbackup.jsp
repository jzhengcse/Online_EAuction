

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
		String email;
		String password;
		if(session.getAttribute("email")!=null) {
			email=new String((String)session.getAttribute("email"));
			password=new String((String)session.getAttribute("password"));
			} else {
				email=new String((String)request.getParameter("email"));
				password=new String((String)request.getParameter("Password"));
			}
                //out.print(email);
                //out.print(password);

		sql = "SELECT * FROM User U where U.emailaddress='"+email+"'";
		rs = stmt.executeQuery(sql);
		
		//STEP 5: Extract data from result set
		if(rs.next()) {
			if(rs.getString("Password").equals(password)) { 
			
		session.setAttribute("email",email); 
		session.setAttribute("password",password); %>
		<!--
		<p>Email: <%= session.getAttribute("password") %> </p>
		-->
			<%
			
			out.print("<div class='featured longer'>"); %>
				<input id="signout" type="button" value="Sing out">
				<ul class="accountinfo">
					<li>Profile


                <%

                out.print("<div class='profile'>"); %>
					<table>
						<tr><th>Account Type</th><td><%= rs.getString("AccountType") %></td></tr>
						<tr><th>First Name</th><td><%= rs.getString("firstname") %></td></tr>
							
						<tr><th>Last Name</th><td><%= rs.getString("lastname") %></td></tr>
						<tr><th>Rate</th><td><%= rs.getString("membership") %></td></tr>
						<tr><th>Email</th><td><%= rs.getString("emailaddress") %></td></tr>
						<tr><th>Address</th><td><%= rs.getString("Street") %> <%= rs.getString("city") %> <%= rs.getString("State") %> <%= rs.getString("zipcode") %></td></tr>
						<tr><th>Phone</th><td><%= rs.getString("Phone") %></td></tr>
				<%
                /* out.print("<p>Address:" + rs.getString("Street")+" "+ rs.getString("city")+ " "+rs.getString("State")+" " +rs.getString("zipcode")+"</p>"); */
                if(rs.getString("AccountType").equals(new String("Individual"))) {
                    sql = "SELECT * FROM individual U where U.emailaddress='"+rs.getString("emailaddress")+"'";
                    rs = stmt.executeQuery(sql);
					rs.next();%>
						<tr><th>Age</th><td><%= rs.getString("age") %></td></tr>
						<tr><th>Gender</th><td><%= rs.getString("gender") %></td></tr>
						<tr><th>AnnualIncome</th><td><%= rs.getString("annualincome") %></td></tr>
						<tr><th>Birthday</th><td><%= rs.getString("birthday") %></td></tr>
					</table>
				<%
                } else {
                    sql = "SELECT * FROM company C where C.emailaddress='"+rs.getString("emailaddress")+"'";
                    rs = stmt.executeQuery(sql);
					rs.next();%>
						<tr><th>Contact</th><td><%= rs.getString("pointofcontact") %></td></tr>
						<tr><th>Company Category</th><td><%= rs.getString("companycategory") %></td></tr>
						<tr><th>Revenue</th><td><%= rs.getString("revenue") %></td></tr>
						<tr><th>Company Name</th><td><%= rs.getString("companyname") %></td></tr>
					</table>
                <%
				}
                out.print("</div>"); %>





					</li>
					<li>Winning list
				  	 <div class="data">
                        <% sql = "SELECT * FROM item I where I.winnerID='"+email+"'";
                            rs = stmt.executeQuery(sql); %>
                            <table>
                            <tr> <th>Name</th> <th>Price</th></tr>
                            <%
                            while(rs.next()) {
							
							%>
                            <tr> <td><%= rs.getString("name") %></td> <td><%= rs.getDouble("buyitnowprice") %></td></tr>
                            <% }    %>
                            </table>

                    </div>	
					</li>
					<li>Bidding
					
					<div class="data">
						<%
							sql = "SELECT * FROM bid B where B.emailaddress='"+email+"'";
							rs = stmt.executeQuery(sql); %>
							<table>
							<tr> <th>Name</th> <th>Bid Price</th> <th>Bid Time</th></tr>
							<%
							while(rs.next()) {

                            sql = "SELECT name FROM item I where I.itemid="+rs.getInt("itemid");
                            rs2 = stmt2.executeQuery(sql);
                            rs2.next();

							%>
							<tr> <td><%= rs2.getString("name") %></td> <td><%= rs.getDouble("bidprice") %></td><td><%= rs.getTimestamp("bidTime") %></td>
							<% }	%>
							</table>

					</div>
					
					
					</li>
					<li>Watching list
				    <div class="data">
                        <% sql = "SELECT * FROM watch W where W.emailaddress='"+email+"'";
                            rs = stmt.executeQuery(sql); %>
                            <table>
                            <tr> <th>Name</th> <th>Price</th></tr>
                            <%
                            while(rs.next()) {

                            sql = "SELECT name,buyitnowprice FROM item I where I.itemid="+rs.getInt("itemid");
                            rs2 = stmt2.executeQuery(sql);
                            rs2.next();
                            %>
                            <tr> <td><%= rs2.getString("name") %></td> <td><%= rs2.getDouble("buyitnowprice") %></td></tr>
                            <% }    %>
                            </table>

                    </div>	
					
					
					
					</li>
					<li>Start selling
                     <div class="startselling">
                    <h3>Please fill out the following details to start selling.</h3>
                    <form id="item" name="des" action="additem.jsp" method="get" >
                        ItemID <br><input  name="itemid" type="text"> <br>
                        UserID <br> <input  name="userid" type="text"> <br>
                        CatagoryID<br> <input  name="cateid" type="text"> <br>
                        Name <br><input name="name" type="text"> <br>
                        Buy Price<br> <input name="buyitnowprice" type="text"> <br>
                        Reserve Price<br> <input  name="reserveprice" type="text"> <br>
                        <input  type="submit" name="submit">
                    </form>
                	</div>
                    </li>

					<li>Selling list 
					    <div class="data">
                        <%
                            sql = "SELECT Name,buyitnowprice FROM item I where I.emailaddress='"+email+"'";
                            rs = stmt.executeQuery(sql); %>
                            <table>
                            <tr> <th>Name</th> <th>Price</th></tr>
                            <%
                            while(rs.next()) {
                            %>
                            <tr> <td><%= rs.getString("name") %></td> <td><%= rs.getDouble("buyitnowprice") %></td></td>
                            <% }    %>
                            </table>

                    </div>
					</li>
				</ul>
			

				<div>
				</div>

				<div>
				</div>

				<div>
				</div>


                <div class="startselling">
                    <h3>Please fill out the following details to start selling.</h3>
                    <form id="item" name="des" action="additem.jsp" method="get" >
                        ItemID<br><input  name="itemid" type="text"> <br>
                        UserID <br> <input  name="userid" type="text"> <br>
                        CatagoryID<br> <input  name="cateid" type="text"> <br>
                        Name<br><input name="name" type="text"> <br>
                        Buy Price<br> <input name="buyitnowprice" type="text"> <br>
                        Reserve Price<br> <input  name="reserveprice" type="text"> <br>
                        <input class="leftmargin"  type="submit" name="submit">
                    </form>
                </div>
				<div>
				</div>
				<%
				out.print("</div>"); /* featured */

			}
			else {
				out.println("<p>wrong password</p>");
			}
		}else {
			out.println("<p>wrong email</p>");
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


