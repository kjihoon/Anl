<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<div class="page-wrapper">
<!-- Bread crumb -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">T-test</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Mean Estimator</li>
                    </ol>
                </div>
            </div>
            <!-- End Bread crumb -->
         <div class="container-fluid">
        
        <div class="col-lg-12">
         <div class="card" id="headeroff">	
			<div class="card-title">  	<h3>Data Name: ${filename }</h3></div>
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
                        <div class="card">
                            <div class="card-title">
                                <h4>Student's T-test</h4>
                            </div>
                            <div class="card-body">
                                <div class="horizontal-form-elements">
                                    <form id="ttestform" class="form-horizontal">
                                    <!--step 1 (select method)  -->
                                    <!-- /# column -->
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                   <p>Method<code>(Required)</code></p>
                                                    <div class="col-sm-10">                                                        
                                                        <select id='ttest_method' class="form-control">
                                                       			<option>---select----</option>
																<option value="one">One Sample t-test</option>
																<option value="two">Two Sample t-test</option>
														</select>
                                                    </div>
                                                </div>   
                                            </div>
                                            <input type="hidden" name="x">
                                             <input type="hidden" name="alternative">
                                               <input type="hidden" name="conflevel" ">
                                               <input type="hidden" name="y">
                                               <input type="hidden" name="paired">
                                               <input type="hidden" name="varequal">
                                                <input type="hidden" name="mu">                                                  
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- /# card -->
                    </div>
                    
                    
                    
                                                                   <!-- param section!!!  -->                                               
              	   <div id="ttestone" class="row">
              	   <div  class="col-lg-12">
                        <div  class="card">
                            <div class="card-title">
                                <h4>Detail Parameter(one-sample)</h4>
                            </div>
                            <div class="card-body">
                             <div class="form-group">
	                            <div class="bttonn-list">
	                            	 <div class="btn-group-vertical">
	                                      <p>Variable<code>(Required)</code></p><button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
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
                            <div class="row">
                            <div class="col-lg-4">
                                        <div class="form-group">
                                            <p>Alternative<code>(default: Two.Sided)</code></p><button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
	                                      <span name="alternative" class="caret">select</span></button>
	                                        <ul name="select" id="alternative" class="dropdown-menu" role="menu">
													<li name="two.sided">Two.Sided</li>
													<li name="less">One.Sided(Less)</li>
													<li name="greater">One.Sided(Greater)</li>
	                                        </ul>
                                        </div>
	
                                        <div class="form-group">
                                        	<p>mu<code>(default: 0, H0: mean of X = 0)</code></p>
                                            <p class="text-muted m-b-15 f-s-12">Please input it yourself</p>
                                            <input type="text" id="ttestonemu"  class="form-control input-rounded" placeholder="0">
                                        </div>                                        
                                
							</div>
							 <div class="col-lg-4">
                                       <div class="form-group">
                                            <p>Confidence level<code>(default: 0.95)</code></p><button type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
	                                      <span name="conflevel" class="caret">select</span></button>
	                                        <ul name="select" id="conflevel" class="dropdown-menu" role="menu">
													<li name="0.99">99%</li>
													<li name="0.97">97%</li>
													<li name="0.95">95%</li>
													<li name="0.9">90%</li>
													<li name="input">Input</li>													
	                                        </ul>
                                        </div>

                                        <div id="directinput" class="form-group">
                                            <p class="text-muted m-b-15 f-s-12">Please input it yourself <code>(0~ 1.0) </code></p>
                                            <input type="text" id="ttestoneconflevel" class="form-control input-rounded" placeholder="0.95">
                                        </div>                                                 
							</div>
							</div>
						</div>	
						 <button id="startanl" class="btn btn-primary btn-block m-b-6" type="button">Start Anl</button>
                   </div>
                  
                    <div  class="col-lg-12">
                        <div class="card">
                            <div class="card-title">
                                <h4>Result</h4>
                            </div>
                            <div class="card-body">
                            	     <h4 class="card-title">one-sample T-test</h4>  
                            	     <h4 id="ttestonevar"></h4> 
                            	     <p  id="ttestoneresult"></p>
									<img id="ttestoneimg1">
									<img id="ttestoneimg2">     
                            </div>
						</div>	
						
                   </div>
                   </div>
                   <div id="ttesttwo" class="col-lg-12">
                        <div class="card">
                            <div class="card-title">
                                <h4>Detail Parameter(two-sample)</h4>
                            </div>
                            <div class="card-body">
                            	                            
                            </div>
						</div>
                   </div>                          	
         </div>
</div>

<script>
$(document).ready(function(){
	 $('#ttestone').hide();
	 $('#ttesttwo').hide();
	 $('#directinput').hide();

	 $('#ttestonemu').bind('change keyup paste', function () {
		$('input[name=mu]').attr('value',$(this).val())
	 })
	 $('#ttestoneconflevel').bind('change keyup paste', function () {
		$('input[name=conflevel]').attr('value',$(this).val())
	 })

})


$(function(){
	 $("#ttest_method").change(function(){
	 if($(this).val() =="one"){
		 $('#ttestone').show();
		 $('#ttesttwo').hide();
	  }else{
		 $('#ttesttwo').show();
	  	 $('#ttestone').hide();
	  }
	});
});


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
$('ul[name=select] li').click(function(){
	var a =$(this).parent().attr('id');
	$('span[name='+a+']').text($(this).html());	
	$('input[name='+a+']').val($(this).attr('name'));
})


$('#startanl').click(function(){

	if ( ($('input[name=x]').val()).length<1 ){
		alert("Please select variable!!")
	}else if(isNaN($('input[name=mu]').val())){
		alert("mu must be number")
	}else if(isNaN($('input[name=conflevel]').val())){
		alert("confidence level must be number")
	}else{
		$('#ttestoneimg1').attr('src',"");
    	$('#ttestoneimg2').attr('src',"");
    	$('#startanl').hide()
    	$('#ttestoneresult').hide()
    	$('#ttestonevar').hide()
		var formData = $("#ttestform").serialize();
		$.ajax({
				type : "POST",
				url : "../meanestimator/ttest.do",
				cache : false,
				data : formData,
				success:function(data){
					var a = JSON.parse(data);					
		        	$('#ttestonevar').html(a.xvar);
		        	$('#ttestoneresult').html(a.result);
		        	$('#ttestoneimg1').attr('src',a.imgpath1);
		        	$('#ttestoneimg2').attr('src',a.imgpath2);
		        	$('#ttestoneresult').show()
		        	$('#ttestonevar').show()
		        	$('#startanl').show()
		         },
		        error:function(){
		           alert("fail")
		        }
			});
		
	}
	
})

$('#conflevel li').click(function(){
	if ($(this).attr('name')=='input'){
		$('#directinput').show();
		
	}else{
		$('#directinput').hide();
	}
})

</script>        