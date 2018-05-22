<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
#result {
    width:800px;
    border: 3px solid black;
    border-radius: 10px;
     background-color: ivory;
}


</style>

<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
</head>
<body>

	<div>
		<form action="simplereg.do">			
			x<input type="text" name="x" id="x" ><br>
			y<input type="text" name= "y" id="y"><br>
			group<input type="text" name="group" id="group"><br>
			clientID<input type="text" name= "clientid" id="clientid"><br>	
			<input type="submit" value="gogo">
		</form>
	</div>
	
	
<!-- OLS (Simple) -->
<c:choose>
	<c:when test="${result!=null }">
		<div id="result">
			<c:forEach var="i" items="${result}">
				<h3>${i }</h3>
			</c:forEach>
			<form action="simpleregresid.do">
			<input type="hidden" name="clientid" value="admin"><!--clientid session 필요  -->
			<button>resid anl</button>
			</form>
		</div>
		
		<h2>!!Click Plot, you can get this Plot!!  </h2>

			<!-- linear regression plot -->
			<a class="plot"><img src= "/Anl/img/${clientid }reg_line.png"></a>
			<!-- scatter plot matrix -->
			<a class="plot"><img src= "/Anl/img/${clientid }reg_psy.png"></a>
	</c:when>
</c:choose>
<!-- OLS (Simple) each groups-->
<c:choose>
	<c:when test="${resultlist!=null }">
		<div id="result">
			<c:forEach var="i" items="${resultlist}">
				<br>
				<h3>Result of ${i }</h3>
				<c:forEach var="j" items="${i}">
					<h3>${j }</h3>				
				</c:forEach>
				<h3>----------------------------------------------</h3>
			</c:forEach>		
		</div>
		<!-- linear regression plot -->
				<a class="plot"><img src= "/Anl/img/${clientid }reg_line.png"></a>
				
	</c:when>
</c:choose>
</body>
<script>
var id ='${clientid }';
if (id==null){
	id = "admin";
}
</script>

</html>