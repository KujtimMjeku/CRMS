<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!-- Modal -->
<div class="modal fade" id="edit_modal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 style="color: gray;">
					Updating car type data
				</h4>
			</div>
			<div class="modal-body">
				<jsp:include page="../forms/frm_car_type.jsp" />
			</div>
		</div>
	</div>
</div>