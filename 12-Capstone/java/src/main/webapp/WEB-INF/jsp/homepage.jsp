<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="/WEB-INF/jsp/common/header.jsp" />
<html>
<head>
<meta charset="ISO-8859-1">
<title>National Park Geek Home</title>
</head>

<div>
	<c:forEach var="park" items="${parks}">
		<div class="parkInfoBlock">

			<c:set var="parkImage" value="${park.parkCode}" />
			<c:set var="parkImageLc" value="${fn:toLowerCase(parkImage) }" />
			<c:url var="image" value="/img/parks/${parkImageLc}.jpg" />
			<c:url var="parkDetails" value="/park/details?code=${park.parkCode}"/>
			<a href="${parkDetails}"><img src="${image}" style="" alt="park photo" /></a>
			<div>
				<h2>
					<c:out value="${park.parkName}" />
				</h2>
				<h3>
					<c:out value="${park.state}" />
				</h3>
				<div>
					<p>
						<c:out value="${park.description}" />
					</p>
				</div>
			</div>


		</div>

	</c:forEach>


</div>

<c:import url="/WEB-INF/jsp/common/footer.jsp" />