<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<form:form modelAttribute="cartypee" id="cartype_frm" action=""
	method="post" cssClass="form-horizontal">
		<div class="form-group">
			<label for="cartype-name" class="control-label col-sm-2">Name</label>
			<div class="col-sm-10"> 
			<form:input id="cartype-name" cssClass="form-control " path="name" />
			<span id="name-error" class="help-block with-errors"></span>
			</div>
		</div>
		<div class="form-group">
			<label for="cartype-type" class="control-label col-sm-2">Type</label>
			<div class="col-sm-10"> 
			<form:input id="cartype-type" cssClass="form-control" path="type" />
			<span id="type-error" class="help-block with-errors"></span>
			</div>
		</div>
		<div class="form-group">
			<label for="cartype-producer" class="control-label col-sm-2">Producer</label>
			<div class="col-sm-10"> 
			<form:input id="cartype-producer" cssClass="form-control"
				path="producer" />
			<span id="producer-error" class="help-block with-errors"></span>
				</div>
		</div>

		<div class="form-group">
			<label for="cartype-automatic" class="control-label col-sm-2">Automatic</label>
			<div class="col-sm-10"> 
			<form:checkbox id="cartype-automatic" cssClass="c" path="automatic" />
			</div>
		</div>
		<input type="submit" id="cartype-update-btn" class="btn btn-default">
	<!--  -->
</form:form>
