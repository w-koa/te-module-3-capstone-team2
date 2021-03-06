<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
			<h1>Welcome to ${park.parkName}!</h1>
		</header>
		<c:set var="parkImage" value="${park.parkCode}" />
		<c:set var="parkImageLc" value="${fn:toLowerCase(parkImage) }" />
		<c:url var="image" value="/img/parks/${parkImageLc}.jpg" />
		<img src="${image}" alt="parkPic" />

		<div class="quoteBlock">
			<h2>
				<c:out value="${park.quote}" />
			</h2>
			<h4>
				-
				<c:out value="${park.quoteAuthor}" />
			</h4>
		</div>
		<div class="entryAndCamp">
			<div>
				<p>
					<span class="bold">Entry Fee: </span>
					<c:out value="$${park.entryFee}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Campsites: </span>
					<c:out value="${park.numberOfCampsites}" />
				</p>
			</div>
		</div>
		<div>
			<p>
				<c:out value="${park.description}" />
			</p>
			<h2>More Park Facts!</h2>
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
					<fmt:formatNumber type="number" var="visitorsFmt" value="${park.annualVisitors}"/>
					<c:out value="${visitorsFmt}" />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Acreage: </span> 
					<fmt:formatNumber type="number" var="acresFmt" value="${park.acreage}"/>
					<c:out value="${acresFmt} Acres"/>
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Elevation: </span>
					<fmt:formatNumber type="number" var="elevationFmt" value="${park.elevationInFeet}"/>
					<c:out value="${elevationFmt} ft." />
				</p>
			</div>
			<div>
				<p>
					<span class="bold">Trails: </span>
					<fmt:formatNumber type="number" var="trailsFmt" value="${park.milesOfTrail}"/>
					<c:out value="${trailsFmt} mi." />
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

		</div>


	</div>
	<div class="forecastHead">
		<div>
			<h2>Park 5-Day Weather Forecast</h2>
		</div>
		<div>
			<p>Select your temperature preference:</p>
			<c:url var="setTempPref"
				value="/park/details?parkCode=${park.parkCode}" />
			<form method="POST" action="${setTempPref}">
				<input type="radio" id="fahrenheit" name="tempPreference" value="F"
					checked> <label for="fahrenheit">Fahrenheit</label> <input
					type="radio" id="celcius" name="tempPreference" value="C">
				<label for="celcius">Celcius</label> <input type="submit"
					value="Choose" />
			</form>
		</div>
	</div>

	<div class="weatherContainer">

		<c:forEach var="forecast" items="${forecasts}">

			<div class="weatherBlock">
				<c:if test="${forecast.forecastValue == 1}">
					<h2>Today</h2>
				</c:if>
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
					<div>
						<table>
							<tr>
								<th>High</th>
								<th>Low</th>
							</tr>
							<tr>
								<td><c:out value="${forecast.highTemp}�${tempPreference}" /></td>
								<td><c:out value="${forecast.lowTemp}�${tempPreference}" /></td>
							</tr>
						</table>
					</div>
					<div>
						<p style="font-weight: bold">National Park Geek Weather
							Advice:</p>
						<p>
							<c:out value="${forecast.recommendation}" />
						</p>

					</div>
				</div>
			</div>
		</c:forEach>


	</div>





</section>




<c:import url="/WEB-INF/jsp/common/footer.jsp" />