<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:if test="${saveUrl eq 'add'}">
	<spring:url value="/car/add" var="submitUrl" />
</c:if>
<c:if test="${saveUrl eq 'update'}">
	<spring:url value="/car/update/${car.id}" var="submitUrl" />
</c:if>
<form:form modelAttribute="car" id="car_frm" action="${submitUrl}?${_csrf.parameterName}=${_csrf.token}"
	method="post" cssClass="form-horizontal" enctype="multipart/form-data">
	<div class="form-group">
		<label for="cartype-name" class="control-label col-sm-2">Name</label>
		<div class="col-sm-10">
			<form:select id="cartype-name" cssClass="form-control "
				path="tblcarType.name">
				<form:option value="0">--Chose car name--</form:option>
				<form:options items="${ctname}" />
			</form:select>
			<span id="name-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="cartype-type" class="control-label col-sm-2">Type</label>
		<div class="col-sm-10">
			<form:select id="cartype-type" cssClass="form-control"
				path="tblcarType.type">
				<form:option value="0">--Chose car type--</form:option>
				<form:options items="${cttype}" />
			</form:select>
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>

	<div class="form-group">
		<label for="cartype-automatic" class="control-label col-sm-2">Automatic</label>
		<div class="col-sm-10">
		<%-- <a href="${ctautomatic}"  >dfasd</a> --%>
			<c:if test="${ctautomatic eq 'BOTH'}">
				<form:checkbox id="cartype-automatic" cssClass="c"
					path="tblcarType.automatic" />
			</c:if>
			<c:if test="${ctautomatic eq 'TRUE'}">
				<form:checkbox value="true" id="cartype-automatic" cssClass="c" onclick="return false" onkeydown="return false"
					path="tblcarType.automatic" />
			</c:if>
			<c:if test="${ctautomatic eq 'FALSE'}">
				<form:checkbox value="false" id="cartype-automatic" cssClass="c" onclick="return false" onkeydown="return false"
					path="tblcarType.automatic" />
			</c:if>
			<%-- <c:if test="${ctautomatic eq 'FALSE'}">
				<form:checkbox onclick="return false" onkeydown="return false"
					id="cartype-automatic" cssClass="c" path="tblcarType.automatic" />
			</c:if>
 --%>
		</div>
	</div>

	<div class="form-group">
		<label for="car-regjistration_Number" class="control-label col-sm-2">Regjistration
			number</label>
		<div class="col-sm-10">
			<form:input id="car-regjistration_Number" cssClass="form-control"
				path="regjistration_Number" />
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="car-colorr" class="control-label col-sm-2">Color</label>
		<div class="col-sm-10">
			<form:input id="car-color" cssClass="form-control" path="color" />
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="car-date_of_Manufacturing" class="control-label col-sm-2">Regjistration
			Date</label>
		<div class="col-sm-10">
			<form:input id="car-date_of_Manufacturing" placeholder="YYYY/MM/DD" cssClass="form-control"
				path="date_of_Manufacturing" />
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="car-base_Price_Per_Day" class="control-label col-sm-2">Cmimi
			ditor</label>
		<div class="col-sm-10">
			<form:input id="car-base_Price_Per_Day" cssClass="form-control"
				path="base_Price_Per_Day" />
			<span id="type-error" class="help-block with-errors"></span>
		</div>
	</div>
	<div class="form-group">
		<label for="car-image" class="control-label col-sm-2">Foto</label>
		<div class="col-sm-10">
		 <c:if test="${not empty image}">
		 <img id="car-image-orig" style="opacity:0.8; border:1px solid #a6a6a6; margin-bottom:5px" alt="test" class="img-thumbnail"  src="data:image/jpeg;base64,${image}" width="150" height="150">
		 </c:if>
		 <c:if test="${empty image}">
			<img id="car-image-orig" style="opacity:0.4; border:1px solid #a6a6a6; margin-bottom:5px" alt="test" class="img-thumbnail"  src="<spring:url value="/resources/img/basic.png" />" width="150" height="150">
		 </c:if>	
			<input id="car-image" name="file" type="file"></input>
			<%-- <form:input id="car-image" cssClass="form-control"
				path="base_Price_Per_Day" />
			<span id="type-error" class="help-block with-errors"></span> --%>
		</div>
	</div>
	<input type="submit" id="cartype-update-btn" class="btn btn-default"
		value="${button}">
	<input type="button" id="cartype-update-btn" class="btn btn-default"
		value="Cancle">
	<!--  -->
</form:form>

