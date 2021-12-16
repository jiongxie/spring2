package com.spring.cjs200805;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.cjs200805.pagination.PageProcess;
import com.spring.cjs200805.pagination.PageVo;
import com.spring.cjs200805.service.PdsmService;
import com.spring.cjs200805.vo.PdsmVo;

@Controller
@RequestMapping("/pdsm")
public class PdsmController {
	String msgFlag = "";
	
	@Autowired
	PdsmService pdsmService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/pmList", method=RequestMethod.GET)
	public String pmListGet(@RequestParam(name="pag", defaultValue="1", required=false) int pag, HttpServletRequest request, Model model) {
		String part = request.getParameter("part")==null ? "전체" : request.getParameter("part");
		PageVo pageVo = pageProcess.pagination(pag, 5, "pdsm", part);
		
		List<PdsmVo> vos = pdsmService.pmList(pageVo.getStartNo(), pageVo.getPageSize(), part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("pageVo", pageVo);
		
		return "pdsm/pmList";
	}
	
	@RequestMapping(value="/pmInput", method=RequestMethod.GET)
	public String pmInputGet() {
		return "pdsm/pmInput";
	}
	
	@RequestMapping(value="/pmInput", method=RequestMethod.POST)
	public String pmInputPost(MultipartHttpServletRequest file, PdsmVo vo) {
		pdsmService.pmInput(file, vo);
		
		msgFlag = "pmInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	@ResponseBody
	@RequestMapping(value="/pmDelete", method=RequestMethod.GET)
	public int pmDeleteGet(int idx) {
		System.out.println("idx: " + idx);
		pdsmService.setPmDeleteGet(idx);
		
		return 1;
	}

	
	@ResponseBody
	@RequestMapping(value="/downCheck", method=RequestMethod.GET)
	public int downCheckGet(int idx) {
		pdsmService.setDownCheck(idx);
		return 1;
	}
	
	@RequestMapping(value="/pmDown", method=RequestMethod.GET)
	public String pmDownGet(HttpServletRequest request, PdsmVo vo) throws IOException {
		String directory = request.getSession().getServletContext().getRealPath("/resources/pdsm/");
		
		String[] fNames = vo.getFname().split("/");
		String[] rfNames = vo.getRfname().split("/");
		
		FileInputStream fis = null;
		
		// 압축에 필요한 작업.
		String zipPath = directory + "imsi/";     // 압축파일을 만들어줄 폴더
		String zipName = vo.getTitle() + ".zip";  // 기존파일들을 압축할 파일명은 '타이틀.zip'
		ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(zipPath + zipName)); // 압축시킬 출력스트림을 생성한다.
		
		System.out.println(zipPath + zipName);
		byte[] buffer = new byte[2048];
		
		for(int i=0; i<rfNames.length; i++) {
			System.out.println("rfanme :" + rfNames[i]);
			File file = new File(directory + rfNames[i]);
			File moveAndRename = new File(directory + "imsi/" + fNames[i]);
			
			file.renameTo(moveAndRename);  // 서버에 저장된 파일이 업로드된 파일명으로 이름이 바뀌면서 'imsi'폴더에 저장됨
			
			fis = new FileInputStream(moveAndRename);
			zout.putNextEntry(new ZipEntry(fNames[i]));
			
			// 아래쪽은 준비된 fis를 zout으로 출력(압축/저장) 시켜준다.
			int data;
			while((data = fis.read(buffer, 0, buffer.length)) != -1) {
				zout.write(buffer, 0, data);
			}
			
			zout.closeEntry();
			fis.close();
			
			moveAndRename.renameTo(file);
		}
		zout.close();
		
		return "redirect:/pdsm/pmDownAction?file="+java.net.URLEncoder.encode(zipName, "UTF-8");
		
	}
	
	@RequestMapping(value="/pmDownAction", method=RequestMethod.GET)
	public void downActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String rfname = request.getParameter("file");
		String downPath = request.getSession().getServletContext().getRealPath("/resources/pdsm/imsi/")+rfname;
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
		
		new File(downPath).delete(); // imsi폴더의 zip파일을 삭제처리한다.
	}
	
	
}
