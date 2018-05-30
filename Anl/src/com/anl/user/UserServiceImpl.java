package com.anl.user;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anl.dao.UserDao;

@Service("UserService")
public class UserServiceImpl implements UserService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private UserDao userDao;
     
    @Override
    public List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return userDao.selectUserList(map);
    }
    
    @Override
    public Map<String, Object> selectUserOne(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return userDao.selectUserOne(map);
    }
 
}