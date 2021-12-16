package com.spring.cjs200805.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs200805.vo.DbBaesongVo;
import com.spring.cjs200805.vo.DbCartListVo;
import com.spring.cjs200805.vo.DbOptionVo;
import com.spring.cjs200805.vo.DbOrderVo;
import com.spring.cjs200805.vo.DbProductVo;
import com.spring.cjs200805.vo.Goods1Vo;
import com.spring.cjs200805.vo.Goods2Vo;
import com.spring.cjs200805.vo.Goods3Vo;
import com.spring.cjs200805.vo.ThumbVo;

public interface StudyService {

	public void getCalendar();

	public int fileUpload(MultipartFile mFile, String file);

	public List<Goods1Vo> getProduct1();

	public ArrayList<Goods2Vo> getProduct2(String product1);

	public ArrayList<Goods3Vo> getProduct3(String product1, String product2);

	public void dbProductInput(DbProductVo vo, MultipartFile file);

	public String[] getProductName();

	public int getProductIdx(String product);

	public void dbOptionInput(DbOptionVo vo);

	public List<DbProductVo> getDbShopList(String gubun);

	public DbProductVo getDbShopProduct(int idx);

	public List<DbOptionVo> getDbShopOption(int idx);

	public DbCartListVo dbCartListProductOptionSearch(String product, String optionName);

	public void dbShopCartUpdate(DbCartListVo vo);

	public void dbShopCartInput(DbCartListVo vo);

	public List<DbCartListVo> getDbCartList(String mid);
	
	public DbCartListVo getCartIdx(String idx);
	
	public DbOrderVo getOrderMaxIdx();
	
	public void dbCartDel(int idx);

	public void setDbOrder(DbOrderVo vo);

	public void delDbCartList(int cartIdx);

	public void setDbBaesong(DbBaesongVo bVo);
	
	public List<DbBaesongVo> getBaesong(String mid);
	
	public List<DbBaesongVo> getOrderBaesong(String orderIdx);
	
	public List<DbOrderVo> getDbMyOrder(String mid);

	public ThumbVo thumbnailCreate(MultipartFile file);

	public List<DbProductVo> getSubTitle();

	public List<DbBaesongVo> getOrderStatus(String mid, String orderStatus);

	public List<DbBaesongVo> adminOrderStatus(String startJumun, String endJumun, String orderStatus);

	public void setOrderStatusUpdate(String orderStatus, String orderIdx);	
	
}
