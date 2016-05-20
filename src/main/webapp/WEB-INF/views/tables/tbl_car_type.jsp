<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row">
	<div class="col-sm-12">
		<div class="table-wrapper">
			<div class="table-header">
				<div class="row">
					<div class="col-sm-12">
						<span>
							<h3>Menage Car Types</h3>
						</span>
						<spring:url value="/cartype/add" var="addUrl" />
						<button onclick="add_modal('${addUrl}')" class="btn btn-primary">Add
							new</button>
					</div>
				</div>
			</div>
			<div class="table-action">
				<div class="row">
					<div class="col-sm-4">
						<select class="form-control per-page-select">
							<option>10</option>
							<option>20</option>
							<option>30</option>
						</select> <span>per page</span>
					</div>
					<div class="col-sm-8" style="text-align: right">
						<div class="btn-group btn-group-sm" role="group"
							aria-label="Default button group">
							<button type="button" class="btn btn-default">Excel</button>
							<button type="button" class="btn btn-default">PDF</button>
							<button type="button" class="btn btn-default">Print</button>
						</div>
						<span>Search: </span> <input class="form-control search-imput"
							type="text">
					</div>
				</div>
			</div>
			<div class="table-body">
				<div class="row">
					<div class="col-sm-12">
						<table class="table" tyle="color:black">
							<thead>
								<tr>
									<th></th>
									<th>Name</th>
									<th>Type</th>
									<th>Producer</th>
									<th>Automatic</th>
									<th>car id</th>
									<th></th>
								</tr>
							</thead>
							<c:forEach items="${cartypes}" var="cartype">
								<tr>
									<td>${cartype.id}</td>
									<td>${cartype.name}</td>
									<td>${cartype.type}</td>
									<td>${cartype.producer}</td>
									<c:if test="${cartype.automatic}">
										<td><i class="fa fa-check"></i></td>
									</c:if>
									<c:if test="${!cartype.automatic}">
										<td></td>
									</c:if>
									<td><c:forEach items="${cartype.tblcars}" var="car">
										${car.id}
									</c:forEach></td>
									<td>
									<spring:url value="/cartype/edit/${cartype.id}" var="editUrl"></spring:url>
									<spring:url value="/cartype/update/${cartype.id}" var="updatetUrl"></spring:url>
									<spring:url value="/cartype/delete/${cartype.id}" var="deleteUrl"></spring:url>
									<spring:url value="/cartype/" var="reloadtUrl"></spring:url>
										<button type="button"
											onclick="edit_modal('${editUrl}','${updatetUrl}','${reloadtUrl}')"
											class="btn btn-default edit_record">
											<i class="fa fa-pencil"></i>
										</button>
										<button type="button"
											onclick="confirm_modal('${deleteUrl}','cartype')"
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
							<li><a href="#" aria-label="Previous"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
							<c:forEach items="${pList}" var="page">
								<li><a href="#">${page}</a></li>
							</c:forEach>
							<li><a href="#" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
