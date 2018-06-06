<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML" async></script>
    
<div class="page-wrapper">
<!-- Bread crumb -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Regression</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Simple Regression</li>
                    </ol>
                </div>
            </div>
            <!-- End Bread crumb -->
         <div class="container-fluid">
         <div class="col-lg-12">
         <div class="card" id="headeroff">
            <div class="card-title">
               <h3>Data Name: ${filename }</h3>
            </div>
            <div class="card-body">
               <div class="table-responsive">
                  <table class="table">
                     <thead>
                        <th>Col Names</th>
                        <c:forEach items="${headername }" var="head">
                           <th>${head }</th>
                        </c:forEach>
                     </thead>
                     <tr>
                        <th>Col Type</th>
                        <c:forEach items="${typelist.type }" var="type">
                           <td>${type }</td>
                        </c:forEach>
                     </tr>
                  </table>
               </div>
            </div>
         </div>
         
         
      </div>
        <div class="col-lg-12">
         <div class="card" id="headeroff">
            <div class="card-title">
               <h3>Simple Regression</h3>
            </div>
             <div class="card-subtitle">
               <p>(Ordinary least squares)</p>
            </div>
            <div class="card-body">
            	<form id="regform">
            		<input type="hidden" name="x">
            		<input type="hidden" name="y">
            		<input type="hidden" name="group">
            	</form>
            	<p>Formula(b0: bias, b1: slope of x)</p>
				<h3 id="formula"></h3>
				
            <div class="form-group">
                     <div class="bttonn-list">
                        <div class="btn-group-vertical">
                           <p>Dependent Variable(Y)<code>(Required)</code></p>
                           <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <span name="y" class="caret">select</span></button>
                           <ul name='select' id="y" class="dropdown-menu" role="menu">
                              <c:forEach items="${headername }" var="head">
                                 <li name="${head }">${head }</li>
                              </c:forEach>
                           </ul>
                        </div> 
                        <div class="btn-group-vertical">
                           <p>Independent Variable(X)<code>(Required)</code></p>
                           <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <span name="x" class="caret">select</span></button>
                           <ul name='select' id="x" class="dropdown-menu" role="menu">
                              <c:forEach items="${headername }" var="head">
                                 <li name="${head }">${head }</li>
                              </c:forEach>
                           </ul>
                        </div>                    
						</div>
                 	</div>	            		
           	 </div>
            <button id="startanl" class="btn btn-primary btn-block m-b-6" type="button">Start Anl</button>
            <button id="reloadpage" onclick="window.location.reload()" class="btn btn-primary btn-block m-b-6" type="button">Another Parameter</button>
            </div>
           <div  class="card">
            <div  class="col-lg-12">
               <div class="card-title">
                  <h4>Result</h4>
               </div>
               <div class="card-body">
                  <h4 class="card-title">Simple Regression</h4>
                  <h4 id="simpleformula"></h4>
                  <p id="simpleregresult"></p>
                  <img id="simpleregimg1">
                  <img id="simpleregimg2">     
               </div>
            </div>
         </div>
            </div>
             
         </div>
</div>
<script>

$(document).ready(function(){
	$('#reloadpage').hide();
})

//변수 선택 공통 사항!!
$(function(){
   	$('.dropdown-menu li').each(function() {
   	 $(this).mouseover(function() {
            $(this).css ("background-color", "#c0c0c0");
        });
        $(this).mouseout(function () {
            $(this).css("background-color", "#FFF"); 
        });
   })
});
var x ="x";
var y ="y";
var checkx="x";
var checky="y";
$('#formula').text("$$ \\color{red}\\widehat{"+y+"}\\color{black}  = b0 +  b1\\color{red}"+x+"$$");
$('ul[name=select] li').click(function(){
   	var a =$(this).parent().attr('id');
   	$('span[name='+a+']').text($(this).html());	
   	$('input[name='+a+']').val($(this).attr('name'));
   	if (a=="x"){   		
   		window.x = $(this).html()
   		checkx ="xx";
   	}
 	if (a=="y"){   		
   		window.y = $(this).html()
   		checky="yy";
   	}
 	if (checkx=="xx"&&checky=="yy"){
 		$('#formula').text("$$  \\color{purple}\\widehat{"+y+"} \\color{black}  = b0 +  b1\\color{purple}"+x+"$$");
 	}else{
 		$('#formula').text("$$  \\color{red}\\widehat{"+y+"} \\color{black}  = b0 +  b1\\color{red}"+x+"$$");
 	} 	
 	MathJax.Hub.Queue(['Typeset',MathJax.Hub,'result']);
})




 
$('#startanl').click(function(){
	var myTimer = setTimeout(function() {
		  // Timer codes
		}, 2000);
	if ( ($('input[name=x]').val()).length<1 || ($('input[name=y]').val()).length<1  ){
   		alert("Please select variable!!")
	}else if( $('input[name=x]').val() == $('input[name=y]').val() ){
   		alert("select difference variables")
   	}else{
   		$('#simpleregimg1').attr('src',"");
       	$('#simpleregimg2').attr('src',"");
       	$('#simpleregresult').hide();
       	$('#startanl').hide();
   		var formData = $("#regform").serialize();
   		$.ajax({
   				type : "POST",
   				url : "../regression/simplereg.do",
   				cache : false,
   				data : formData,
   				 async: false,
   				success:function(data){
   					var a = JSON.parse(data);	
   					$('#simpleregimg1').attr('src',a.imgpath1);
       				$('#simpleregimg2').attr('src',a.imgpath2);
       				$('#simpleregresult').html(a.result);
       				$('#simpleformula').html(a.formula);   					
       				$('#simpleregresult').show();
       				$('#simpleformula').show();
       				$('#reloadpage').show()
       				var b1 = a.beta[1];
       				b1 =  Number(b1);
       				if (b1>0){
       					b1 = "+" + b1;
       				}
       				$('#formula').text("$$  \\color{purple}\\widehat{"+y+"} \\color{black}  = "+a.beta[0]+" "+b1+"\\color{purple}"+x+"$$");
       				MathJax.Hub.Queue(['Typeset',MathJax.Hub,'result']);
   		         },
   		        error:function(){
   		           alert("fail")
   		        }
   			});
   		
   	}
   	
   })



</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]},
  TeX: { extensions: ["color.js"] }
});
</script>

