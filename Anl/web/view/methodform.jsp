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
			<div class="card-title">  	<h3>${filename } Information</h3></div>
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
                                <h4>T-test</h4>
                            </div>
                            <div class="card-body">
                                <div class="horizontal-form-elements">
                                    <form method="get" action="hihi" class="form-horizontal">
                                    <!--step 1 (select method)  -->
                                    <!-- /# column -->
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">Input Select</label>
                                                    <div class="col-sm-10">                                                        
                                                        <select class="form-control">
                                                       			<option>---select----</option>
																<option class="ttest_method" value="one">One Sample t-test</option>
																<option class="ttest_method" value="two">Two Sample t-test</option>
														</select>
                                                    </div>
                                                </div>                                                
                                            </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- /# card -->
                    </div>
                 <!-- param section!!!  -->
              	   <div class="col-lg-12">
                        <div class="card">
                            <div class="card-title">
                                <h4>Detail Parameter</h4>
                            </div>
                            <div class="card-body">
                            <h1>hihi</h1>
                            
                            </div>
						</div>
                   </div>                      	
         </div>
</div>        