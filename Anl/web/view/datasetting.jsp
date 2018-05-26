<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>

#startanlbt{
 border-color:#fff;
 background-color:rgba(30, 22, 54, 0.6);
 box-shadow: rgba(30, 22, 54, 0.4) 0 0px 0px 2px inset;
}
#startanlbt:hover {
    color: rgba(255, 255, 255, 0.85);
    box-shadow: rgba(30, 22, 54, 0.7) 0 0px 0px 40px inset;
}

.allwrap{
    text-align: center;
    float: left; 
    width: 33%;
	display: inline-block;
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
	
<div class="page-wrapper">
<!-- Bread crumb -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Data Setting</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Data Upload</li>
                    </ol>
                </div>
            </div>
            <!-- End Bread crumb -->
         <div class="container-fluid">
			
		<div class="card" id="headeroff">	
			<div class="card-title">  	<h3>First Row(${filename })</h3></div>
			<div class="card-body">
			<div class="table-responsive">
				<table class="table">
					<thead><%int k =1; %>
						<th>#</th>
						<c:forEach items="${firstrow }" var="row">
							<th>Column<%=k %></th>
							<%k++; %>
						</c:forEach>
					</thead>
					<thead><%int i =1; %>
						<th>Col Names</th>
						<c:forEach items="${firstrow }" var="row">
							<th>V<%=i %></th>
							<%i++; %>
						</c:forEach>
					</thead>						
					<tr>
						<th>1st row</th>
						<c:forEach items="${firstrow }" var="row">
							<td>${row }</td>
						</c:forEach>
					</tr>					
				</table>
			</div>
			</div>
		</div>
			
		<div class="card" id="headeron">	
			<div class="card-title">
	        	<h3>First Row(${filename })</h3>
	        </div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table">
							<thead><%int l =1; %>
								<th>#</th>
								<c:forEach items="${firstrow }" var="row">
									<th>Column<%=l %></th>
									<%l++; %>
								</c:forEach>
							</thead>
							<thead>
								<th>Col Names</th>
								<c:forEach items="${firstrow }" var="row">
									<th>${row }</th>
								</c:forEach>
							</thead>
							<tr>
								<th>1st row</th>
								<c:forEach items="${secondrow }" var="srow">
									<td>${srow }</td>
								</c:forEach>
							</tr>
					</table>
				</div>
			</div>
		</div>
         
         <div class="card">
	         <div class="card-title">
	         	<h3>Header</h3></div>
	         	<div class="card-body">
	         		<div class="allwrap">
		         		<div class="headersel">
							<a class="button" value='t' >Header on</a>
							<a class="button2" value='f' >Header off</a>
					</div>
	         	</div>
	      </div>
	      <div class="card">
	         <div class="card-title">
	         	<h3>Column Type Setting</h3></div>
	         	<div class="card-body">   
         <form method="post" action="/Anl/anldata/dataview1.do" id="startanlform">			
				 <input type="hidden"  name="header" value="t">
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
		</form>	
         </div>
		</div>
			<button id="startanlbt" class="btn btn-primary btn-lg m-b-10 m-l-5" type="button">Start Anl</button>
		</div>
		</div>
		</div>
</body>
<script>
//init header
$(document).ready(function(){
	$("#headeroff").hide()
	$("#headeron").show()
})

$("#startanlbt").click(function(){
	$("#startanlform").submit();
})

$('.headersel a').click(function(){
	// convert header value
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
	//convert header table!!
	headervalue[0].value = value;
	if ($(this).attr('value')=='t'){
		$("#headeroff").hide()
		$("#headeron").show()
	}else{
		$("#headeron").hide()
		$("#headeroff").show()
	}
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

$('#side_dataupload').attr('class', 'active');
$('#side_dataupload #side_dataupload2').attr('class', 'active');
</script>

</html>