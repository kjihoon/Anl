
 
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
	<form action="ttest.do" method="get">
		x<input type="text" id="x" name="x"><br>
		y<input type="text" id="y" name="y"><br>
		alternative<input type="text" id="alternative" name="alternative"><br>
		paired<input type="text" id="paired" name="paired"><br>
		conflevel<input type="text" id="conflevel" name="conflevel"><br>
		varequal<input type="text" id="varequal" name="varequal"><br>
		mu<input type="text" id="mu" name="mu"><br>
			<input type="hidden" name="clientid" value="admin"><!--clientid session 필요  -->
		<input type="submit" value="gogogo">
	</form>
</div>



<c:choose>
	<c:when test="${ttest!=null }">
	<div id="result">
		<c:forEach var="i" items="${ttest}">
			<h3>${i }</h3>
		</c:forEach>
	</div>
		<a class="hist"><img  src= "/Anl/img/${clientid }ttest_hist.png"></a>		
		<a class="hist"><img src= "/Anl/img/${clientid }ttest_box.png"></a>		
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