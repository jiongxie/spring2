package com.spring.cjs200805.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs200805.vo.PdsVo;

public interface PdsDao {

	public int totRecCnt(@Param("partValue") String partValue);

	public List<PdsVo> getPList(@Param("startNo") int startNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public void setPdsUpload(@Param("vo") PdsVo vo);

	public void setDownCheck(@Param("idx") int idx);

}
