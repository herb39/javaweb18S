package com.spring.javaweb18S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb18S.service.SongService;
import com.spring.javaweb18S.vo.ChartVO;

@Controller
public class HomeController {
	
	@Autowired
	SongService chartService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		List<ChartVO> vos = chartService.getChart();
		
		model.addAttribute("vos", vos);
		
		return "home";
	}
	
	
}
