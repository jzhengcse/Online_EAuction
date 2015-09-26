<!DOCTYPE html>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date" %>
<html>


<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"> </script>
<script src="myscript.js"> </script>
<title>HelloSQL Project</title>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="mystyle.css" />		
</head>



<body>
<div id="container">
	<!--container start-->
	<div id = "header">
		<!--header start-->
		<nav>
			<ul>
				<li>  
				<a href="index.jsp"> E-Auction</a> 
				</li>
				<li>
				<a href="hot.jsp"> Today's Deals </a> 
				<ul>
					<li> <a href="hot.jsp"> What's Hot </a> </li>
					<li> <a href="new.jsp"> What's New </a> </li>
				</ul>
				</li>
				<li>
				<a href="categories.jsp"> Category</a> 
				<ul>
					<li> <a href="browsingscreen.jsp?Category=1"> Automotive and Industrial </a> </li>
					<li> <a href="browsingscreen.jsp?Category=2"> Books </a> </li>
					<li> <a href="browsingscreen.jsp?Category=3"> Clothing, Shoes and Jewelry</a> </li>
					<li> <a href="browsingscreen.jsp?Category=4"> Electronics and Computers </a> </li>
					<li> <a href="browsingscreen.jsp?Category=5"> Health and Beauty </a> </li>
					<li> <a href="browsingscreen.jsp?Category=6"> Groceries </a> </li>
					<li> <a href="browsingscreen.jsp?Category=7"> Home, Garden and Tools </a> </li>
					<li> <a href="browsingscreen.jsp?Category=8"> Movies, Music and Games </a> </li>							
					<li> <a href="browsingscreen.jsp?Category=9"> Sports and Outdoors </a> </li>
					<li> <a href="browsingscreen.jsp?Category=10"> Toys, Kids and Baby </a> </li>
				</ul>
				</li>					
				<li>
				<a href="signin.jsp"> Your Account </a> 
				<!--
				<ul>
					<li> <a href=""> Your Profile </a> </li>
					<li> <a href=""> Your Orders </a> </li>
					<li> <a href=""> Your Wishlist </a> </li>
					<li> <a href=""> Start Selling </a> </li>							
					<li> <a href=""> Currently Bidding </a> </li>
					<li> <a href=""> Currently Selling </a> </li>
					<li> <a href=""> Bidding History </a> </li>
					<li> <a href=""> Search History </a> </li>
					<li> <a href=""> Recommendations </a> </li>							
				</ul>
				-->
				</li>	
				<li> 
				<a href="#"> About Us </a>
				</li>					
			</ul>
			<div align="right">
				<form id="searchform" name="search" action="search.jsp" method="get" align="right">
					<input id="search-input" name="key" type="text">
					<input type="submit" name="submit" value="Search">
				</form>	
			</div>
			<h3 style="text-align:right"><%= (new Date()).toLocaleString()%></h3>	
			<!-- <h3 style="text-align:right"><%= new Timestamp((new Date()).getTime()) %></h3>	-->
		</nav>
	</div>
