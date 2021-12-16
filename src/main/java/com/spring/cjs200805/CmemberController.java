package com.spring.cjs200805;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.cjs200805.service.CmemberService;
import com.spring.cjs200805.vo.CmemberVo;

@Controller
@RequestMapping("/cmember")
public class CmemberController {
	
	String msgFlag = "";
	
	@Autowired
	CmemberService cmemberService;
	
	@RequestMapping(value="/cmLogin", method=RequestMethod.POST)
	public String cmLoginPost(String mid, int pwd, HttpSession session) {
		System.out.println("mid : " + mid);
		System.out.println("pwd : " + pwd);
		CmemberVo vo =  cmemberService.getIdCheck(mid, pwd);
		
		
		
		System.out.println("vo : " + vo);		
				
		if(vo != null) {
			session.setAttribute("cmid", mid);
			msgFlag = "cmLoginOk";
		}
		else {
			
			msgFlag = "cmLoginNo";
		}
		
		
		return "redirect:/mg/"+ msgFlag;
	}
	
	
	@RequestMapping(value="/cmLogOut", method=RequestMethod.GET)
	public String cmLogOutGet() {
		
		msgFlag = "cmLogOutOk";
		
		return "redirect:/mg/" + msgFlag;
	}
	
}
