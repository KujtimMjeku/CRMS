<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<ul class="pagination">
	<c:if test="${paginate.leftBtn}">
		<li><a
			href="<spring:url value="${paginate.url}${paginate.page-1}"></spring:url>"
			aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
		</a></li>
	</c:if>
	<c:if test="${!paginate.leftBtn}">
		<li class="disabled"><a
			aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
		</a></li>
	</c:if>
	<c:if test="${paginate.leftEmpty}">
		<li><a href="#">-</a></li>
	</c:if>
	<c:forEach items="${paginate.buttons}" var="page">

		<c:if test="${paginate.page eq page}">
			<li class="active"><a
				href='<spring:url value="${paginate.url}${page}"></spring:url>'>${page}</a></li>
		</c:if>
		<c:if test="${paginate.page != page}">
			<li><a
				href='<spring:url value="${paginate.url}${page}"></spring:url>'>${page}</a></li>
		</c:if>
	</c:forEach>
	<c:if test="${paginate.rightEmpty}">
		<li><a href="#">-</a></li>
	</c:if>
	<c:if test="${paginate.rightBtn}">
		<li><a
			href="<spring:url value="${paginate.url}${paginate.page+1}"></spring:url>"
			aria-label="next"> <span aria-hidden="true">&raquo;</span>
		</a></li>
	</c:if>
	<c:if test="${!paginate.rightBtn}">
		<li class="disabled"><a
			aria-label="next"> <span aria-hidden="true">&raquo;</span>
		</a></li>
	</c:if>
</ul>
