
<head>

<style>


.first form p span{
	line-height: 0px;
}


.firstset img{
	width:250px;
	height:250px;
}
.firstset form{
  position: absolute;
  top: 50%;
  left: 50%;
  margin-top: 150px;
  margin-left: -175px;
  width: 350px;
  height: 350px;
  border: dashed 2.5px rgba(210, 215, 217, 0.75);
  padding : 25px;
}

.firstset form p{

  text-align: center;
  line-height: 100px;
  color: black;
  font-family: Arial;
}
.firstset form input{
  position: absolute;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  outline: none;
  opacity: 0;
}

#nav ul li #step1{
   background-color: #F2F6FE;
   color: #f56a6a;
  }
</style>
</head>

<div class="firstset">
	<form action="step2.do"  enctype="multipart/form-data" method="post" id="fileform">
	 	  <input type="file" id="uploadfile" name="uploadfile" required>
		  <p><img src="/Anl/img/interface2.png"><br>Drag your files here or click in this area.</p>
	</form>
</div>

	


<script>
function showname () {
    var name = document.getElementById('uploadfile');
    var list = [ name.files.item(0).name, name.files.item(0).size, name.files.item(0).type];
    return list;
  };

$(document).ready(function(){
	  $('form input').change(function () {
	    var list = showname();
		$('form p').html("<span>FileName: "+list[0]+"<br>FileSize: "+list[1]+"byte</span>");
		var str = list[0];
		str = str.substring(str.length - 3,str.length);
		if (str=="csv"){
			document.getElementById("fileform").submit();//auto submit
		}else{
			// if uploadfile is not .csv...
			$('form p').html("<span>Input CSV file!!</span>");
		}
		
		
		//location.href="step2.do?fileName="+list[0];
			    
	  });
	});
	
$(document).ready(function(){ 
    $("#nav ul li #anlnav").addClass("on");
    $(".opener").addClass("active");
    $("#nav ul li #step1").addClass("on");
});
</script>
