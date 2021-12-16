package com.spring.cjs200805;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.spring.cjs200805.service.MemberService;
import com.spring.cjs200805.service.StudyService;
import com.spring.cjs200805.vo.DbBaesongVo;
import com.spring.cjs200805.vo.DbCartListVo;
import com.spring.cjs200805.vo.DbOptionVo;
import com.spring.cjs200805.vo.DbOrderVo;
import com.spring.cjs200805.vo.DbProductVo;
import com.spring.cjs200805.vo.Goods1Vo;
import com.spring.cjs200805.vo.Goods2Vo;
import com.spring.cjs200805.vo.Goods3Vo;
import com.spring.cjs200805.vo.MemberVo;
import com.spring.cjs200805.vo.ThumbVo;



@Controller
@RequestMapping("/study")
public class StudyController {
	String msgFlag = "";
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value="/calendar", method=RequestMethod.GET)
	public String calendarGet() {
		studyService.getCalendar();
		return "study/calendar/calendar";
	}
	
	@RequestMapping(value="/woo", method=RequestMethod.GET)
	public String wooGet() {
		return "study/woo/woo";
	}
	
	@RequestMapping(value="/fileUpload", method=RequestMethod.GET)
	public String fileUploadGet() {
		return "study/fileupload/fileUpload";
	}
	
	@RequestMapping(value="/fileUpload", method=RequestMethod.POST)
	public String fileUploadPost(MultipartFile mFile, String file) {
		int res = studyService.fileUpload(mFile, file);
		if(res == 1) {
			msgFlag = "fileUploadOk";
		}
		else {
			msgFlag = "fileUploadNo";
		}
		
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value="/ajaxTest1", method=RequestMethod.GET)
	public String ajaxTest1Get() {
		return "study/ajax/ajaxTest1";
	}
	
	// HashMap형식으로 자료값을 전달
	@ResponseBody
	@RequestMapping(value="/ajaxTest1", method=RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest1Post(String dodo) {
		System.out.println("dodo : " + dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		
		ArrayList<String> list = new ArrayList<String>();
		if(dodo.equals("서울")) {
			list.add("종로구");
			list.add("영등포구");
			list.add("성북구");
			list.add("관악구");
			list.add("강남구");
			list.add("강북구");
			list.add("강동구");
			list.add("강서구");
		}
		else if(dodo.equals("경기")) {
			list.add("수원시");
			list.add("안성시");
			list.add("평택시");
			list.add("하남시");
			list.add("성남시");
			list.add("시흥시");
			list.add("안양시");
			list.add("화성시");
		}
		else if(dodo.equals("충북")) {
			list.add("청주시");
			list.add("충주시");
			list.add("음성군");
			list.add("진천군");
			list.add("제천시");
			list.add("영동군");
			list.add("단양군");
			list.add("옥천군");
		}
		else if(dodo.equals("충남")) {
			list.add("천안시");
			list.add("보령군");
			list.add("서천시");
			list.add("아산시");
			list.add("부여군");
			list.add("공주시");
			list.add("당진시");
			list.add("홍천군");
		}
		
		map.put("city", list);
		
		return map;
	}
	
	@RequestMapping(value="/ajaxTest2", method=RequestMethod.GET)
	public String ajaxTest2Get() {
		return "study/ajax/ajaxTest2";
	}
	
  //ArrayList형식으로 자료값을 전달
	@ResponseBody
	@RequestMapping(value="/ajaxTest2", method=RequestMethod.POST)
	public ArrayList<String> ajaxTest2Post(String dodo) {
		//System.out.println("dodo : " + dodo);
		
		ArrayList<String> list = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			list.add("종로구");
			list.add("영등포구");
			list.add("성북구");
			list.add("관악구");
			list.add("강남구");
			list.add("강북구");
			list.add("강동구");
			list.add("강서구");
		}
		else if(dodo.equals("경기")) {
			list.add("수원시");
			list.add("안성시");
			list.add("평택시");
			list.add("하남시");
			list.add("성남시");
			list.add("시흥시");
			list.add("안양시");
			list.add("화성시");
		}
		else if(dodo.equals("충북")) {
			list.add("청주시");
			list.add("충주시");
			list.add("음성군");
			list.add("진천군");
			list.add("제천시");
			list.add("영동군");
			list.add("단양군");
			list.add("옥천군");
		}
		else if(dodo.equals("충남")) {
			list.add("천안시");
			list.add("보령군");
			list.add("서천시");
			list.add("아산시");
			list.add("부여군");
			list.add("공주시");
			list.add("당진시");
			list.add("홍천군");
		}
		
		return list;
	}
	
	@RequestMapping(value="/ajaxTest3", method=RequestMethod.GET)
	public String ajaxTest3Get() {
		return "study/ajax/ajaxTest3";
	}
	
  //ArrayList형식으로 자료값을 전달
	@ResponseBody
	@RequestMapping(value="/ajaxTest3", method=RequestMethod.POST)
	public String[] ajaxTest3Post(String dodo) {
		System.out.println("dodo : " + dodo);
		
		String[] list = new String[100];
		
		if(dodo.equals("서울")) {
			list[0] = "종로구";
			list[1] = "영등포구";
			list[2] = "성북구";
			list[3] = "관악구";
			list[4] = "강남구";
			list[5] = "강북구";
			list[6] = "강동구";
			list[7] = "강서구";
		}
		else if(dodo.equals("경기")) {
			list[0] = "수원시";
			list[1] = "안성시";
			list[2] = "평택시";
			list[3] = "하남시";
			list[4] = "성남시";
			list[5] = "시흥시";
			list[6] = "안양시";
			list[7] = "화성시";
		}
		else if(dodo.equals("충북")) {
			list[0] = "청주시";
			list[1] = "충주시";
			list[2] = "음성군";
			list[3] = "진천군";
			list[4] = "제천시";
			list[5] = "영동군";
			list[6] = "단양군";
			list[7] = "옥천군";
		}
		else if(dodo.equals("충남")) {
			list[0] = "천안시";
			list[1] = "보령군";
			list[2] = "서천시";
			list[3] = "아산시";
			list[4] = "부여군";
			list[5] = "공주시";
			list[6] = "당진시";
			list[7] = "홍천군";
		}
		
		return list;
	}
	
	@RequestMapping(value="/goods", method=RequestMethod.GET)
	public String goodsGet(Model model) {
		List<Goods1Vo> vos = studyService.getProduct1();
		model.addAttribute("vos", vos);
		return "study/ajax/goods";
	}
	
	@ResponseBody
	@RequestMapping(value="/goods1", method=RequestMethod.POST)
	public ArrayList<Goods2Vo> goods1Post(String product1) {
		ArrayList<Goods2Vo> vos = studyService.getProduct2(product1);
		return vos;
	}

	@ResponseBody
	@RequestMapping(value="/goods2", method=RequestMethod.POST)
	public ArrayList<Goods3Vo> goods2Post(Goods3Vo vo) {
		ArrayList<Goods3Vo> vos = studyService.getProduct3(vo.getProduct1(), vo.getProduct2());
		return vos;
	}
	
	@RequestMapping(value="/session/shop", method=RequestMethod.GET)
	public String sessionShopGet() {
		return "study/sessionShop/product";
	}
	
	@ResponseBody
	@RequestMapping(value="/session/shop", method=RequestMethod.POST)
	public String sessionShopPost(HttpSession session, String product) {
		@SuppressWarnings("unchecked")
		List<String> productList = (ArrayList<String>) session.getAttribute("sProductList"); // 장바구니 => sProductList객체
		
		if(session.getAttribute("sProductList") == null) {
			productList = new ArrayList<String>();
		}
		productList.add(product);
		session.setAttribute("sProductList", productList);
		
		return "study/session/shop";
	}
	
	@RequestMapping(value="/session/cart", method=RequestMethod.GET)
	public String sessionCartGet(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<String> productList = (ArrayList<String>) session.getAttribute("sProductList"); // 장바구니 => sProductList객체
		if(productList == null || productList.size() == 0) {
			msgFlag = "productNo";
			return "redirect:/msg/" + msgFlag;
		}
		else {
			Collections.sort(productList);
			model.addAttribute("productList", productList);
			return "study/sessionShop/cart";
		}
	}
	
	@RequestMapping(value="/session/productReset", method=RequestMethod.GET)
	public String sessionProductResetGet(HttpSession session, String product) {
		//List<String> productImsi = (ArrayList) session.getAttribute("sProductList");
		List<String> productImsi = new ArrayList<String>();
		productImsi.add(product);
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<String> productList = (ArrayList) session.getAttribute("sProductList");
		productList.removeAll(productImsi);
		
		return "redirect:/study/session/cart";
	}
	
	@RequestMapping(value="/session/productAdd", method=RequestMethod.GET)
	public String sessionProductAddGet(HttpSession session, String product) {
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<String> productList = (ArrayList) session.getAttribute("sProductList");
		productList.add(product);
		session.setAttribute("sProductList", productList);
		
		return "redirect:/study/session/cart";
	}

	@RequestMapping(value="/session/productSub", method=RequestMethod.GET)
	public String sessionProductSubGet(HttpSession session, String product) {
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<String> productList = (ArrayList) session.getAttribute("sProductList");
		productList.remove(product);
//		session.setAttribute("sProductList", productList);
		
		return "redirect:/study/session/cart";
	}
	
	@RequestMapping(value="/session/productRemoveAll", method=RequestMethod.GET)
	public String sessionProductRemoveAllGet(HttpSession session) {
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<String> productList = (ArrayList) session.getAttribute("sProductList");
		productList.removeAll(productList);
		
		return "redirect:/study/session/cart";
	}
	
	// -- 아래로 DB장바구니 처리 ----
	// DbShop메뉴
	@RequestMapping(value="/dbshop/dbShop", method=RequestMethod.GET)
	public String dbShopGet() {
		return "study/dbshop/dbShop";
	}

	@RequestMapping(value="/dbshop/dbShopAd", method=RequestMethod.GET)
	public String dbShopAdGet() {
		return "study/dbshop/dbShopAd";
	}
	
	
	// DbShop 상품등록창 호출
	@RequestMapping(value="/dbshop/dbProduct", method=RequestMethod.GET)
	public String dbProductGet() {
		return "study/dbshop/dbProduct";
	}
	
  // DbShop 상품등록처리
	@RequestMapping(value="/dbshop/dbProduct", method=RequestMethod.POST)
	public String dbProductPost(DbProductVo vo, MultipartFile file) {
		studyService.dbProductInput(vo, file);
		
		msgFlag = "dbProductInputOk";
		return "redirect:/msg/"+msgFlag;
	}
	
  //DbShop 옵션 등록창 호출
	@RequestMapping(value="/dbshop/dbOption", method=RequestMethod.GET)
	public String dbOptionGet(Model model) {
		String[] productName = studyService.getProductName();
		model.addAttribute("productName", productName);
		return "study/dbshop/dbOption";
	}
	
  //DbShop 옵션 등록처리
	@RequestMapping(value="/dbshop/dbOption", method=RequestMethod.POST)
	public String dbOptionPost(String product, DbOptionVo vo, String[] optionName, int[] optionPrice) {
		int productIdx = studyService.getProductIdx(product);
		for(int i=0; i<optionName.length; i++) {
			vo.setProductIdx(productIdx);
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			studyService.dbOptionInput(vo);
		}
		
		msgFlag = "dbOptionInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 판매 상품 진열하기
	@RequestMapping(value="/dbshop/dbShopList", method=RequestMethod.GET)
	public String dbShopListGet(@RequestParam(name="gubun", defaultValue="전체", required=false) String gubun, Model model) {
		//String[] subTitle = studyService.getSubTitle();
		List<DbProductVo> subTitle = studyService.getSubTitle();
		model.addAttribute("subTitle", subTitle);
		model.addAttribute("gubun", gubun);
		//List<DbProductVo> vos = studyService.getDbShopList();
		List<DbProductVo> vos = studyService.getDbShopList(gubun);
		model.addAttribute("vos", vos);
		
		return "study/dbshop/dbShopList";
	}
	
	// 진열된 상품 클릭시 상품내역 상세보기
	@RequestMapping(value="/dbshop/dbShopContent", method=RequestMethod.GET)
	public String dbShopContentGet(int idx, Model model) {
		DbProductVo productVo = studyService.getDbShopProduct(idx); // 상품 상세 정보 불러오기
		List<DbOptionVo> optionVos = studyService.getDbShopOption(idx); // 옵션 정보 모두 가져오기(두개이상이 올수 있기에 배열(리스트)처리한다.)
		
		model.addAttribute("productVo", productVo);
		model.addAttribute("optionVos", optionVos);
		
		return "study/dbshop/dbShopContent";
	}
	
	// 진열상품 장바구니로 보내기
	@RequestMapping(value="/dbshop/dbShopContent", method=RequestMethod.POST)
	public String dbShopContentPost(DbCartListVo vo) {
		// 구매한 상품과 상품의 옵션 정보를 읽어와서 기존에 구매했었던 제품으로 장바구니에 담겨있었다면 DB에 update시키고, 새로운 품목이면 insert시켜준다. 
		DbCartListVo resVo = studyService.dbCartListProductOptionSearch(vo.getProduct(), vo.getOptionName());
		if(resVo != null) {
			String[] voOptionNums = vo.getOptionNum().split(",");     // 앞에서 넘어온 vo
			String[] resOptionNums = resVo.getOptionNum().split(","); // DB에 저장된 장바구니 resVo
			int[] nums = new int[99];
			String strNums = "";
			for(int i=0; i<voOptionNums.length; i++) {
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
				strNums += nums[i];
				if(i < nums.length - 1) strNums += ",";
			}
			vo.setOptionNum(strNums);
			studyService.dbShopCartUpdate(vo);
		}
		else {
			studyService.dbShopCartInput(vo);
		}
		return "redirect:/study/dbshop/dbCartList";
	}
	
	// 진열상품을 직접 구입하기위해, 바로 주문테이블로 보내기(진열대 상품을 주문VO에 담는다.)
	@RequestMapping(value="/dbshop/dbShopOrder", method=RequestMethod.POST)
	public String dbShopOrderPost(DbOrderVo orderVo, HttpSession session, Model model) {
		// 장바구니를 통해서 주문테이블로 들어가는 상품들은 여러개 일수 있기에 vos로 처리해야 한다.(단, 여기서는 1개밖에는 없지만 나중에 장바구니에서 넘어오는것과 함께 처리하기위해 List에 담았다)
		List<DbOrderVo> orderVos = new ArrayList<DbOrderVo>();
		
		orderVo.setProductIdx(orderVo.getProductIdx());
		orderVo.setProduct(orderVo.getProduct());
		orderVo.setMainPrice(orderVo.getMainPrice());
		orderVo.setThumbImg(orderVo.getThumbImg());
		orderVo.setOptionName(orderVo.getOptionName());
		orderVo.setOptionPrice(orderVo.getOptionPrice());
		orderVo.setOptionNum(orderVo.getOptionNum());
		orderVo.setTotalPrice(orderVo.getTotalPrice());
		orderVo.setCartIdx(0);  // 카트에 담지않고 처리하기에 카드(장바구니)코유번호를 0으로 넘겼다.
		
		orderVos.add(orderVo);  // 여기서는 1건의 자료밖에는 없기에 1개만 add 시켜주었다. 
		
		session.setAttribute("orderVos", orderVos); // 저장한 orderVos를 session에 담아서 결재창으로 넘겨준다.(나중에 장바구니에서도 세션으로 넘길것이기에 여기서도 세션으로 처리했다.)
		
		// 현재 로그인된 고객의 정보를 member2테이블에서 가져온다.
		MemberVo memberVo = memberService.getIdCheck(session.getAttribute("smid").toString());
		model.addAttribute("memberVo", memberVo);
		
		// 아래는 주문작업이 들어오면 그때 만들어주면된다.(여기서는 주문하기 버튼 클릭하였을때 주문번호를 만들고 있다. 나중에 장바구니 담은후 '주문'버튼 눌렀을때도 똑같이 '주문번호'를 만들어줘야한다.)
    // 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		DbOrderVo maxIdx = studyService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		//주문번호(orderIdx) 만들기(->날짜_idx)
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		model.addAttribute("orderIdx", orderIdx);
		
		return "study/dbshop/dbOrder";  //주문서 작성 jsp호출

	}
	
	// 장바구니에 담겨있는 모든 품목들 보여주기
	@RequestMapping(value="/dbshop/dbCartList", method=RequestMethod.GET)
	public String dbCartListGet(HttpSession session, DbCartListVo vo, Model model) {
		String mid = (String) session.getAttribute("smid");
		List<DbCartListVo> vos = studyService.getDbCartList(mid);
		
		model.addAttribute("listVos", vos);
		return "study/dbshop/dbCartList";
	}
	
	@RequestMapping(value="/dbshop/dbCartList", method=RequestMethod.POST)
	//public String dbCartListPost(String mid, int[] idx, String[] checkItem, Model model) {
	public String dbCartListPost(HttpServletRequest request, Model model, HttpSession session) {
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		DbCartListVo cartVo = new DbCartListVo();
		List<DbOrderVo> orderVos = new ArrayList<DbOrderVo>();
		
		for(String idx : idxChecked) {
			//System.out.println("idx: " + idx);
			cartVo = studyService.getCartIdx(idx);
			DbOrderVo orderVo = new DbOrderVo();
			orderVo.setProductIdx(cartVo.getProductIdx());
			orderVo.setProduct(cartVo.getProduct());
			orderVo.setMainPrice(cartVo.getMainPrice());
			orderVo.setThumbImg(cartVo.getThumbImg());
			orderVo.setOptionName(cartVo.getOptionName());
			orderVo.setOptionPrice(cartVo.getOptionPrice());
			orderVo.setOptionNum(cartVo.getOptionNum());
			orderVo.setTotalPrice(cartVo.getTotalPrice());
			orderVo.setCartIdx(cartVo.getIdx());
			orderVos.add(orderVo);
		}
		
		//model.addAttribute("orderVos", orderVos);
		session.setAttribute("orderVos", orderVos); // 주문에서 보여준후 다시 그대로를 담아서 결제창으로 보내기에 session처리했다.
		
		// 현재 로그인된 고객의 정보를 member2테이블에서 가져온다.
		MemberVo memberVo = memberService.getIdCheck(session.getAttribute("smid").toString());
		model.addAttribute("memberVo", memberVo);
		
		// 아래는 주문작업이 들어오면 그때 만들어주면된다.
    // 주문고유번호(idx) 만들기(기존 DB의 고유번호(idx) 최대값 보다 +1 시켜서 만든다) 
		DbOrderVo maxIdx = studyService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		//주문번호(orderIdx) 만들기(->날짜_idx)
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		model.addAttribute("orderIdx", orderIdx);
		
		return "study/dbshop/dbOrder";  //주문서 작성 jsp호출
	}
	
	@RequestMapping(value="/dbshop/dbCartDel", method=RequestMethod.GET)
	@ResponseBody
	public String dbCartDelGet(int idx) {
		studyService.dbCartDel(idx);
		return "";
	}
	
	@RequestMapping(value="/dbshop/orderInput", method=RequestMethod.POST)
	public String orderInputPost(HttpSession session, DbOrderVo orderVo, DbBaesongVo bVo) {
		@SuppressWarnings("unchecked")
		List<DbOrderVo> orderVos = (List<DbOrderVo>) session.getAttribute("orderVos");
		for(DbOrderVo vo : orderVos) {
			vo.setIdx(Integer.parseInt(bVo.getOrderIdx().substring(8))); // 주문테이블에 고유번호를 셋팅한다.	
			vo.setOrderIdx(bVo.getOrderIdx());           // 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(bVo.getMid());							
			
			studyService.setDbOrder(vo);                 // 주문내용을 주문테이블(dbOrder)에 저장.
			studyService.delDbCartList(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(dbCartList)에서 주문한 내역을 삭체처리한다.
		}
		
		studyService.setDbBaesong(bVo);  // 배송내용을 배송테이블(dbBaesong)에 저장
		
		msgFlag = "orderInputOk";
		
		return "redirect:/msg/" + msgFlag;
	}
	
	@RequestMapping(value="/dbshop/dbOrderConfirm", method=RequestMethod.GET)
	public String dbOrderConfirmGet(HttpSession session, Model model) {
		@SuppressWarnings("unchecked")
		List<DbOrderVo> vos = (List<DbOrderVo>) session.getAttribute("orderVos");
		List<DbBaesongVo> bVos = studyService.getBaesong(vos.get(0).getMid());
		
		model.addAttribute("vos", vos);
		model.addAttribute("bVo", bVos.get(0));
		
		//session.removeAttribute("orderVos");
		
		return "study/dbshop/dbOrderConfirm";
	}
	
	@RequestMapping(value="/dbshop/dbMyOrder", method=RequestMethod.GET)
	public String dbMyOrderGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("smid");
		List<DbOrderVo> myOrderVos = studyService.getDbMyOrder(mid);
		
		model.addAttribute("myOrderVos", myOrderVos);
		
		return "study/dbshop/dbMyOrder";
	}
	
	@RequestMapping(value="/dbshop/dbOrderBaesong", method=RequestMethod.GET)
	public String dbOrderBaesongGet(String orderIdx, Model model) {
		List<DbBaesongVo> vos = studyService.getOrderBaesong(orderIdx);  // 같은 주문번호가 2개 이상 있을수 있기에 List객체로 받아온다.
		
		model.addAttribute("vo", vos.get(0));  // 같은 배송지면 0번째것 하나만 vo에 담아서 넘겨주면 된다.
		
		return "study/dbshop/dbOrderBaesong";
	}
	
	/* @ResponseBody */
	@RequestMapping(value="/dbshop/orderStatus", method=RequestMethod.GET)
	public String orderStatusGet(String orderStatus, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("smid");
		List<DbBaesongVo> myOrderVos = studyService.getOrderStatus(mid, orderStatus);
		model.addAttribute("orderStatus", orderStatus);
		model.addAttribute("myOrderVos", myOrderVos);
		return "study/dbshop/dbMyOrder";
	}
	
	// 관리자가 주문처리를 위해 주문정보를 출력하는부분
	@RequestMapping(value="/dbshop/dbJumunProcess", method=RequestMethod.GET)
	public String dbJumunProcessGet(HttpSession session, Model model) {
		List<DbBaesongVo> orderVos = studyService.adminOrderStatus("","","전체");
		
		model.addAttribute("myOrderVos", orderVos);
		
		return "study/dbshop/dbJumunProcess";
	}
	
	@ResponseBody
	@RequestMapping(value="/dbshop/goodsStatus", method=RequestMethod.GET)
	public String goodsStatusGet(String goodsStatus, String orderIdx) {
		studyService.setOrderStatusUpdate(goodsStatus, orderIdx);
		return "";
	}
	
	@RequestMapping(value="/dbshop/adminOrderStatus", method=RequestMethod.GET)
	public String adminOrderStatusGet(String startJumun, String endJumun, String orderStatus, Model model) {
		System.out.println("startJumun:"+startJumun);
		List<DbBaesongVo> orderVos = studyService.adminOrderStatus(startJumun, endJumun, orderStatus);
		model.addAttribute("orderStatus", orderStatus);
		model.addAttribute("myOrderVos", orderVos);
		return "study/dbshop/dbJumunProcess";
	}
	
	// 썸네일을 위한 그림파일 업로드폼
	@RequestMapping(value="/thumbnail/thumbnail", method=RequestMethod.GET)
	public String thumbnailGet() {
		return "study/thumbnail/thumbnail";
	}
	
	//썸네일 처리
	@RequestMapping(value="/thumbnail/thumbnail", method=RequestMethod.POST)
	public String thumbnailPost(MultipartFile file) throws Exception {
		ThumbVo vo = studyService.thumbnailCreate(file);
		
		if(vo.getRes() == 1) {
			msgFlag = "thumbnailCreateOk$oFileName="+URLEncoder.encode(vo.getOFileName(),"UTF-8")+"&tFileName="+URLEncoder.encode(vo.getTFileName(),"UTF-8");
		}
		else {
			msgFlag = "thumbnailCreateNo";
		}
		
		return "redirect:/msg/" + msgFlag;
	}
	
	// 썸네일 처리된 그림과 원본 그림 보여주기
	@RequestMapping(value="/thumbnail/thumbShow", method=RequestMethod.GET)
	public String thumbShowGet(String oFileName, String tFileName, Model model) {
		model.addAttribute("oFileName", oFileName);
		model.addAttribute("tFileName", tFileName);
		return "study/thumbnail/thumbShow";
	}
}
