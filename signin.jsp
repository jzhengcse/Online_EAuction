<%
	if(session.getAttribute("email")!=null) {
		response.sendRedirect("myaccount.jsp");
	}
%>
<%@ include file="header.jsp" %>
<div id="content">
		<!--content start-->
		
		<div class="article">
		<div class="topleft">
		<h2> sign in </h2>
			Email: <br><input id="email" type="text" name="email"><br>
			Password: <br><input id="password" type="password" name="password"><br>
		
			<input id="signin" type="button" value="Sign in">
		</form>
		</div>
		</div>


        <div class="article">
		<div class="middle">
		<h2> New to E-auction? </h2>
		<p> Get start now. It takes less than 2 minutes </p>
        <a href="register.jsp"> <input type="button" value="Register"</input></a>
		</div>
        </div>


		<!--content end-->
	</div>
<%@ include file="footer.jsp" %>
