package com.spring.cjs200805;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MgController {
	@RequestMapping(value="/mg/{msgFlag}", method=RequestMethod.GET)
	public String mgGet(@PathVariable String msgFlag, Model model, HttpSession session) {
		
		if(msgFlag.equals("cmInputOk")) {
			model.addAttribute("mg", "커뮤니티 등록 성공");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmLoginOk")) {
			model.addAttribute("mg", "관리자 로그인 성공!");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmLoginNo")) {
			model.addAttribute("mg", "관리자 로그인 실패!");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmLogOutOk")) {
			session.invalidate();
			model.addAttribute("mg", "관리자 로그아웃!");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmDeleteOk")) {
			session.invalidate();
			model.addAttribute("mg", "관리자 커뮤니티 삭제 성공!");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmNDeleteOk")) {
			session.invalidate();
			model.addAttribute("mg", "비회원 커뮤니티 삭제 성공!");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.equals("cmUpdateCheckOk")) {
			model.addAttribute("mg", "커뮤니티 업데이트 성공");
			model.addAttribute("url", "community/cmList");
		}
		else if(msgFlag.substring(0, 15).equals("cmUpdateCheckNo")) {
			model.addAttribute("mg", "비밀번호를 확인하세요");
			model.addAttribute("url", "community/cmUpdate?"+msgFlag.substring(16));
		}
		else if(msgFlag.substring(0, 11).equals("cmNDeleteNo")) {
			model.addAttribute("mg", "비밀번호를 확인하세요");
			model.addAttribute("url", "community/cmContent?"+msgFlag.substring(12));
		}

		
		return "include/mg";
	}
}
