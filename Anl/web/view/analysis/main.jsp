<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<html>
<head>
<title></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="stylesheet" href="/Anl/css/analysis_css/assets/css/main.css" />

<style>
.sidenav {
	position: absolute;
	height: 100%;
	width: 0;
	z-index: 1;
	top: 0;
	right: 0;
	background-color: #111;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 60px;
}

.sidenav a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 25px;
	color: #818181;
	display: block;
	transition: 0.3s;
}

.sidenav a:hover {
	color: #f1f1f1;
}

.sidenav .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
	margin-left: 50px;
}


</style>
</head>
<body>

	<!-- header -->
	<div id="header">
		<div class="top">
			<div id="logo">
				<img src="/Anl/img/logo.png" id="logoimg"/>
			</div>
			<nav id="nav">
				<ul>
					<li><a href="/Anl/analysis/manual.do" id="manual">Manual</a></li>
					<li><span class="opener" id="anlnav">Analysis</span>
						<ul>
							<li><a href="/Anl/analysis/step1.do" id="step1">Data upload</a></li><!-- Upload Data  -->
							<li><a href="/Anl/analysis/redirectstep2.do" id="step2">Data Setting</a></li><!-- Variables Setting -->						
							<li><a href="/Anl/analysis/redirectstep3.do" id="step3">Start Anl</a></li><!-- Method Selection -->											
						</ul>
					</li>
					<li><a href="/Anl/analysis/about.do" id="about">About Us</a></li>
				</ul>
			</nav>
		</div>
	</div>
	<!-- header end -->
	
	
	<div id="main">
		<!-- top right -->
		<div id="login">
			<ul>
				<li style="display: inline"><a href="/Anl/analysis/cancle.do">cancle</a></li>
				<li style="display: inline"><a href="#">MyPage</a></li>
				<li style="display: inline"><a href="#">Login</a></li>
			</ul>
		</div>
		
		
		<!-- center -->
		<div id="content_container">
				<!-- covert to up and down -->
				<div id="content">
					<c:choose>
						<c:when test="${center !=null}">							
							<jsp:include page="${center }.jsp"></jsp:include>							
						</c:when>
						<c:otherwise>
							<jsp:include page="manual.jsp"></jsp:include>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${sheet !=null }">
						<hr/>					
							<jsp:include page="${sheet }.jsp"></jsp:include>
						<hr/>
						</c:when>
					</c:choose>
					
				</div>				
		</div>
	<div id="footer">Made by JDH¨Ï </div>
	</div>
	<!-- Scripts -->
	<script src="/Anl/css/analysis_css/assets/js/jquery.min.js"></script>
	<script src="/Anl/css/analysis_css/assets/js/jquery.scrolly.min.js"></script>
	<script src="/Anl/css/analysis_css/assets/js/jquery.scrollzer.min.js"></script>
	<script src="/Anl/css/analysis_css/assets/js/skel.min.js"></script>
	<script src="/Anl/css/analysis_css/assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="/Anl/css/analysis_css/assets/js/main.js"></script>


</body>
<script>
$('#logoimg').click(function(){
	window.location.href="/Anl/analysis/main.do"
})
var warning= "${warning}";
if (warning!=""){
	alert(warning)
}
var redirect= "${redirect}";
if (redirect!=""){
	window.location.href=redirect;
}
</script>
</html>