<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/js/jquery-1.12.0.min.js" var="jqueryJs" />
<spring:url value="/resources/js/bootstrap.min.js" var="bootstrapJs" />
<spring:url value="/resources/js/modal.js" var="modalJs" />


<script type="text/javascript" src="${jqueryJs}"></script>
<script type="text/javascript" src="${bootstrapJs}"></script>
<script type="text/javascript" src="${modalJs}"></script>
<spring:url value="/resources/css/bootstrap.min.css" var="bootstrapMinCss" />
<spring:url value="/resources/css/font-awesome.css" var="fontAwsomeCss" />
<spring:url value="/resources/css/style.css" var="styleCss" />
<spring:url value="/resources/css/style2.css" var="style2Css" />
<link rel="stylesheet" type="text/css" href="${bootstrapMinCss}">
<link rel="stylesheet" type="text/css" href="${fontAwsomeCss}">
<link rel="stylesheet" type="text/css" href="${styleCss}">
<link rel="stylesheet" type="text/css" href="${style2Css}">


<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row content">
			<jsp:include page="../menus/adminmenu.jsp" />

			<div class="col-sm-9">
				<br> ${username}<br>
				<jsp:include page="../header/adminheader.jsp" />
				<jsp:include page="../tables/tbl_car_type.jsp">
					<jsp:param value="${cartypes}" name="cartypes" />
					<jsp:param value="${records_count}" name="records_count"/>
					<jsp:param value="${pList}" name="pList"/>
				</jsp:include>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<p>Footer Text</p>
	</div>
	<jsp:include page="../modals/delete_modal.jsp" />
	<jsp:include page="../modals/car_type_frm_modal.jsp" />
</body>
</html>