<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="row">
	<div class="col-sm-12">
		<div class="table-wrapper">
			<div class="table-header">
				<div class="row">
					<div class="col-sm-12">
						<spring:url value="/accounts/groups/new/" var="addUrl" />
						<a href="#" onclick="edituser('${addUrl}')"
							class="btn btn-primary">Add new</a>
					</div>
				</div>
			</div>
			<div class="table-action">
				<div class="row">
					<div class="col-sm-4">
						<select id="perPage" class="form-control per-page-select">
							<c:forEach begin="10" end="30" step="10" var="pp">
								<c:if test="${perPage eq pp}">
									<option selected="selected">${pp}</option>
								</c:if>
								<c:if test="${perPage != pp}">
									<option>${pp}</option>
								</c:if>
							</c:forEach>

						</select> <span>per page</span>
					</div>
					<div class="col-sm-8" style="text-align: right">
						<div class="btn-group btn-group-sm" role="group"
							aria-label="Default button group">
							<button type="button" class="btn btn-default">Excel</button>
							<a href='<spring:url value="/car/pdf/" />'
								class="btn btn-default">PDF</a>
							<button id="print-btn" type="button" class="btn btn-default">Print</button>
						</div>
						<span>Search: </span> <input class="form-control search-imput"
							type="text">
					</div>
				</div>
			</div>
			<div class="table-body">
				<div class="row">
					<div class="col-sm-12">
						<table id="car-table" class="table" tyle="color:black">
							<thead>
								<tr>
									<th>Group name</th>
									<th>Number of users</th>
									<th>Authorities</th>
									<th></th>
								</tr>
							</thead>
							<c:forEach items="${groups}" var="group">
								<tr>
									<td>${group.name}</td>
									<td>${fn:length(group.members)}</td>

									<td><c:forEach items="${group.authorities}"
											var="authority">
											<span class="label label-default">${authority}</span>
										</c:forEach></td>
									<td>
									<spring:url value="/accounts/groups/edit/${group.id}" var="editUrl"></spring:url>
									<spring:url value="/accounts/groups/update/${group.id}" var="updatetUrl"></spring:url>
									<spring:url value="/accounts/groups/delete/${group.id}" var="deleteUrl"></spring:url>
									<spring:url value="/accounts/groups/" var="reloadtUrl"></spring:url>
											<button type="button"
												onclick="edit_modal('${editUrl}','${updatetUrl}','${reloadtUrl}')"
												class="btn btn-default edit_record">
												<i class="fa fa-pencil"></i>
											</button>
											<button type="button"
												onclick="confirm_modal('${deleteUrl}','${reloadtUrl}')"
												class="btn btn-default delete_record">
												<i class="fa fa-trash-o"></i>
											</button>
										</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>


			</div>
			<div class="table-footer1">
				<div class="row">
					<div class="col-sm-12">
						<span class="record-message">Showing 1 to ${records_count}
							of ${records_count} entries </span>
						<ul class="pagination">
							<c:if test="${actualpage gt 1}">
								<li><a
									href="<spring:url value="/car/page/${actualpage-1}"></spring:url>"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:if>
							<c:if test="${actualpage eq 1}">
								<li><a style="pointer-events: none; cursor: default;"
									href="<spring:url value="/car/page/${actualpage-1}"></spring:url>"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:if>
							<c:if test="${pList[0] gt 1}">
								<li><a href="#">-</a></li>
							</c:if>
							<c:forEach items="${pList}" var="page">

								<c:if test="${actualpage eq page}">
									<li class="active"><a
										href='<spring:url value="/car/page/${page}"></spring:url>'>${page}</a></li>
								</c:if>
								<c:if test="${actualpage != page}">
									<li><a
										href='<spring:url value="/car/page/${page}"></spring:url>'>${page}</a></li>
								</c:if>
							</c:forEach>
							<c:if test="${morePage}">
								<li><a href="#">-</a></li>
							</c:if>
							<c:if test="${actualpage < pList[fn:length(pList)-1]}">
								<li><a
									href="<spring:url value="/car/page/${actualpage+1}"></spring:url>"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:if>
							<c:if test="${actualpage eq pList[fn:length(pList)-1]}">
								<li><a style="pointer-events: none; cursor: default;"
									href="<spring:url value="/car/page/${actualpage+1}"></spring:url>"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<spring:url value="/car/perpage/" var="ppchangeurl"></spring:url>
<spring:url value="/car/" var="reload"></spring:url>
<script type="text/javascript">
	function printData() {
		var divToPrint = document.getElementById("car-table");
		newWin = window.open("");
		newWin.document.write(divToPrint.outerHTML);
		newWin.print();
		newWin.close();
	}

	$(document).ready(function() {

		$('#print-btn').on('click', function() {
			printData();
		})
		$("#perPage").change(function() {

			var chVal = $(this).val();
			$.ajax({
				url : "${ppchangeurl}?perPage=" + chVal + "&page=1",
				method : "GET",
				success : function(result) {

					$(location).attr("href", "${reload}");
					//jQuery('#edit_modal').find(".modal-body").html(result);
				}
			});
		});
	});
</script>
