package com.anl.user;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public interface UserService {
	
	List<Map<String, Object>> selectUserList(Map<String, Object> map) throws Exception;
	Map<String, Object> selectUserOne(Map<String, Object> map) throws Exception;
	
	
}