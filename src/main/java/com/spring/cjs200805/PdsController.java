package com.spring.cjs200805;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs200805.pagination.PageProcess;
import com.spring.cjs200805.pagination.PageVo;
import com.spring.cjs200805.service.PdsService;
import com.spring.cjs200805.vo.PdsVo;

@Controller
@RequestMapping("/pds")
public class PdsController {
	String msgFlag = "";
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/pList", method=RequestMethod.GET)
	public String pListGet(HttpServletRequest request, @RequestParam(name="part", defaultValue="전체", required=false) String part, Model model) {
		//String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		int pag = request.getParameter("pag")==null? 1 : Integer.parseInt(request.getParameter("pag"));
		//int pageSize = request.getParameter("pageSize")==null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		PageVo pageVo = pageProcess.pagination(pag, 5, "pds", part);
		
		List<PdsVo> vos = pdsService.getPList(pageVo.getStartNo(), pageVo.getPageSize(), part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("pageVo", pageVo);
		
		return "pds/pList";
	}
	
	@RequestMapping(value="/pInput", method=RequestMethod.GET)
	public String pInputGet() {
		return "pds/pInput";
	}

	@RequestMapping(value="/pInput", method=RequestMethod.POST)
	public String pInputPost(MultipartFile file, PdsVo vo) {
		pdsService.setPdsUpload(file, vo);
		
		msgFlag = "pdsInputOk";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	@ResponseBody
	@RequestMapping(value="/downCheck", method=RequestMethod.GET)
	public int downCheckGet(int idx) {
		pdsService.setDownCheck(idx);
		return 1;
	}
	
	@RequestMapping(value="/pDown", method=RequestMethod.GET)
	public String pDownGet(HttpServletRequest request, PdsVo vo) throws IOException {
		//@SuppressWarnings("deprecation")
		//String downPath = request.getRealPath("/resources/pds/")+vo.getRfname();
		String downPath = request.getSession().getServletContext().getRealPath("/resources/pds/")+vo.getRfname();
		File downFile = new File(downPath);
		
		if(!downFile.exists() || vo.getRfname().equals("")) {
			msgFlag = "pDownNo";
			return "redirect:/msg/" + msgFlag;
		}
		else {
			pdsService.setDownCopyCheck(vo);  // 데이터베이스에 다운로드수 1 증가
			return "redirect:/pds/downAction?file="+java.net.URLEncoder.encode(vo.getFname(),"UTF-8"); // 다운로드 class 호출
		}
	}
	
	@RequestMapping(value="/downAction", method=RequestMethod.GET)
	public void downActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String rfname = request.getParameter("file");
		String downPath = request.getSession().getServletContext().getRealPath("/resources/pds/imsi/")+rfname;
		File downFile = new File(downPath);
		
		String downFileName = null;  // 실제로 다운로드될 파일명
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {  // 사용자 브라우저갸 익스플러러가 아니면...
			downFileName = new String(rfname.getBytes("UTF-8"), "8859_1");
		}
		else {
			downFileName = new String(rfname.getBytes("EUC-KR"), "8859_1");
		}
		
		// 다운로드할 파일명과 형식을 다시 헤더파일에 담아서 전송처리한다.
		response.setHeader("Content-Disposition", "attachment;filename="+downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] b = new byte[1024];
		int data = 0;
		
		while((data = fis.read(b, 0, b.length)) != -1) {
			sos.write(b, 0, data);
		}
		sos.flush();
		
		sos.close();
		fis.close();
	}
}
