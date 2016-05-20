<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
	<!-- edit form column -->
	<div class="col-md-12 col-sm-12 col-xs-12 personal-info" style="padding: 4px">
		<div style="margin-bottom: -60px; padding-left: 40px">
			<img src='<spring:url value="/resources/img/test.jpg"></spring:url>'
				class="avatar img-circle img-thumbnail" alt="avatar">
			<h3 style="display: inline-block; padding-left: 30px">${user.username}</h3>
		</div>
		<div class="" style="height: 65px; background-color: #eee"></div>
		<table class="table" style="background-color: #eee; margin: 0">
			<tr>
				<td>Emri</td>
				<td>${user.name}</td>
			</tr>
			<tr>
				<td>Mbiemri</td>
				<td>${user.surename}</td>
			</tr>
			<tr>
				<td>Date lindja</td>
				<td>${user.birthDay}</td>
			</tr>
			<tr>
				<td>Adresa</td>
				<td>${user.address}</td>
			</tr>
			<tr>
				<td>Email</td>
				<td>${user.email}</td>
			</tr>
			<tr>
				<td>Telephone</td>
				<td>${user.telephone}</td>
			</tr>
			<tr>
				<td>Roli</td>
				<td><c:forEach items="${user.groups}" var="group">
											<span class="label label-primary">${group.name}</span>
										</c:forEach></td>
			</tr>
		</table>
		<a class="btn btn-default modal-close-btn"
			style="float: right; margin: 10px 20px 10px 0px">Close</a>

	</div>
</div>