<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<spring:url value="/resources/css/bootstrap.min.css" var="bootstrapMinCss" />
<spring:url value="/resources/css/loginStyle.css" var="loginStyleCss" />
<link rel="stylesheet" type="text/css" href="${bootstrapMinCss}">
<link rel="stylesheet" href="${loginStyleCss}">
<title>Insert title here</title>
</head>
<body>
	<div class="login-card">
		<h1>Log-in</h1>
		<br>
		<form:form name='f' action="/CRMS/login" method='POST'>
			<input type="text" id="username" name="username"
				placeholder="Username">
			<input type="password" id="password" name="password"
				placeholder="Password">
			<input type="submit" name="login" class="login login-submit"
				value="login">
			<c:if test="${param.error eq true}">
				<div class="alert alert-danger">
					Invalid username or password
				</div>
			</c:if>
			<c:if test="${param.logout eq true}">
				<div class="alert alert-success">
					You have been loged out successful
				</div>
			</c:if>
		</form:form>

		<div class="login-help">
			<a href="#">Register</a> • <a href="#">Forgot Password</a>
		</div>
	</div>
</body>
</html>