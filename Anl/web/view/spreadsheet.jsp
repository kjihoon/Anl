<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">

<link rel="icon"
	href="http://bossanova.uk/templates/default/favicon.ico"
	type="image/x-icon">
<link rel="stylesheet" type="text/css"
	href="http://fonts.googleapis.com/css?family=Open+Sans|Roboto|Dosis">
<link rel="stylesheet"
	href="http://bossanova.uk/templates/default/css/style.css"
	type="text/css" />


<script
	src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>

<script src="/Anl/css/sheet_assets/js/jquery.jexcel.js"></script>
<script src="/Anl/css/sheet_assets/js/jquery.jcalendar.js"></script>
<script src="/Anl/css/sheet_assets/js/excel-formula.min.js"></script>

<link rel="stylesheet"
	href="/Anl/css/sheet_assets/css/jquery.jexcel.css" type="text/css" />
<link rel="stylesheet"
	href="/Anl/css/sheet_assets/css/jquery.jcalendar.css" type="text/css" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<style>
a{
 color:white;
}
</style>
<style type="text/css">
   .jbFixed {
        position: fixed;
        top: 0px;
      }
    </style>
</head>
<body>
<div class="jbMenu">
<p id="presentdata">
		<a id='upload' class="btn btn-secondary" style="color:white" role="button">Spread Sheet (${filename })</a> 
		<a id='sendjson' class="btn btn-primary"   style="color:white" role="button">Re Upload</a>
	</p>
	<p id="directdata">
		<a id='upload2' class="btn btn-secondary"  style="color:white" role="button">Spread Sheet (empty)</a> 
		<a id='sendjson2' class="btn btn-primary"  style="color:white" role="button">Upload</a>
	</p>
	
</div>
	<div class="alert alert-danger" role="alert" id="result"></div>
	<div id="my"></div>
<form id="sendform" action="/Anl/anldata/sheet3.do" method="post">
	<input id="formjson" type="hidden" name="json" >
</form>
</body>

<script>

	$(document).ready(function() {
		$("#result").hide();
		$("#sendjson").hide()
		$("#sendjson2").hide()
		if ("${headername}".length > 1) {
			$("#presentdata").show()
		} else {
			$("#presentdata").hide()
		}
		//버튼 상단 고정
		 var jbOffset = $( '.jbMenu' ).offset();
	        $( window ).scroll( function() {
	          if ( $( document ).scrollTop() > jbOffset.top ) {
	            $( '.jbMenu' ).addClass( 'jbFixed' );
	          }
	          else {
	            $( '.jbMenu' ).removeClass( 'jbFixed' );
	          }
	        });		
	})
	
	$("#upload").click(
			function() {
				$.ajax({
					url : "/Anl/anldata/sheet2.do",
					async : false,
					success : function(data) {
						var a = JSON.parse(data);
						myexcel(a)
						$('#upload').removeClass('btn-secondary').addClass(
								'btn-primary');
						$("#sendjson").show()
						$("#directdata").hide()
						$("#upload").hide()						
					},
					fail : function() {
						alert("fail")
					}
					
				})
				
			})
	$("#upload2").click(function() {
		$("#sendjson2").show()
		$("#upload2").hide()
		directexcel()
	})
	
	function myexcel(data) {
		list = [];
		for (var i = 0; i < data.data[0].length; i++) {
			list.push(100);
		}
		$('#my').jexcel({
			data : data.data,
			tableOverflow:true,
			colHeaders : data.headername,
			colWidths : list,
		});
	}
	
	function directexcel() {
		$('#my').jexcel(
				{
					data : [ [ , , ], [ , , ], [ , , ], [ , , ], [ , , ],
							[ , , ], [ , , ], [ , , ], [ , , ], [ , , ] ],
							tableOverflow:true,
							colWidths : [ 100, 100, 100 ]
				});
		$('#upload2').removeClass('btn-secondary').addClass('btn-primary');
		$("#presentdata").hide()
	}
	
	function findempty(data){
		loop:
		for (var r=0;r< data.length;r++){
			for (var c=0;c<data[0].length;c++){
				if (data[r][c].length<1){
					
					return [c,r]
					break loop;
				}
			}
		}
		return true;	
	}
	function checkForm(){ 
	   
	} 

	var result="";	
	$('#sendjson').on('click', function() {
		var data = $('#my').jexcel('getData');
		var jsonstr = JSON.stringify(data);
		var json = JSON.parse(jsonstr);
		var flag = findempty(json)
		
		if (flag!=true){
			$('#my').jexcel('updateSettings', {
			    table: function (instance, cell, col, row, val, id) {
			    	if (col==flag[0]) {
			        	if(row ==flag[1]){
			        		$(cell).css('border-color', 'red');
			        		$("#result").show()
			        		$("#result").text("empty cell is not allowed *("+(Number(row)+1)+"행  "+(Number(col)+1)+"열)")
			        		 return; 
			        	}
			        	
			        }
			    }
			});
		}else{
			$("#formjson").attr("value",jsonstr);
			$("#sendform").attr("target","_parent"); 
			$("#sendform").submit();	
		}
	});
	$('#sendjson2').on('click', function() {
		var data = $('#my').jexcel('getData');
		var jsonstr = JSON.stringify(data);
		var json = JSON.parse(jsonstr);
		var flag = findempty(json)
		if (flag!=true){
			$('#my').jexcel('updateSettings', {
			    table: function (instance, cell, col, row, val, id) {
			        if (col==flag[0]) {
			        	if(row ==flag[1]){
			        		 $(cell).css('border-color', 'red');
			        		 $("#result").show()
				        	 $("#result").text("empty cell is not allowed *("+(Number(row)+1)+"행  "+(Number(col)+1)+"열)")
			        	}				               
			        }
			    }
			});
		}else{
	
			$("#formjson").attr("value",jsonstr);
			$("#sendform").attr("target","_parent"); 
			$("#sendform").submit();	
			
			
		}
	});
	
	

</script>
</html>