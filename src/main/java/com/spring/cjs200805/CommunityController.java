package com.spring.cjs200805;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs200805.service.CommunityService;
import com.spring.cjs200805.vo.CommunityVo;

@Controller
@RequestMapping("/community")
public class CommunityController {
	String msgFlag = "";
	
	
	@Autowired
	CommunityService communityService;
	
	@RequestMapping(value="/cmList", method=RequestMethod.GET)
	public String cmListGet(Model model) {
		
		List<CommunityVo> vos = communityService.getComList(); 
		
		System.out.println("vos:" + vos);
		model.addAttribute("vos", vos);
		
		return "community/cmList";
	}
	
	@RequestMapping(value="/cmInput", method=RequestMethod.GET)
	public String cmInputGet() {
		
		return "community/cmInput";
	}
	
	@RequestMapping(value="/cmInput", method=RequestMethod.POST)
	public String cmInputPost(CommunityVo vo) {
		System.out.println("CommunityVo : " + vo);
		
		
		
		communityService.setComInput(vo);
		
		
		msgFlag ="cmInputOk";
		return "redirect:/mg/" + msgFlag;
	}
	
	@ResponseBody
	@RequestMapping(value="/cmDelete", method=RequestMethod.GET)
	public int cmDeleteGet(int idx, CommunityVo vo) {
		System.out.println("idx : " + idx);
		communityService.setComDeleteGet(idx, vo);
		System.out.println("vo : " + vo);
		
		return 1;
	}
		  
	@RequestMapping(value="/cmNDelete", method=RequestMethod.GET)
	public String cmNDeleteGet(HttpServletRequest request, Model model, HttpSession session) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int pwd = Integer.parseInt(request.getParameter("pwd"));
		
		
		System.out.println("pwd : " + pwd);
		System.out.println("idx : " + idx);

		CommunityVo vo =  communityService.passwordCheck(idx, pwd);
		System.out.println("vo : " + vo);
		
		if(vo != null) {
		
		communityService.setComNDeleteGet(idx, vo);
		System.out.println("idx : " + idx);
		msgFlag = "cmNDeleteOk";
		
		}
		else {
			msgFlag = "cmNDeleteNo$idx="+idx;
		}
		
		return "redirect:/mg/" + msgFlag;
	}
	

	@RequestMapping(value="/cmUpdate", method=RequestMethod.GET)
	public String cmUpdateGet(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println("idx : " + idx);
		
		CommunityVo vo = communityService.getComUpdateGet(idx);
		System.out.println("vo : " + vo);
		
		model.addAttribute("vo", vo);
		
		
		return "community/cmUpdate";
	}
	
	@RequestMapping(value="/cmUpdate", method=RequestMethod.POST)
	public String cmUpdatePost(HttpServletRequest request , Model model, int idx, CommunityVo vo) {
		int pwd = Integer.parseInt(request.getParameter("pwd"));
		
		
		
		CommunityVo pvo =  communityService.passwordCheck(idx, pwd);
		System.out.println("pvo : " + pvo);
		
		if(pvo != null) {
			
			communityService.setComUpdatePost(vo);
			model.addAttribute("vo", vo);
			System.out.println("vo : " + vo);
			msgFlag = "cmUpdateCheckOk";
		}
		else {
			msgFlag = "cmUpdateCheckNo$idx="+idx;
		}
		
		return "redirect:/mg/" + msgFlag;
	}

	
	@RequestMapping(value="/cmContent", method=RequestMethod.GET)
	public String cmContentGet(HttpServletRequest request, Model model) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println("idx : " + idx);
		
		CommunityVo vo = communityService.getComContentGet(idx);
		System.out.println("vo : " + vo);
		
		model.addAttribute("vo", vo);
		
		
		return "community/cmContent";
	}

}
