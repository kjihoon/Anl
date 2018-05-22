package com.anl.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("ContentsDao")
public class ContentsDao extends AbstractDao{

	protected Log log = LogFactory.getLog(AbstractDao.class);
	
	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectContentsList(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (List<Map<String, Object>>) selectList("contents.selectContentsList", map);
    }
	
	
	@SuppressWarnings("unchecked")
    public Map<String, Object> selectContentsOne(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (Map<String, Object>) selectOne("contents.selectContentsOne", map);
    	
}
	
}
