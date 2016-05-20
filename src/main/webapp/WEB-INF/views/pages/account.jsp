<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:url value="/resources/js/jquery-1.12.0.min.js" var="jqueryJs" />
<spring:url value="/resources/js/bootstrap.min.js" var="bootstrapJs" />
<spring:url value="/resources/js/modal.js" var="modalJs" />
<spring:url value="/resources/js/select2.js" var="select2Js" />

<spring:url
	value="/resources/js/jquery-ui-1.11.4.custom/jquery-ui.min.js"
	var="jqueryUi" />
<spring:url
	value="/resources/js/jquery-ui-1.11.4.custom/jquery-ui.min.css"
	var="jqueryUiCss" />

<script type="text/javascript" src="${jqueryJs}"></script>
<script type="text/javascript" src="${jqueryUi}"></script>
<script type="text/javascript" src="${bootstrapJs}"></script>
<script type="text/javascript" src="${modalJs}"></script>
<script type="text/javascript" src="${select2Js}"></script>
<spring:url value="/resources/css/bootstrap.min.css"
	var="bootstrapMinCss" />
<spring:url value="/resources/css/font-awesome.css" var="fontAwsomeCss" />
<spring:url value="/resources/css/style.css" var="styleCss" />
<spring:url value="/resources/css/style2.css" var="style2Css" />
<spring:url value="/resources/css/select2.css" var="select2Css" />
<link rel="stylesheet" type="text/css" href="${bootstrapMinCss}">
<link rel="stylesheet" type="text/css" href="${fontAwsomeCss}">
<link rel="stylesheet" type="text/css" href="${styleCss}">
<link rel="stylesheet" type="text/css" href="${style2Css}">
<link rel="stylesheet" type="text/css" href="${select2Css}">
<link rel="stylesheet" type="text/css" href="${jqueryUiCss}">


<title>Insert title here</title>

</head>
<body>
	<div class="container-fluid">
		<div class="row content">
			<jsp:include page="../menus/adminmenu.jsp" />

			<div class="col-sm-9">
				<br> <br>
				<jsp:include page="../header/adminheader.jsp" />
				<h3>Users accounts</h3>

				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">All
							users</a></li>
					<li><a data-toggle="tab" href="#menu1">Admin users</a></li>
					<li><a data-toggle="tab" href="#menu2">Menager users</a></li>
					<li><a data-toggle="tab" href="#menu3">Customers 3</a></li>
				</ul>

				<div class="tab-content">
					<div id="home" class="tab-pane fade in active">
						<c:if test="${not empty password}">
						<div style="margin: 10px 0px 0px 0px" class="alert alert-success alert-dismissible" role="alert">
							<button type="button" class="close" data-dismiss="alert"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<strong>Account created!</strong> Your account is created
							successfuly with password <strong id="pas-alert">${password}</strong>
						</div>
						</c:if>
						<jsp:include page="../tables/tbl_users.jsp">
							<jsp:param value="${users}" name="users" />
							<jsp:param value="${records_count}" name="records_count" />
							<jsp:param value="${pList}" name="pList" />
						</jsp:include>
					</div>
					<div id="menu1" class="tab-pane fade">
						<h3>Menu 1</h3>
						<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco
							laboris nisi ut aliquip ex ea commodo consequat.</p>
					</div>
					<div id="menu2" class="tab-pane fade">
						<h3>Menu 2</h3>
						<p>Sed ut perspiciatis unde omnis iste natus error sit
							voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
					</div>
					<div id="menu3" class="tab-pane fade">
						<h3>Menu 3</h3>
						<p>Eaque ipsa quae ab illo inventore veritatis et quasi
							architecto beatae vitae dicta sunt explicabo.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<p>Footer Text</p>
	</div>
	<%-- 	<jsp:include page="../modals/delete_modal.jsp" />
	<jsp:include page="../modals/car_type_frm_modal.jsp" /> --%>

	<!-- Modal -->
	<div class="modal fade" id="view_user_modal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 style="color: gray;">View Profile</h4>
				</div>
				<div class="modal-body"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	function viewuser(username) {
		$.ajax({
			url : username,
			method : "GET",
			success : function(result) {
				jQuery('#view_user_modal').modal('show', {
					backdrop : 'static'
				});
				jQuery('#view_user_modal').find(".modal-body").html(result);
				$(".modal-close-btn").on('click', function() {
					$("#view_user_modal").modal('hide');
				})

			}
		});
	}
	function edituser(url) {
		$.ajax({
			url : url,
			method : "GET",
			success : function(result) {
				jQuery('#view_user_modal').modal('show', {
					backdrop : 'static'
				});
				jQuery('#view_user_modal').find(".modal-body").html(result);
				$(".modal-close-btn").on('click', function() {
					$("#view_user_modal").modal('hide');
				})
				$("#groups-name").select2({
					maximumSelectionLength : 3,
					placeholder : "Select role"
				});
				$("#user-birthDay").datepicker({
					changeMonth : true,
					changeYear : true
				});
				if ($("#user-birthDay").val()) {
					$("#user-birthDay").val(
							$.datepicker.formatDate('dd/mm/yy', new Date($(
									"#user-birthDay").val())));
				}
				;
				$("#user_frm").submit(function(e){
					var cartype_frm=$(this);
					var postUrl=$(this).attr("action");
					alert("test");
					e.preventDefault();
					$.ajax({
						url : postUrl,
						method: "POST",
						data: $('#user_frm').serialize(),
						success : function(result) {
							if(result.STATUS ==="success")
							{
								location.reload();
							}
							else if(result.STATUS ==="error")
							{
								var errors=result.VALUE;
								$(".with-errors").css("display","none");
								 $.each(errors, function(key, value) {				 
									 cartype_frm.find("#"+key+"-error").text(value).css("display","inline-block");
									  //console.log(key+" "+value)
								});
							}
							//jQuery('#edit_modal').find(".modal-body").html(result);
						}
					});
				});

			}
		});
	}
	function deleteuser(username) {
		$.ajax({
			url : username,
			method : "GET",
			success : function(result) {
				jQuery('#view_user_modal').modal('show', {
					backdrop : 'static'
				});
				jQuery('#view_user_modal').find(".modal-body").html(result);
				$(".modal-close-btn").on('click', function() {
					$("#view_user_modal").modal('hide');
				})

			}
		});
	}
	$(document).ready(function() {

		$(".nav-tabs li").on("click", function() {
			$(".nav-tabs li").removeClass("active");
			$(this).addClass("active");
		})

	})
</script>
</html>