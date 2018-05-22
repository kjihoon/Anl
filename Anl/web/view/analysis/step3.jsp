<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<link rel="stylesheet" type="text/css" href="https://docs.handsontable.com/pro/bower_components/handsontable-pro/dist/handsontable.full.min.css">
<script src="https://docs.handsontable.com/pro/bower_components/handsontable-pro/dist/handsontable.full.min.js"></script>
<style>
#method{
  botton:10px;
  width:100%;
}
#method button{
  background:#1AAB8A;
  color:#fff;
  border:none;
  position:relative;
  height:60px;
  width:200px;
  font-size:1.6em;
  padding:0 2em;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  /* float:left; */
}
#method button:hover{
  background:#fff;
  color:#1AAB8A;
}
#method button:before,button:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #1AAB8A;
  transition:400ms ease all;
}
#method button:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
#method button:hover:before,button:hover:after{
  width:100%;
  transition:800ms ease all;
}
#startdiv{
	width : 1000px;
	height: 500px;
	border: 1px solid black;
	margin: 10px;
    padding: 10px;
}
</style>
</head>
<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';"href="javascript:void(0)"> 
<h1>(Data on)<br>View Table(${filename }, 소수점 2자리 까지 표현)</h1>
</a><div style="DISPLAY: none">
<div id="hot"></div> 
</div>

<div id="method">
		<button id="simplereg" onclick="window.location='/Anl/analysis/regression/simplereg.do';">Simple Regression</button>
		<button >Multiple Regression</button>
		<button id="ttest" onclick="window.location='/Anl/analysis/ttest.do';">Mean (T-test)</button>
		<button>Mean (ANOVA1)</button>
		<button>Mean (ANOVA2)</button>
		<button>Mean Estimator3</button>
		<button>Mean Estimator4</button>
		<button>Mean Estimator5</button>
		<button>Mean Estimator6</button>
		<button>Mean Estimator7</button>
</div>


<script>
 var dataObject =  ${dataob}
var hotElement = document.querySelector('#hot');
var hotElementContainer = hotElement.parentNode;
var hotSettings = {
  data: dataObject,
  columns: ${jr},
  stretchH: 'all',
  width: 1000,
  autoWrapRow: true,
  height: 500,
  maxRows: 300,
  manualRowResize: true,
  manualColumnResize: true,
  rowHeaders: true,
  colHeaders:  ${hn},
  filters: true,
  dropdownMenu: true
};
var hot = new Handsontable(hotElement, hotSettings);

var buttonhoover = "${buttonhoover}";
if (buttonhoover!=null){
	$('#'+buttonhoover).css("background-color","#fff");
	$('#'+buttonhoover).css("color","#1AAB8A");
}





</script>
