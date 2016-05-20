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
						<span>
							<h3>Menage Cars</h3>
						</span>
						<spring:url value="/car/add" var="addUrl" />
						<a href="${addUrl}" class="btn btn-primary">Add new</a>
					</div>
				</div>
			</div>
			<div class="table-action">
				<div class="row">
					<div class="col-sm-4">
						<select id="perPage"  class="form-control per-page-select">
							<c:forEach begin="10" end="30" step="10" var="pp">
								<c:if test="${perPage eq pp}">
								<option selected="selected">${pp}</option>	
							</c:if>
							<c:if test="${perPage != pp}">
								<option >${pp}</option>	
							</c:if>
							</c:forEach>
		
						</select> <span>per page</span>
					</div>
					<div class="col-sm-8" style="text-align: right">
						<div class="btn-group btn-group-sm" role="group"
							aria-label="Default button group">
							<button type="button" class="btn btn-default">Excel</button>
							<a href='<spring:url value="/car/pdf/" />' class="btn btn-default">PDF</a>
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
									<th></th>
									<th>Name</th>
									<th>Type</th>
									<th>Regjistration number</th>
									<th>Color</th>
									<th>Date manufacturing</th>
									<th>Base price per day</th>
									<th>image</th>
									<th></th>
								</tr>
							</thead>
							<c:forEach items="${cars}" var="car">
								<tr>
									<td>${car.id}</td>
									<td>${car.tblcarType.name}</td>
									<td>${car.tblcarType.type}</td>
									<td>${car.regjistration_Number}</td>
									<td>${car.color}</td>
									<td>${car.date_of_Manufacturing}</td>
									<td>${car.base_Price_Per_Day}</td>
									<td><img src="data:image/jpeg;base64,${foto[car.id]}"
										width="30" height="30"></td>
									<td><spring:url value="/car/view/${car.id}" var="viewUrl" />
										<spring:url value="/car/edit/${car.id}" var="editUrl" /> <spring:url
											value="/car/delete/${car.id}" var="deleteUrl" /> <a
										type="button" href="${viewUrl}"
										class="btn btn-default edit_record"> <i
											class="fa fa-bookmark"></i>
									</a> <a type="button" href="${editUrl}"
										class="btn btn-default edit_record"> <i
											class="fa fa-pencil"></i>
									</a>
										<button type="button"
											onclick="confirm_modal('${editUrl}','car')"
											class="btn btn-default delete_record">
											<i class="fa fa-trash-o"></i>
										</button></td>
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
function printData()
{
   var divToPrint=document.getElementById("car-table");
   newWin= window.open("");
   newWin.document.write(divToPrint.outerHTML);
   newWin.print();
   newWin.close();
}


$(document).ready(function() {
	$('#print-btn').on('click',function(){
		printData();
		})
	$("#perPage").change(function(){
		
		 var chVal=$(this).val();
			$.ajax({
			url : "${ppchangeurl}?perPage="+chVal+"&page=1",
			method: "GET",
			success : function(result) {

				$( location ).attr("href","${reload}");
				//jQuery('#edit_modal').find(".modal-body").html(result);
			}
		}); 
	});
}); 
</script>
