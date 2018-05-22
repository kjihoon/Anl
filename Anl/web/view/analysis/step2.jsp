<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>


.allwrap{
    text-align: center;
}
.typesel div{
	width: 33%;

}
.typesel a {
    -webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    display: block;
    margin: 10px;
    max-width: 100px;
    text-decoration: none;
    border-radius: 4px;
    /* padding: 20px 30px; */
}

.typesel a.button {
	background-color:rgba(30, 22, 54, 0.6);
    color: rgba(30, 22, 54, 0.6);
    box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

.typesel a.button:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}

.typesel a.button2 {
    color: rgba(30, 22, 54, 0.6);
    box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

.typesel a.button2:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 80px 0px 2px inset;
}



.headersel a {
    -webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    -o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
    display: block;
    margin: 10px;
    max-width: 180px;
    text-decoration: none;
    border-radius: 4px;
    /* padding: 20px 30px; */
}

.headersel a.button {
	background-color:rgba(30, 22, 54, 0.6);
    color: rgba(30, 22, 54, 0.6);
    box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

.headersel a.button:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}

.headersel a.button2 {
    color: rgba(30, 22, 54, 0.6);
    box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}

.headersel a.button2:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 80px 0px 2px inset;
}
</style>
</head>


<body>
	

		<form action="step3.do">		
			<h1>First Row : ${firstrow }</h1>
			<h3>Header</h3>
			<div class="allwrap">			
				<div class="headersel">
					<a class="button" value='t' >Header on</a>
					<a class="button2" value='f' >Header off</a>
				</div>
			</div>
				 <input type="hidden"  name="header" value="t">
				<!-- T<input type="radio" name="header" value="t" required>
				F<input type="radio" name="header" value="f" > -->
			<br>
		<h2>Column Type Setting</h2>
				<div class="typesel">
					<c:forEach items="${ncolumn }" var="i">
						<input type="hidden" id="type${i }" name="type" value='numeric'>
							
							<div class="allwrap">
								Col${i } Type
								<div class="wrap${i }">								
						      	  <a class="button" value='numeric' name="type${i }">Numeric</a>
						      	  <a class="button2" value='text' name="type${i }">text</a>
								</div>
								
							</div>							
					</c:forEach>
			</div>
			<input type="submit" value="apply">
		</form>	

</body>
<script>
$('.headersel a').click(function(){
	var value = $(this).attr('value')
	var headervalue = document.getElementsByName('header');
	$(this).css("background-color",' rgba(30, 22, 54, 0.6)')
	if (headervalue[0].value != value){
		if (value == 't'){
			$('.headersel .button2').css("background-color",'white')
		}else{
			$('.headersel .button').css("background-color",'white')
		}
	}
	headervalue[0].value = value;
});
var num;
$('.typesel a').click(function(){
	num = $(this).attr('name')
	num = num[num.length-1]
	var type = $(this).attr('value');
	var id = $(this).attr('name');
	var hiddenvalue = document.getElementById(id);	
	$(this).css("background-color",' rgba(30, 22, 54, 0.6)')
	if (hiddenvalue.value != type){
		if (type=='numeric'){
			$('.wrap'+num+' .button2').css("background-color",'white')
		}else{
			$('.wrap'+num+' .button').css("background-color",'white')
		}
	}
	hiddenvalue.value = type;
})
$(document).ready(function(){ 
    $("#nav ul li #anlnav").addClass("on");
    $("#nav ul li #step2").addClass("on");
    $(".opener").addClass("active");
});
</script>
</html>