package com.spring.cjs200805.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.cjs200805.dao.PdsmDao;
import com.spring.cjs200805.vo.PdsmVo;

@Service
public class PdsmServiceImp implements PdsmService {
	@Autowired
	PdsmDao pdsmDao;

	@Override
	public List<PdsmVo> pmList(int startNo, int pageSize, String part) {
		return pdsmDao.pmList(startNo, pageSize, part);
	}

	@Override
	public void pmInput(MultipartHttpServletRequest mfile, PdsmVo vo) {
		try {
			// 여러개의 파일 정보가 넘어오기에 List객체를 이용해서 담아준다.
			List<MultipartFile> fileList = mfile.getFiles("file");
			String oFileNames = "";     // 원본파일 리스트 누적
			String saveFileNames = "";  // 서버에 저장되는 파일리스트 누적
			int fileSizes = 0;          // 파일사이즈 누적
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				
			  // 서버에 저장되는 실제파일의 중복을 배제하기위해 파일명 뒤에 '년/월/일/시/분/초'을 추가해서 뒤에 확장자를 붙여서 저장한다.
				String saveFileName = saveFileName(oFileName);
				
			  // 실제 서버에 파일을 저장시킨다.(/resoruces/pdsm 폴더에 저장)
				writeFile(file, saveFileName);
				
				oFileNames += oFileName + "/";
				saveFileNames += saveFileName + "/";
				fileSizes += file.getSize();
			}
			
			vo.setFname(oFileNames);
			vo.setRfname(saveFileNames);
			vo.setFsize(fileSizes);
			System.out.println("vo : " + vo);
			
			pdsmDao.pmInput(vo);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		//request.getRealPath("/resources/pds/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/pdsm/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);  // 서버에 업로드 시킨 파일이 저장된다.
		
		fos.close();
	}

	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}
	
	@Override
	public void setDownCheck(int idx) {
		pdsmDao.setDownCheck(idx);
	}

	@Override
	public void setPmDeleteGet(int idx) {
		pdsmDao.setPmDeleteGet(idx);
	}

	
}
