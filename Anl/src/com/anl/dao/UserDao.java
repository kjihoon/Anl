package com.anl.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("UserDao")
public class UserDao extends AbstractDao{

	protected Log log = LogFactory.getLog(AbstractDao.class);
	
	@SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (List<Map<String, Object>>) selectList("user.selectUserList", map);
    }
	
	
	@SuppressWarnings("unchecked")
    public Map<String, Object> selectUserOne(Map<String, Object> map) throws Exception{
		log.debug("in dao");
        return (Map<String, Object>) selectOne("user.selectUserOne", map);
    	
}
	
}
