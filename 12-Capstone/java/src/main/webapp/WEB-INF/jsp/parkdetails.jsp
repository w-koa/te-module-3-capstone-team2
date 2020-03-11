<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<c:import url="/WEB-INF/jsp/common/header.jsp" />
<head>
<meta charset="ISO-8859-1">
<title>National Park Geek - Park Details</title>
</head>
<section>
	<div class="parkDetailContainer">
		<header>
			<h1>${park.parkName}</h1>
		</header>
		<c:set var="parkImage" value="${park.parkCode}" />
		<c:set var="parkImageLc" value="${fn:toLowerCase(parkImage) }" />
		<c:url var="image" value="/img/parks/${parkImageLc}.jpg" />
		<img src="${image}" alt="parkPic" />

		<div>
			<h3>
				<c:out value="${park.quote}" />
			</h3>
			<h4>
				-
				<c:out value="${park.quoteAuthor}" />
			</h4>
		</div>
		<div>
			<p>
				<c:out value="${park.description}" />
			</p>
			<div>
				<p>
					<span class="bold">State: </span>

					<c:out value="${park.state}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Year Founded: </span>
					<c:out value="${park.yearFounded}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Annual Visitors: </span>
					<c:out value="${park.annualVisitors}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Acreage: </span> ${park.acreage}
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Elevation: </span>
					<c:out value="${park.elevationInFeet} ft." />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Trails: </span>
					<c:out value="${park.milesOfTrail} mi." />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Campsites: </span>
					<c:out value="${park.numberOfCampsites}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Climate: </span>
					<c:out value="${park.climate}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Animal Species: </span>
					<c:out value="${park.animalSpecies}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Entry Fee: </span>
					<c:out value="$${park.entryFee}" />
				</p>
			</div>
		</div>


	</div>

	<div>
		<h2>Park 5-day Weather Forecast</h2>
	</div>

	<div class="weatherContainer">

		<c:forEach var="forecast" items="${forecasts}">
			<div class="weatherContainer">
				<c:choose>
					<c:when test="${forecast.forecast.equals('partly cloudy')}">
						<c:url var="forecastPic" value="/img/weather/partlyCloudy.png" />
						<img class="weatherPic" src="${forecastPic}" alt="partlycloudy" />
					</c:when>
					<c:otherwise>
						<c:url var="forecastPic"
							value="/img/weather/${forecast.forecast}.png" />
						<img class="weatherPic" src="${forecastPic}"
							alt="${forecast.forecast}" />
					</c:otherwise>
				</c:choose>


				<div>
					<h4>High</h4>
					<c:out value="${forecast.highInF}" />
				</div>
				<div>
					<h4>Low</h4>
					<c:out value="${forecast.lowInF}" />
				</div>




			</div>
		</c:forEach>


	</div>





</section>




<c:import url="/WEB-INF/jsp/common/footer.jsp" />