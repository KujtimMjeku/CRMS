<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>



<div class="modal fade" id="myModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="padding: 15px 15px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<p>Are you sure to delete this information ?</p>
			</div>
			<div class="modal-footer">
			<button type="button" id="delete_btn" class="btn btn-danger">Delete</button>
			
				
				<button type="button" class="btn btn-primary">Cancle</button>
				<form:form id="delete_form" action="">				
				</form:form>
			</div>
		</div>
	</div>
</div>