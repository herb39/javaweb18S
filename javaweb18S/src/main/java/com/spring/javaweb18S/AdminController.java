package com.spring.javaweb18S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb18S.pagination.PageProcess;
import com.spring.javaweb18S.service.AdminService;
import com.spring.javaweb18S.service.MemberService;
import com.spring.javaweb18S.service.ShopService;
import com.spring.javaweb18S.service.SongService;
import com.spring.javaweb18S.vo.MemberVO;
import com.spring.javaweb18S.vo.ProductVO;
import com.spring.javaweb18S.vo.SongVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	SongService songService;
	
	@Autowired
	ShopService shopService;

	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMain() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeft() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContent(Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid) {
		
		List<MemberVO> memberVOS = memberService.getMemberListT(mid);
		List<SongVO> songVOS = songService.getSongListT();
		List<ProductVO> productVOS = shopService.getShopListT();
		
		model.addAttribute("memberVOS", memberVOS);
		model.addAttribute("songVOS", songVOS);
		model.addAttribute("productVOS", productVOS);
		
		return "admin/adminContent";
	}

}
