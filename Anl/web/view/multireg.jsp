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
                        <li class="breadcrumb-item active">Multiple Regression</li>
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
               <h3>Multiple Regression</h3>
            </div>
             <div class="card-subtitle">
               <p>(Ordinary least squares)</p>
            </div>
            <div class="card-body">
            	<form id="regform">
            	<%int i=0; %>
            	 <c:forEach items="${headername }" var="head">
                    <input type="hidden" name="x<%=i %>">
                    <%i++; %>
                 </c:forEach>            		
            		<input type="hidden" name="y">
            		<input type="hidden" name="dw">
            	</form>
            	<p>Formula(b0: bias, bX: coefficients)</p>
				<h5 id="formula"></h5>
				
            <div class="form-group">
                     <div class="bttonn-list">
                        <div class="btn-group-vertical">
                           <p>Dependent Variable(Y)<code>(Required)</code></p>
                           <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <span name="y" class="caret">select</span></button>
                           <ul name='select' id="y" class="dropdown-menu" role="menu">
                             
                              <c:forEach items="${headername }" var="head">
                                 <li value="${head }" name="y">${head }</li>
                              </c:forEach>
                           </ul>
                        </div> 
                        <div class="btn-group-vertical">
                           <p>Independent Variables(Multiple Choice)<code>(Required)</code></p>
                           <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                           <span name="x" class="caret">select</span></button>
                           <ul name='select' id="x" class="dropdown-menu" role="menu">
                               <%int j=0; %>
                              <c:forEach items="${headername }" var="head">                              
                                 <li value="${head }" name="x<%=j %>">${head }</li>
                                  <%j++; %>
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
               
                  <h4 class="card-title">Multiple Regression</h4>
                  <div class="loader"></div>
                  <h4 id="simpleformula"></h4>
                  <p id="multiregresult"></p>
                  <h4 class="resultheader">ANOVA TABLE</h4> 
                  <p id="multiregaov"></p> 
                  <img id="multiregimg1">
                  <img id="simpleregimg2">     
               </div>
            </div>
            <div id="dubinwatson" class="form-group">
                        <p>Dubin-Watson Anl<code>(default: False)</code></p>
                        <p class="text-muted m-b-15 f-s-12">Please input it yourself</p>
                        <input id="dubinvalue" type="number"  class="form-control input-rounded" placeholder="0">
                     </div>
             <button id="residualanlbt" class="btn btn-primary btn-block m-b-6" type="button">Residual Anl</button>
         </div>
         <div  id="residualanl" class="card">
            <div  class="col-lg-12">
               <div class="card-title">
                  <h3>Residual Analysis</h3>
               </div>
               <div  class="card-body">
               <br>
               <img id="residimg2">   
               <br>
                
               <div class="row">
               	  <div  class="col-lg-6">
               	 <h4>Residual Test(Tukey)</h4>
               	 <p id="residtest"></p>
               	  <img id="residimg1">
               	  </div>
               	  <div  class="col-lg-6">
               	 <h4>Influence Observation</h4>
               	 <p id="residinfluence"></p>
               	 <img id="residimg3">
               	 </div>
               	 </div>
               	 <br>
               	 <div class="row">
               	 <div  class="col-lg-6">
               	  <h4>Dubin-Watson Anl</h4>
               	  <p id="dw"></p>
               	  </div>
               	  </div>
               </div>
            </div>
         </div>   
            </div>
             
         </div>
</div>
<script>
var xlist="";
var fomlist=[];
function removeA(arr) {
    var what, a = arguments, L = a.length, ax;
    while (L > 1 && arr.length) {
        what = a[--L];
        while ((ax= arr.indexOf(what)) !== -1) {
            arr.splice(ax, 1);
        }
    }
    return arr;
}
$(document).ready(function(){
	$('#reloadpage').hide();
	$('#residualanl').hide();
	$('#residualanlbt').hide();
	$('.resultheader').hide()
	xlist= "${headername}"
	xlist.replace("[","")
	xlist.replace("]","")	
	xlist= xlist.split(',');
	$('#dubinwatson').hide()
	$('.loader').hide();
	
	
})
$(function(){
	$('#dubinvalue').change(function(){
		$('input[name=dw]').attr('value',$(this).val());
	})
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
var bnum=0;
$('#formula').text("$$ \\color{red}\\widehat{"+y+"}\\color{black}  = b0 +  bX\\color{red}"+x+"$$");

$('ul[name=select] li').click(function(){
	var a =$(this).parent().attr('id');
   	$('span[name='+a+']').text($(this).html());
   	if (a =="x"){
   		var xname = $(this).attr('name')
   		if ($('input[name='+xname+']').val() == $(this).attr('value')){
   			fomlist=removeA(fomlist,$('input[name='+xname+']').val())
   			//이미 클릭
   			$('input[name='+xname+']').val("");
   		}else{
   			$('input[name='+xname+']').val($(this).attr('value'));
   			x=$(this).attr('value')
   			fomlist.push(x)
   		}
   	}else{
   		$('input[name='+a+']').val($(this).attr('value'));
   		y = $(this).attr('value')
   	}
	var fom1 = "$$ \\color{purple}\\widehat{"+y+"}"
   	var fom2 = "\\color{black}  =b0"
   	var str=""
   	for (i = 0; i < fomlist.length; i++) { 
   		if ((i+1)%2==0){
   			str+="$$ $$";
   		}
   	   str += "\\color{black} +b"+(i+1)+"\\color{purple}"+fomlist[i]+"";
   	}
   	if (fomlist.length<1){
   		str = "+ bX\\color{red}x";
   	}
   	$('#formula').text(fom1+fom2+str+"$$");
   	MathJax.Hub.Queue(['Typeset',MathJax.Hub,'result']);
})
   




$("#startanl").click(function(){
	
	var fields = $( "#regform" ).serializeArray();
    var list = [];
	jQuery.each( fields, function( i, field ) {
		if (field.value.length>0){
			list.push(field.value);
		}	
    });
	var check="ok"
	$.each(fomlist, function(i, field){
		if (y==field){
			check = "incorrect formula, maybe you selected y variable in x variables"
		}
	});
	
	if (list.length<3){
		alert("select variables")
	}else if(($('input[name=y]').val()).length<1){
		alert("select y")
	}else if(check != "ok"){
		alert(check)
	}else{
		$('.loader').show();
		var formData = $("#regform").serialize();	
		$('#startanl').hide();
			var formData = $("#regform").serialize();
			$.ajax({
					type : "POST",
					url : "../regression/multireg.do",
					cache : false,
					data : formData,
					 async: false,
					success:function(data){
						var a = JSON.parse(data);
						$('.resultheader').show()
						$('#multiregresult').html(a.result);
						$('#multiregaov').html(a.aov);
						$('#multiregvif').html(a.vif);
						
						$('#multiregimg1').attr("src",a.imgpath1);
						$('#reloadpage').show();
						$('#residualanlbt').show();
						$('.loader').hide();
						var beta = a.beta;
						var fom1 = "$$ \\color{purple}\\widehat{"+y+"}"
					   	var fom2 = "\\color{black}  ="+Number(beta[0])
					   	var str=""
					   	fomlist = a.xnames
					   	for (var i=0;i<fomlist.length;i++){
					   		if ((i+1)%2==0){
					   			str+="$$ $$";
					   		}
					   		if (Number(beta[i+1])>0){
					   			str+="\\color{black}"+"+"+Number(beta[i+1])+"\\color{purple}"+fomlist[i]+""
					   		}else{
					   			str+="\\color{black}"+Number(beta[i+1])+"\\color{purple}"+fomlist[i]+""
					   		}
					   		
					   	}
					   
					   	$('#formula').text(fom1+fom2+str+"$$");
					   	MathJax.Hub.Queue(['Typeset',MathJax.Hub,'result']);
						$('#dubinwatson').show()
					},
					fail:function(){}
					})	
	}
	
				
})

$('#residualanlbt').click(function(){
	$(this).hide();
	
	var formData = $("#regform").serialize();
 	$.ajax({
		type : "POST",
		url : "../regression/multiregresid.do",
		cache : false,
		data : formData,
		success:function(data){
			var a = JSON.parse(data);	
			$('#residualanl').show()
			$('#residtest').html(a.residtest);
			$('#residinfluence').html(a.residinfluence);
			$('#dw').html(a.dw);
			$('#residimg1').attr('src',a.imgpath1);
			$('#residimg2').attr('src',a.imgpath2);
			$('#residimg3').attr('src',a.imgpath3);
		
		},
		fail:function(){
			alert("fail")
		}
		
	})
 });
					
</script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]},
  TeX: { extensions: ["color.js"] }
});
</script>

