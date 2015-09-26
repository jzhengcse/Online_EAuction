<%@ include file="header.jsp" %>
<div id="content">
	<!--content start-->
	<div class="featured">
		<div class="topleft">
		<form  calss="center" action="proreg.jsp" method="get">
			First name<br>
			<input type="text" name="firstname"><br>
			Last name<br>
			<input type="text" name="lastname"><br>
			Email<br>
			<input type="text" name="email"><br>
			Create your password<br>
			<input type="password" name="password"><br>
			Confirm password<br>
			<input type="password" name="cpassword"><br>
			<input type="radio" name="accounttype" value="Individual">Individual
			<input type="radio" name="accounttype" value="Comapny">Company<br>
			<input type="submit" value="Submit">
		</form>
	</div>
	<!--content end-->
</div>
<%@ include file="footer.jsp" %>
