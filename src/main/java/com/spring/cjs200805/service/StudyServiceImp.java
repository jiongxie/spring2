package com.spring.cjs200805.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs200805.dao.StudyDao;
import com.spring.cjs200805.vo.DbBaesongVo;
import com.spring.cjs200805.vo.DbCartListVo;
import com.spring.cjs200805.vo.DbOptionVo;
import com.spring.cjs200805.vo.DbOrderVo;
import com.spring.cjs200805.vo.DbProductVo;
import com.spring.cjs200805.vo.Goods1Vo;
import com.spring.cjs200805.vo.Goods2Vo;
import com.spring.cjs200805.vo.Goods3Vo;
import com.spring.cjs200805.vo.ThumbVo;

@Service
public class StudyServiceImp implements StudyService {
	@Autowired
	StudyDao studyDao;

	@Override
	public void getCalendar() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 1.오늘 날짜를 저장
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 2.화면에 보여줄 해당년월 셋팅을 위한 부분
		Calendar calView = Calendar.getInstance();//화면에 표시할 날짜
		int yy = request.getParameter("yy") == null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm") == null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		if( mm < 0 ) { // 1월에서 전월 버튼을 클릭시에 실행
			yy--;
			mm=11;
		}
		if( mm > 11) { // 12월에서 다음월 버튼을 클릭시에 실행함
			yy++;
			mm=0;
		}

		calView.set(yy,mm,1);//해당 년, 월의 첫날을 셋팅 
		
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);//해당 년/월의 1일에 해당하는 요일값을 가져온다
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);//해당월의 마지막일을 구한다
		
		// 3.화면에 보여줄 년월기준 전년도 다음년도를 위한 부분
		int preYear = yy; //전년도
		int preMonth = mm - 1; // 전월
		int nextYear = yy; //다음년도
		int nextMonth = mm + 1; //다음월
		
		if(preMonth == -1) { //1월에서 전월 버튼을 클릭시에 실행함
			preYear--;
			preMonth = 11;
		}
		
		if(nextMonth == 12) { //12월에서 다음월 버튼을 클릭시에 실행함
			nextYear++;
			nextMonth = 0;
		}
		Calendar calPre = Calendar.getInstance();//이전달력
		calPre.set(preYear, preMonth,1);//이전달력셋팅
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);//이전달력의 마지막일을 구한다
		
		Calendar calNext = Calendar.getInstance();//다음달력
		calNext.set(nextYear, nextMonth,1);//다음달력셋팅
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);//다음달력의 1일에 해당하는 요일값을 가져온다
		
		// 4.화면에 표시할 해당사용자의 해당월의 일자별 입금총액과 지출총액 처리
//		int[] ipkumArr = new int[lastDay];//해당월의 마지막날값으로 입금 배열생성
//		int[] jichulArr = new int[lastDay];//해당월의 마지막날값으로 지출 배열생성
//		for(int i=0; i<lastDay;i++) {
//			String ymd = yy + "-" + (mm+1) + "-" + (i+1);
//			//System.out.println(ymd);
//			ipkumArr[i] = dao.userMoneyIpkumList(smid,ymd,"입금");
//			jichulArr[i] = dao.userMoneyjichulList(smid,ymd,"지출");
//			//System.out.println(i + "입금 : " + ipkumArr[i] + "/ 지출 : " + jichulArr[i]);
//		}
		
		// 5. 해당사용자에 대한 해당월별 지출에대한 현금,신용카드,체크카드 사용내역
		// 해당 sql쿼리 처리시 dataformat 비교형식에 맞춰주기 위해 아래와 같이 처리 > 현재 1월~9월은 2020-1 이런식으로 출력되므로 2020-01 이렇게 바꿔주어야한다 
		String ym = "";
		int tmpMM = (mm+1);
		if(tmpMM >= 1 && tmpMM <=9) {
			ym = yy + "-" + "0" + (mm+1);
		}
		else {
			ym = yy + "-" + (mm+1);
		}
//		List<Money_Vo> jichulKubunVos = dao.jichulKubunList(smid,ym,"지출");
		
		/*======================= setAttribute ===========================*/
		//오늘기준 달력
		request.setAttribute("toYear", toYear);		
		request.setAttribute("toMonth", toMonth);		
		request.setAttribute("toDay", toDay);		
		
		//화면에 보여줄 해당 달력
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		//화면에 보여줄 해당 달력 기준 전년도,전년월,다음년도,다음월 달력
		request.setAttribute("preYear", preYear);
		request.setAttribute("preMonth", preMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		//해당사용자의 입금액,지출액 등등 금액관련 부분
//		request.setAttribute("ipkumArr", ipkumArr);
//		request.setAttribute("jichulArr", jichulArr);
//		request.setAttribute("jichulKubunVos", jichulKubunVos);
	}

	@Override
	public int fileUpload(MultipartFile mFile, String file) {
		int res = 0;
		try {
			// 파일업로드 처리
			String oFileName = mFile.getOriginalFilename();
			//String preFileName = oFileName.substring(0,oFileName.lastIndexOf("."));  // 순수 파일명 추출
			//String oFileExt = oFileName.substring(oFileName.lastIndexOf(".")+1);     // 확장지 추출
			
			UUID uid = UUID.randomUUID(); // UUID객체를 통한 고유번호를 생성
			
			String saveFileName = uid + "_" + oFileName;
			
			writeFile(mFile, saveFileName);
			
			// 파일이 업로드 성공시에 DB에 정보를 저장한다.
			// studyDao.fileUpload(mFile, file)
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile(MultipartFile mFile, String saveFileName) throws IOException {
		byte[] data = mFile.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/member/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		
		fos.close();
	}

	@Override
	public List<Goods1Vo> getProduct1() {
		return studyDao.getProduct1();
	}

	@Override
	public ArrayList<Goods2Vo> getProduct2(String product1) {
		return studyDao.getProduct2(product1);
	}

	@Override
	public ArrayList<Goods3Vo> getProduct3(String product1, String product2) {
		return studyDao.getProduct3(product1, product2);
	}

	@Override
	public void dbProductInput(DbProductVo vo, MultipartFile file) {
		try {
			String oFileName = file.getOriginalFilename();
			String preFileName = oFileName.substring(0,oFileName.lastIndexOf(".")); // 순수한 파일명
			String extFileName = oFileName.substring(oFileName.lastIndexOf(".")+1); // 확장자명
			
			// 서버에 저장되는 실제파일의 중복을 배제하기위해 파일명 뒤에 '년/월/일/시/분/초'을 추가해서 뒤에 확장자를 붙여서 저장한다.
			String saveFileName = saveFileName(preFileName, extFileName);
			
			// 실제 서버에 파일을 저장시킨다.(/resoruces/study 폴더에 저장)
			writeFile2(file, saveFileName);
			
			// DB에 자료를 올리기 위한 준비 및 자료 저장시키기
			vo.setFname(oFileName);
			vo.setRfname(saveFileName);
			
			studyDao.dbProductInput(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void writeFile2(MultipartFile file, String saveFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		//request.getRealPath("/resources/study/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/study/");
		
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
	public String[] getProductName() {
		return studyDao.getProductName();
	}

	@Override
	public int getProductIdx(String product) {
		return studyDao.getProductIdx(product);
	}

	@Override
	public void dbOptionInput(DbOptionVo vo) {
		studyDao.dbOptionInput(vo);
	}

	@Override
	public List<DbProductVo> getDbShopList(String gubun) {
		return studyDao.getDbShopList(gubun);
	}

	@Override
	public DbProductVo getDbShopProduct(int idx) {
		return studyDao.getDbShopProduct(idx);
	}

	@Override
	public List<DbOptionVo> getDbShopOption(int idx) {
		return studyDao.getDbShopOption(idx);
	}

	@Override
	public DbCartListVo dbCartListProductOptionSearch(String product, String optionName) {
		return studyDao.dbCartListProductOptionSearch(product, optionName);
	}

	@Override
	public void dbShopCartUpdate(DbCartListVo vo) {
		studyDao.dbShopCartUpdate(vo);
	}

	@Override
	public void dbShopCartInput(DbCartListVo vo) {
		studyDao.dbShopCartInput(vo);
	}

	@Override
	public List<DbCartListVo> getDbCartList(String mid) {
		return studyDao.getDbCartList(mid);
	}
	
	@Override
	public DbCartListVo getCartIdx(String idx) {
		return studyDao.getCartIdx(idx);
	}
	
	@Override
	public DbOrderVo getOrderMaxIdx() {
		return studyDao.getOrderMaxIdx();
	}
	
	@Override
	public void dbCartDel(int idx) {
		studyDao.dbCartDel(idx);
	}
	
	@Override
	public void setDbOrder(DbOrderVo vo) {
		studyDao.setDbOrder(vo);
	}

	@Override
	public void delDbCartList(int cartIdx) {
		studyDao.delDbCartList(cartIdx);
	}

	@Override
	public void setDbBaesong(DbBaesongVo bVo) {
		studyDao.setDbBaesong(bVo);
	}
	
	@Override
	public List<DbOrderVo> getDbMyOrder(String mid) {
		return studyDao.getDbMyOrder(mid);
	}
	
	@Override
	public List<DbBaesongVo> getBaesong(String mid) {
		return studyDao.getBaesong(mid);
	}
	
	@Override
	public List<DbBaesongVo> getOrderBaesong(String orderIdx) {
		return studyDao.getOrderBaesong(orderIdx);
	}
	
	@Override
	public List<DbProductVo> getSubTitle() {
		return studyDao.getSubTitle();
	}

	@Override
	public ThumbVo thumbnailCreate(MultipartFile file) {
		ThumbVo vo = new ThumbVo();
		try {
			String oFileName = file.getOriginalFilename();
			String fileExt = oFileName.substring(oFileName.lastIndexOf(".")+1); // 확장자 구하기
			
			UUID uid = UUID.randomUUID();
			
			String saveFileName = uid + "_" + oFileName;
			
			thumbWriteFile(file, saveFileName);  // 원본이미지 저장
			
			// 썸네일 이미지 만들어 저장하기(이미지를 필요한 크기로 잘라서 저장한다.)
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String imsiUploadPath = request.getSession().getServletContext().getRealPath("/resources/study/thumbnail/");
			String uploadPath = imsiUploadPath + saveFileName;
			BufferedImage srcImg = ImageIO.read(new File(uploadPath));
			
			int ow = srcImg.getWidth();  // 서버에 저장된 원본 그림파일의 폭(너비)
			int oh = srcImg.getHeight(); // 서버에 저장된 원본 그림파일의 높이
			
			int tw = 200, th = 150;  // 썸네일의 너비와 높이를 사용자가 원하는 크기로 지정한다.(4:3 비율)
			
			// 원본그림을 썸네일의 폭(높이)의 지정된 크기로 변경처리한다.
			int rw = ow;
			int rh = (ow * th) / tw;
			
			// 계산된 높이가 원본보다 높다면 잘랐을때 공백으로 채워지게된다. 따라서 이때는 높이를 기준으로 재계산처리한다.
			if(rh > oh) {
				rh = oh;
				rw =(oh * tw) / th;
			}
			
			// 계산된 크기만큼 원본 이미지를 자른다.
			BufferedImage cropImg = Scalr.crop(srcImg, (ow-rw)/2, (oh-rh)/2, rw, rh);
			
			// 잘라낸 그림파일의 정보를 다시 읽어온다.
			BufferedImage resizeImg = Scalr.resize(srcImg, tw, th);
			
			// 새롭게 재 계산처리되어 잘라진 썸네일을 저장한다.
			String imsiFileName = imsiUploadPath + "s_" + saveFileName;
			String thumbFileName = "s_" + saveFileName + "." + fileExt;
			
			File tFileName = new File(imsiFileName);
			ImageIO.write(resizeImg, fileExt, tFileName);  // 썸네일 이미지 저장처리
			
			vo.setRes(1);
			vo.setOFileName(saveFileName);
			vo.setTFileName(thumbFileName);
		} catch (IOException e) {
			vo.setRes(0);
			e.printStackTrace();
		}
		// DB 작업~~~처리~~부분~~
		return vo;
	}
	
	private void thumbWriteFile(MultipartFile mFile, String saveFileName) throws IOException {
		byte[] data = mFile.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/study/thumbnail/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		
		fos.close();
	}

	@Override
	public List<DbBaesongVo> getOrderStatus(String mid, String orderStatus) {
		return studyDao.getOrderStatus(mid, orderStatus);
	}

	@Override
	public List<DbBaesongVo> adminOrderStatus(String startJumun, String endJumun, String orderStatus) {
		return studyDao.adminOrderStatus(startJumun, endJumun, orderStatus);
	}

	@Override
	public void setOrderStatusUpdate(String orderStatus, String orderIdx) {
		studyDao.setOrderStatusUpdate(orderStatus, orderIdx);
	}

}
