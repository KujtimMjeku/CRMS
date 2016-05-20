<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:if test="${edit eq true }">
	<spring:url value="/accounts/update/" var="updateUrl"/>
</c:if>
<c:if test="${edit eq false }">
	<spring:url value="/accounts/create/" var="updateUrl"/>
</c:if>
<form:form modelAttribute="user" id="user_frm" action="${updateUrl}" method="post"
	cssClass="form-horizontal">
	<div class="form-group">
		<label for="user-username" class="control-label col-sm-2">Username</label>
		<div class="col-sm-10">
			<form:input id="user-username" cssClass="form-control "
				path="username" />
			<span id="username-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="user-name" class="control-label col-sm-2">Emri</label>
		<div class="col-sm-10">
			<form:input id="user-name" cssClass="form-control " path="name" />
			<span id="name-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="user-surename" class="control-label col-sm-2">Mbiemri</label>
		<div class="col-sm-10">
			<form:input id="user-surename" cssClass="form-control"
				path="surename" />
			<span id="surename-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="user-birthDay" class="control-label col-sm-2">Date
			linjda</label>
		<div class="col-sm-10">
			<form:input id="user-birthDay" cssClass="form-control"
				path="birthDay" />
			<span id="birthDay-error" class="help-block with-errors"></span>
		</div>
	</div>

	<div class="form-group">
		<label for="user-email" class="control-label col-sm-2">Emaili</label>
		<div class="col-sm-10">
			<form:input id="user-email" cssClass="form-control" path="email" />
			<span id="email-error" class="help-block with-errors"></span>
		</div>
	</div>

	<div class="form-group">
		<label for="user-telephone" class="control-label col-sm-2">Telefoni</label>
		<div class="col-sm-10">
			<form:input id="user-telephone" cssClass="form-control"
				path="telephone" />
			<span id="telephone-error" class="help-block with-errors"></span>
		</div>
	</div>

	<div class="form-group">
		<label for="user-address" class="control-label col-sm-2">Adresa</label>
		<div class="col-sm-10">
			<form:input id="user-address" cssClass="form-control" path="address" />
			<span id="address-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="groups-name" class="control-label col-sm-2">Type</label>
		<div class="col-sm-10">
			<form:select multiple="true" id="groups-name" cssClass="form-control"
				cssStyle="width:100%" path="groups">			
					<form:options items="${groups}" itemLabel="name" itemValue="id" />
					<form:options selected="selected" items="${user.groups}" itemLabel="name" itemValue="id" />
			</form:select>
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>

	<input type="submit" id="cartype-update-btn" class="btn btn-default">
	<!--  -->
</form:form>
