package com.spring.cjs200805.service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

import com.spring.cjs200805.dao.PdsDao;
import com.spring.cjs200805.vo.PdsVo;

@Service
public class PdsServiceImp implements PdsService {
	@Autowired
	PdsDao pdsDao;

	@Override
	public List<PdsVo> getPList(int startNo, int pageSize, String part) {
		return pdsDao.getPList(startNo, pageSize, part);
	}

	@Override
	public void setPdsUpload(MultipartFile file, PdsVo vo) {
		try {
			String oFileName = file.getOriginalFilename();
			String preFileName = oFileName.substring(0,oFileName.lastIndexOf(".")); // 순수한 파일명
			String extFileName = oFileName.substring(oFileName.lastIndexOf(".")+1); // 확장자명
			
			// 서버에 저장되는 실제파일의 중복을 배제하기위해 파일명 뒤에 '년/월/일/시/분/초'을 추가해서 뒤에 확장자를 붙여서 저장한다.
			String saveFileName = saveFileName(preFileName, extFileName);
			
			// 실제 서버에 파일을 저장시킨다.(/resoruces/pds 폴더에 저장)
			writeFile(file, saveFileName);
			
			// DB에 자료를 올리기 위한 준비 및 자료 저장시키기
			vo.setFname(oFileName);
			vo.setRfname(saveFileName);
			vo.setFsize((int) file.getSize());
			pdsDao.setPdsUpload(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void writeFile(MultipartFile file, String saveFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		//request.getRealPath("/resources/pds/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/pds/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		
		fos.close();
	}

	private String saveFileName(String preFileName, String extFileName) {
		String fileName = "";
		
		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += "_" + preFileName + "." + extFileName;
		
		return fileName;
	}

	@Override
	public void setDownCopyCheck(PdsVo vo) {
		pdsDao.setDownCheck(vo.getIdx());  // 다운로드 횟수 1 증가
		
		// pds폴더에서 pds/imsi폴더로 원본파일 복사
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String copyPath = request.getSession().getServletContext().getRealPath("/resources/pds/");
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {
			fis = new FileInputStream(copyPath+vo.getRfname());
			fos = new FileOutputStream(copyPath+"imsi/"+vo.getFname());
			
			byte[] b = new byte[1024];
			int data = 0;
			
			while((data = fis.read(b, 0, b.length)) != -1) {
				fos.write(b, 0, data);
			}
			fos.flush();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(fos != null) fos.close();
				if(fis != null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void setDownCheck(int idx) {
		pdsDao.setDownCheck(idx);
	}
	
}
