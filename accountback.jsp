<%@ include file="header.jsp" %>
<div id="content">
		<!--content start-->


		<div class="center">
		<form action="login.jsp" method="post">
			UserID: <input type="text" name="UserID"><br>
			Password: <input type="password" name="Password"><br>
			<select name="AccountType">
				<option value="Individual" selected>Individual Account</option>
				<option value="Company">Company Account</option>
			</select>
			<input type="submit" value="Log in"</input>
		</form>
		</div>





		<!--content end-->
	</div>
<%@ include file="footer.jsp" %>
