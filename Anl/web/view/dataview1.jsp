<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    
<div class="page-wrapper">
<!-- Bread crumb -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Data View</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Data View</li>
                    </ol>
                </div>
            </div>
            <!-- End Bread crumb -->
         <div class="container-fluid">
         <div class="col-12">
         <div class="card">
                            <div class="card-body">
                            <h4 class="card-title">Data View</h4>
                                <c:if test="${data !=null}">
                                     <h6 class="card-subtitle">Export data to Copy, CSV, Excel, PDF & Print<br>
                                     Asc : Ascending<br>  Dsc : Descending
                                     </h6>
                                     
                                </c:if>
                                <c:if test="${data ==null}">                                	 
                               		 <h6 class="card-subtitle">Upload data</h6>
                               		  <button class="btn btn-danger btn-flat btn-addon m-b-10 m-l-5" onclick="window.location.href='/Anl/anldata/dataupload.do'">Upload</button>
                                </c:if>
                               
                                
                                <div class="table-responsive m-t-40">
                                    <table id="dataview" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
                                        <thead>
                                            <tr>
                                            	<th>#</th>
                                            	<c:forEach items="${headername }" var="i">
                                            		<th>${i }</th>
                                            	</c:forEach>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                            	<th>#</th>
                                                <c:forEach items="${headername }" var="i">
                                            		<th>${i }</th>
                                            	</c:forEach>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                        	<%int i =1; %>
                                        	<c:forEach items="${data }" var="row">
                                        		<tr>
                                        			<td><%=i %></td>
                                        			<c:forEach items="${row }" var="col">                                        				
                                        				 <td>${col }</td>                                       				
                                        			</c:forEach> 
                                        			<%i++; %>                                       			
                                        		</tr>                                        		                                        	
                                        	</c:forEach>                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                          
                        </div>
         	</div>	
         </div>
</div>
        
 <script src="/Anl/css/js/lib/datatables/datatables.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/dataTables.buttons.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.flash.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.html5.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/cdn.datatables.net/buttons/1.2.2/js/buttons.print.min.js"></script>
    <script src="/Anl/css/js/lib/datatables/datatables-init.js"></script>
    
    

    <script>
	
    $(document).ready(function() {
    	var redirect = "${redirect}";
    	if (redirect.length>1){
    		window.loaction.href='/Anl/anldata/redirectdataview1.do';
    	}
        $(document).ready(function() {
            var table = $('#dataview').DataTable({
                "columnDefs": [{
                    "visible": false,
                    "targets": 2
                }],
                "order": [
                    [2, 'asc']
                ],
                "displayLength": 25,
                "drawCallback": function(settings) {
                    var api = this.api();
                    var rows = api.rows({
                        page: 'current'
                    }).nodes();
                    var last = null;
                    api.column(2, {
                        page: 'current'
                    }).data().each(function(group, i) {
                        if (last !== group) {
                            $(rows).eq(i).before('<tr class="group"><td colspan="5">' + group + '</td></tr>');
                            last = group;
                        }
                    });
                }
            });
            // Order by the grouping
            $('#dataview tbody').on('click', 'tr.group', function() {
                var currentOrder = table.order()[0];
                if (currentOrder[0] === 2 && currentOrder[1] === 'asc') {
                    table.order([2, 'desc']).draw();
                } else {
                    table.order([2, 'asc']).draw();
                }
            });
        });
    });
    $('#dataview').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    });


    </script>