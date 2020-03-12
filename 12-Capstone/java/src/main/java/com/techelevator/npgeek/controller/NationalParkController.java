package com.techelevator.npgeek.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.techelevator.npgeek.JdbcParkDao;
import com.techelevator.npgeek.JdbcSurveyDao;
import com.techelevator.npgeek.JdbcWeatherDao;
import com.techelevator.npgeek.Park;
import com.techelevator.npgeek.Survey;
import com.techelevator.npgeek.Weather;

@Controller
public class NationalParkController {

	@Autowired
	private JdbcParkDao parkDao;
	@Autowired
	private JdbcWeatherDao weatherDao;
	@Autowired
	private JdbcSurveyDao surveyDao;

	@RequestMapping(path = { "/", "/homepage" }, method = RequestMethod.GET)
	public String displayHome(ModelMap map, HttpSession session) {

		List<Park> parks = parkDao.getAllParks();
		map.addAttribute("parks", parks);
		session.setAttribute("parks", parks);

		return "homepage";
	}

	@RequestMapping(path = "/park/details", method = RequestMethod.GET)
	public String displayParkDetails(@RequestParam String parkCode, ModelMap map, HttpSession session) {

		if (session.getAttribute("tempPreference") == null) {
			session.setAttribute("tempPreference", "F");
		}
		String tempPref = (String) session.getAttribute("tempPreference");
		
		List<Weather> weatherForecasts = weatherDao.getForecastByCode(parkCode, tempPref);
		List<String> weatherRecommendList = new ArrayList<>();
		for (int i = 0; i < weatherForecasts.size(); i++) {
			String recommendation = weatherDao.makeRecommendation(weatherForecasts.get(i), tempPref);
			weatherRecommendList.add(recommendation);
		}
		System.out.println(weatherRecommendList.get(0));
		Park park = parkDao.getParkByCode(parkCode);
		map.addAttribute("forecasts", weatherForecasts);
		map.addAttribute("recommendList", weatherRecommendList);
		map.addAttribute("park", park);
		session.setAttribute("park", park);
		session.getAttribute("tempPreference");
		return "parkdetails";
	}

	@RequestMapping(path = "/park/details", method = RequestMethod.POST)
	public String getTemperaturePreference(@RequestParam String parkCode, @RequestParam String tempPreference,
			HttpSession session) {
		
		Park park = parkDao.getParkByCode(parkCode);
		session.setAttribute("park", park);
		session.setAttribute("tempPreference", tempPreference);
		
		return "redirect:/park/details?parkCode=" + parkCode;
	}
	
	@RequestMapping(path = "/survey", method = RequestMethod.GET)
	public String displaySurvey(ModelMap modelHolder) {

		 if (!modelHolder.containsAttribute("survey")) {
	            modelHolder.put("survey", new Survey());
	        }
		return "survey";
	}
	
	@RequestMapping(path = "/survey", method = RequestMethod.POST)
	public String submitSurvey(@Valid @ModelAttribute("survey") Survey survey, BindingResult result, 
			RedirectAttributes flash) {
		
		if (result.hasErrors()) {
            flash.addFlashAttribute("survey", survey);
            flash.addFlashAttribute(BindingResult.MODEL_KEY_PREFIX + "survey", result);
            flash.addFlashAttribute("message", "Please fix the following errors:");
            return "redirect:/survey";
        }
		
		surveyDao.saveSurvey(survey);
		
		return "redirect:/topParks";
	}
	
	@RequestMapping(path = "/topParks", method = RequestMethod.GET)
	public String displayTopParks(ModelMap map) {
		List<Park> surveyTopFive = surveyDao.getTopFiveParks();
		List <Park> topFiveParks = new ArrayList<>();
		
		for(int i = 0; i < surveyTopFive.size(); i++) {
			Park park = parkDao.getParkByCode(surveyTopFive.get(i).getParkCode());
			park.setParkVotes(surveyTopFive.get(i).getParkVotes());
			topFiveParks.add(park);
		}
		map.addAttribute("topFiveParks", topFiveParks);
		return "topparks";
	}

}
