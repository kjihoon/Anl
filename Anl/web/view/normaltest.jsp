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
                    <h3 class="text-primary">Description</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Data Distribution</li>
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
               <h3>Shapiro test</h3>
            </div>
             <div class="card-subtitle">
               <p>(Normality test)</p>
            </div>
            <div class="card-body">
            	<form id="normalform">
            		<input type="hidden" name="x">
            	</form>
				<h3 id="hypothesis0"></h3>
				<h3 id="hypothesis1"></h3>
				
            <div class="form-group">
                     <div class="bttonn-list">
                        <div class="btn-group-vertical">
                           <p>Variable(X)<code>(Required)</code></p>
                           <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <span name="y" class="caret">select</span></button>
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
               
                  <h4 class="card-title">Normality test</h4>
                  <h4 id="xvar"></h4>
                  <p id="normalresult"></p>
                  <img id="imgpath1">
                  <img id="imgpath2">     
               </div>
            </div> 
         </div>
        </div>

	</div>
</div>
<script>
$(document).ready(function(){
	$('#reloadpage').hide()
})
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

var x = "X"
$('#hypothesis0').text("$$ \\color{black}H_0 :  "+x+"\\;is\\;normally\\;distributed. $$");
$('#hypothesis1').text("$$ \\color{black}H_1 : "+x+"\\;is\\; \\color{red}not \\color{black}\\;normally\\;distributed.$$");
$('ul[name=select] li').click(function(){
   	var a =$(this).parent().attr('id');
   	$('span[name='+a+']').text($(this).html());	
   	$('input[name='+a+']').val($(this).attr('name'));
   	x =$(this).attr('name')
	$('#hypothesis0').text("$$ \\color{black}H_0 :  "+x+"\\;is\\;normally\\;distributed. $$");
   	$('#hypothesis1').text("$$ \\color{black}H_1 : "+x+"\\;is\\; \\color{red}not \\color{black}\\;normally\\;distributed.$$");
 	MathJax.Hub.Queue(['Typeset',MathJax.Hub,'result']);
})

$(function(){
	$('#startanl').click(function(){
	if  (($('input[name=x]').val()).length<1){
		alert("select variable(X)!!")
	}else{
		$('#startanl').hide();
		var formData =$('#normalform').serialize();
		$.ajax({
				type : "POST",
				url : "../description/normaltest.do",
				cache : false,
				data : formData,
				success:function(data){
					var a = JSON.parse(data);	
   		        	$('#xvar').html(a.xvar);
   		        	$('#normalresult').html(a.result);
   		        	$('#imgpath1').attr('src',a.imgpath1);
   		        	$('#imgpath2').attr('src',a.imgpath2);
   		            $("#reloadpage").show();
		         },
		        error:function(){
		           alert("fail")
		        }
			});
		}			
		
	})
	
})

</script>   

<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]},
  TeX: { extensions: ["color.js"] }
});

</script>
