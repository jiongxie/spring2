package com.spring.cjs200805.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs200805.dao.BoardDao;
import com.spring.cjs200805.dao.GuestDao;
import com.spring.cjs200805.dao.PdsDao;
import com.spring.cjs200805.dao.PdsmDao;
import com.spring.cjs200805.dao.StudyDao;

@Service
public class PageProcess {
	@Autowired
	BoardDao boardDao;
	
	@Autowired
	GuestDao guestDao;
	
	@Autowired
	PdsDao pdsDao;
	
	@Autowired
	PdsmDao pdsmDao;
	
	@Autowired
	StudyDao studyDao;
	
	public PageVo pagination(int pag, int pageSize, String partFlag, String partValue) {
		int blockSize = 3;
		int totRecCnt = 0;
		
		PageVo pageVo = new PageVo();
		
		if(partFlag.equals("board")) {
		  totRecCnt = boardDao.totBoardRecCnt();
		}
		else if(partFlag.equals("guest")) {
			totRecCnt = guestDao.totRecCnt();
	  }
		else if(partFlag.equals("pds")) {
			totRecCnt = pdsDao.totRecCnt(partValue);
	  }
		else if(partFlag.equals("pdsm")) {
			totRecCnt = pdsmDao.totRecCnt(partValue);
	  }
		
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (int)(totRecCnt/pageSize) + 1;  //총 페이지수 구하기
		int startNo = (pag - 1) * pageSize;  // 한페이지에 보여줄 시작 인덱스번호를 구한다.
		int curScrNo = totRecCnt - startNo;  // 해당페이지의 시작번호 구하기.
	
		pageVo.setPag(pag);
		pageVo.setPageSize(pageSize);
		pageVo.setBlockSize(blockSize);
		pageVo.setTotRecCnt(totRecCnt);
		pageVo.setTotPage(totPage);
		pageVo.setStartNo(startNo);
		pageVo.setCurScrNo(curScrNo);
		
		// curScrNo = (totPage - 5) + 1 ;
	  // if(curScrNo <= 0) curScrNo = 1;
	    
		
		return pageVo;
	}
}
