<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:url value="/resources/js/jquery-1.12.0.min.js" var="jqueryJs" />
<spring:url value="/resources/js/bootstrap.min.js" var="bootstrapJs" />
<spring:url value="/resources/js/modal.js" var="modalJs" />


<script type="text/javascript" src="${jqueryJs}"></script>
<script type="text/javascript" src="${bootstrapJs}"></script>
<script type="text/javascript" src="${modalJs}"></script>
<spring:url value="/resources/css/bootstrap.min.css"
	var="bootstrapMinCss" />
<spring:url value="/resources/css/font-awesome.css" var="fontAwsomeCss" />
<spring:url value="/resources/css/style.css" var="styleCss" />
<spring:url value="/resources/css/style2.css" var="style2Css" />
<link rel="stylesheet" type="text/css" href="${bootstrapMinCss}">
<link rel="stylesheet" type="text/css" href="${fontAwsomeCss}">
<link rel="stylesheet" type="text/css" href="${styleCss}">
<link rel="stylesheet" type="text/css" href="${style2Css}">


<spring:url value="/car/json/types" var="typesUrl" />
<spring:url value="/car/json/automatic" var="automaticUrl" />
<script type="text/javascript">
	$(document).ready(
			function() {
				$('#cartype-name').on(
						'change',
						function() {
							var nameValue = this.value;
							$.ajax({
								url : "${typesUrl}",
								method : "GET",
								data : {
									"name" : nameValue
								},
								success : function(result) {
									var $el = $("#cartype-type");
									$el.empty();
									$el.append($("<option></option>").attr(
											"value", "0").text(
											"--Cholse one type--"));
									$.each(result, function(key, value) {
										$el.append($("<option></option>").attr(
												"value", value).text(value));
									});

								}
							});
						});
				$('#cartype-type').on(
						'change',
						function() {
							var typeValue = this.value;
							var nameValue = $('#cartype-name').val();

							$.ajax({
								url : "${automaticUrl}",
								method : "GET",
								data : {
									"name" : nameValue,
									"type" : typeValue
								},
								success : function(result) {
									if (result == "TRUE") {
										alert("true")
										$("#cartype-automatic").attr('onclick',
												"return false").attr(
												'onkeydown', "return false")
												.prop('checked', true).prop(
														"value", true);
									}
									if (result == "FALSE") {
										$("#cartype-automatic").prop('checked',
												false).prop('disabled', true)
												.prop("value", false);
									}
									if (result == "BOTH") {
										$("#cartype-automatic").prop('checked',
												false).prop("disabled", false);
									}

								}
							});
						});
			});
</script>

<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row content">
			<jsp:include page="../menus/adminmenu.jsp" />

			<div class="col-sm-9">
				<br> <br>
				<jsp:include page="../header/adminheader.jsp" />
				<div class="row">
					<div class="col-sm-6">
						<img class="img-rounded" src="data:image/jpeg;base64,${image}"
							width="450" height="300">
					</div>
					<div class="col-sm-6">
						<ul class="list-group" style="color:#4d4d4d">
							<li class="list-group-item"><strong>Vetura:</strong> ${car.tblcarType.name} ${car.tblcarType.type}</li>
							<li class="list-group-item"><strong>Prodhuesi:</strong> ${car.tblcarType.producer}</li>
							<c:if test="${car.tblcarType.automatic}">
							<li class="list-group-item"><strong>Marshi:</strong> Automatic</li>
							</c:if>
								<c:if test="${!car.tblcarType.automatic}">
							<li class="list-group-item"><strong>Marshi:</strong> Manual</li>
							</c:if>
							<li class="list-group-item"><strong>Numri i regjistrimit:</strong> ${car.regjistration_Number}</li>
							<li class="list-group-item"><strong>Data e prodhimit:</strong> ${car.date_of_Manufacturing}</li>
							<li class="list-group-item"><strong>Ngjyra:</strong> ${car.color}</li>
							<li class="list-group-item"><strong>Cmimi:</strong>  &#8364 ${car.base_Price_Per_Day}</li>
						</ul>
						<ul>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<p>Footer Text</p>
	</div>
	<%-- 	<jsp:include page="../modals/delete_modal.jsp" />
	<jsp:include page="../modals/car_type_frm_modal.jsp" /> --%>
</body>
</html>