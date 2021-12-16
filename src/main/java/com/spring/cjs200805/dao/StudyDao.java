package com.spring.cjs200805.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.DbBaesongVo;
import com.spring.cjs200805.vo.DbCartListVo;
import com.spring.cjs200805.vo.DbOptionVo;
import com.spring.cjs200805.vo.DbOrderVo;
import com.spring.cjs200805.vo.DbProductVo;
import com.spring.cjs200805.vo.Goods1Vo;
import com.spring.cjs200805.vo.Goods2Vo;
import com.spring.cjs200805.vo.Goods3Vo;


public interface StudyDao {


	public List<Goods1Vo> getProduct1();

	public ArrayList<Goods2Vo> getProduct2(@Param("product1") String product1);

	public ArrayList<Goods3Vo> getProduct3(@Param("product1") String product1, @Param("product2") String product2);

	public void dbProductInput(@Param("vo") DbProductVo vo);

	public String[] getProductName();

	public int getProductIdx(@Param("product") String product);

	public void dbOptionInput(@Param("vo") DbOptionVo vo);

	public List<DbProductVo> getDbShopList(@Param("gubun") String gubun);

	public DbProductVo getDbShopProduct(@Param("idx") int idx);

	public List<DbOptionVo> getDbShopOption(@Param("idx") int idx);

	public DbCartListVo dbCartListProductOptionSearch(@Param("product") String product, @Param("optionName") String optionName);

	public void dbShopCartUpdate(@Param("vo") DbCartListVo vo);

	public void dbShopCartInput(@Param("vo") DbCartListVo vo);

	public List<DbCartListVo> getDbCartList(@Param("mid") String mid);

	public DbCartListVo getCartIdx(@Param("idx") String idx);

	public DbOrderVo getOrderMaxIdx();

	public void dbCartDel(@Param("idx") int idx);

	public void setDbOrder(@Param("vo") DbOrderVo vo);

	public void delDbCartList(@Param("cartIdx") int cartIdx);

	public void setDbBaesong(@Param("bVo") DbBaesongVo bVo);

	public List<DbBaesongVo> getBaesong(@Param("mid") String mid);
	
	public List<DbBaesongVo> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public List<DbOrderVo> getDbMyOrder(@Param("mid") String mid);

	public List<DbProductVo> getSubTitle();

	public List<DbBaesongVo> getOrderStatus(@Param("mid") String mid, @Param("orderStatus") String orderStatus);

	public List<DbBaesongVo> adminOrderStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public void setOrderStatusUpdate(@Param("orderStatus") String orderStatus, @Param("orderIdx") String orderIdx);

}
