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
		<form action="simpleregresid.do">	
			<%-- <%j++; %>
			<c:forEach items="${x }" var="i">
				x<%=j %><input type="text" name="x" id=x><br>
			</c:forEach>			
			y<input type="text" name= "y" id="y"><br>
			 --%>
			 max.lag<input type="text" name="maxlag" id="maxlag"><br>
			clientID<input type="text" name= "clientid" id="clientid"><br>	
			<input type="submit" value="gogo">
		</form>
	</div>
	
<c:choose>
	<c:when test="${residtest!=null }">
		<div id="result">
			<h3>Residual Test</h3>
			<c:forEach var="i" items="${residtest}">
				<h3>${i }</h3>
			</c:forEach>
			<hr/>
			<h3>Influence Value </h3>
			<c:forEach var="i" items="${influence}">
				<h3>${i }</h3>
			</c:forEach>
			<hr/>
				<h3>Dubin - WatSon Test</h3>
				<c:forEach var="i" items="${dw}">
					<h3>${i }</h3>
				</c:forEach>
		</div>
			<!-- linear regression plot -->
			<a class="plot"><img src= "/Anl/img/${clientid }reg_resid.png"></a>
			<!-- scatter plot matrix -->
			<a class="plot"><img src= "/Anl/img/${clientid }reg_influence.png"></a>
			<a class="plot"><img src= "/Anl/img/${clientid }reg_influence2.png"></a>		
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