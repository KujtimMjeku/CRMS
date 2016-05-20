<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class="row">
	<div class="col-sm-8">
		<a href="#" style="display: block;"> <span
			style="color: gray; margin-top: 10px; font-size: 1.2em"
			class="glyphicon glyphicon-send" aria-hidden="true"> </span><span
			class="badge badge-notify" style="background-color: #21a9e1;">5</span></a>
		<h4>
			<small>RECENT POSTS</small>
		</h4>
	</div>
	<div class="col-sm-4">
		<sec:authorize access="authenticated">
			<div class="dropdown">
				<div id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="true">
					<i class="fa fa-user"></i>
				</div>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
					<li><a id="logout-btn" href="#"><i class="fa fa-sign-out"></i>logout</a>
						<spring:url value="/logout" var="logoutUrl" /> <form:form
							id="logout_frm" action="${logoutUrl}" method="POST">
						</form:form></li>
					<li><a href="#">Another </a></li>
				</ul>
			</div>
		</sec:authorize>
		<sec:authorize access="!authenticated">
		<spring:url value="/login" var="loginUrl"  />
			<a href="${loginUrl}"><i class="fa fa-sign-in"></i></a>
		</sec:authorize>
	</div>
</div>
<script>
	$(document).ready(function() {
		$("#logout-btn").click(function(e) {
			e.preventDefault();
			$("#logout_frm").submit();
		});
	});
</script>
<hr>
