package com.spring.cjs200805.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.PdsmVo;

public interface PdsmDao {

	public int totRecCnt(@Param("partValue") String partValue);

	public List<PdsmVo> pmList(@Param("startNo") int startNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void pmInput(@Param("vo") PdsmVo vo);

	public void setDownCheck(@Param("idx") int idx);

	public int setPmDeleteGet(@Param("idx") int idx);

}
