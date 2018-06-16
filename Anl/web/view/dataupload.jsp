<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>

<style>
.container-fluid form img{
	width:350px;
	height:350px;
}
.container-fluid #fileform{
  position: relative;
  top: 50%;
  left: 50%;
  margin-left: -225px;
  width: 450px;
  height: 450px;
  border: dashed 2.5px rgba(210, 215, 217, 0.75);
  padding : 25px;
}

.container-fluid #fileform p{
  text-align: center;
  line-height: 100px;
  color: black;
}
.container-fluid #fileform input{
  position: absolute;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  outline: none;
  opacity: 0;
}

</style>
</head>
<div class="page-wrapper">
<!-- Bread crumb -->
            <div class="row page-titles">
                <div class="col-md-5 align-self-center">
                    <h3 class="text-primary">Data Upload</h3> </div>
                <div class="col-md-7 align-self-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
                        <li class="breadcrumb-item active">Data Upload</li>
                    </ol>
                </div>
            </div>
            <!-- End Bread crumb -->
  <div class="col-12">
         <div class="card">
                            <div class="card-body">
                            <h4 class="card-title">Only csv (*ver 1.0)</h4>
         <div class="container-fluid">
			<form action="/Anl/anldata/datasetting.do"  enctype="multipart/form-data" method="post" id="fileform">
			 	  <input type="file" id="uploadfile" name="uploadfile" required>
				  <p><img src="/Anl/img/interface2.png"><br>Drag your file here or click in this area.</p>
			</form>
		</div>
		</div>
		</div>
		</div>
		
</div>


	


<script>
function showname () {
    var name = document.getElementById('uploadfile');
    var list = [ name.files.item(0).name, name.files.item(0).size, name.files.item(0).type];
    return list;
  };

$(document).ready(function(){
	  $('#fileform input').change(function () {
	    var list = showname();
		$('#fileform p').html("<span>FileName: "+list[0]+"<br>FileSize: "+list[1]+"byte</span>");
		var str = list[0];
		str = str.substring(str.length - 3,str.length);
		if (str=="csv"){
			document.getElementById("fileform").submit();//auto submit
		}else{
			// if uploadfile is not .csv...
			$('#fileform p').html("<span>Input CSV file!!</span>");
		}
			    
	  });
	});
$('#side_dataupload').attr('class', 'active');
$('#side_dataupload #side_dataupload1').attr('class', 'active');
</script>