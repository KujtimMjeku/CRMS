<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="col-sm-3 sidenav">
	<div
		style="text-align: center; width: 100%; border-bottom: 1px solid #aaaaac; padding-top: 30px; padding-bottom: 30px; background-color: #293741; color: #eeeeee">
		<i style="font-size: 50px; text-align: center;"
			class="fa fa-automobile"></i>
	</div>
	<div
		style="width: 100%; border-bottom: 1px solid #aaaaac; text-align: left; padding: 30px; background-color: #293741; color: #eeeeee; text-aligne: left; display: inline-block;">
		<div style="display: inline-block;">
			<img style="float: left; margin-top: 6px" src="<spring:url value="/resources/img/test.jpg"/>"
				class="img-circle" alt="Cinque Terre" width="50" height="50">
			<span style="padding-left: 10px; display: inline-block;">
				Welcome...<br /> Kujtim Mjeku<br />Status: <span
				style="color: #009933"> online</span>
			</span>
		</div>
	</div>
	
	<ul style="background-color: #293741;" class="nav nav-default">
		<li><a href="<spring:url value="/"/>" class="nav-elementt"> <span
				class="glyphicon glyphicon-dashboard" aria-hidden="true"> </span> <span
				id="nav-ele-text">Dashboard</span>
		</a></li>
		<li><a href="<spring:url value="/accounts/"/>" class="nav-elementt"><i
				class="fa fa-users"></i> Accounts </a></li>
		<li><a href="<spring:url value="/car/"/>" class="nav-elementt"><i
				class="fa fa-automobile"></i> Cars </a></li>
				
		<li><a href="<spring:url value="/cartype/"/>" class="nav-elementt"><i
				class="fa fa-automobile"></i> Cars type </a></li>
				
		<li><a href="#" class="nav-elementt"> <span
				class="glyphicon glyphicon-envelope" aria-hidden="true"> </span> <span
				id="nav-ele-text">Messages</span>
		</a></li>
		<li><a href="#" class="nav-elementt"> <span
				class="glyphicon glyphicon-home" aria-hidden="true"> </span> <span
				id="nav-ele-text">Agency</span>
		</a></li>
	</ul>
	<br>
</div>