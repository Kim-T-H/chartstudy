<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Pie graph</title>
<script type="text/javascript"
	src="http://www.chartjs.org/dist/2.9.3/Chart.min.js">
</script>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
	url="jdbc:mariadb://localhost:3306/classdb" user="scott"
	password="1234" />
<sql:query var="rs" dataSource="${conn}">
 select name,count(*) cnt from board
 group by name
 </sql:query>
</head>
<body>
	<div style="width: 100%">
		<canvas id="canvas"></canvas>
	</div>
	<script type="text/javascript">
	var randomColorFactor=function(){
		return Math.round(Math.random()*255);
	}
var randomColor =function(opacity){
	return "rgba("+randomColorFactor()+","
			+randomColorFactor()+","
			+randomColorFactor()+","
			+(opacity || ".3")+")";
};
var chartData={
		labels: [<c:forEach items="${rs.rows}" var="m">
		"${m.name}",</c:forEach>],
		datasets:[
			{	type:'pie',
				borderWidth:2,
				backgroundColor:[<c:forEach items="${rs.rows}" var="m">
				randomColor(1),</c:forEach>],
				label:'건수',
				data:[<c:forEach items="${rs.rows}" var="m">
					"${m.cnt}",</c:forEach>],
			}]
};

window.onload=function(){
	var ctx=document.getElementById('canvas').getContext('2d');
	new Chart(ctx,{
		type:'pie',
		data: chartData,
		options:{
			responsive:true,
			title:{display:true, text:'글쓴이 별 게시판 등록 건수', position:"bottom"}
		}
	})
}
</script>

</body>
</html>