package com.anl.contents;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public interface ContentsService {
	
	List<Map<String, Object>> selectContentsList(Map<String, Object> map) throws Exception;
	Map<String, Object> selectContentsOne(Map<String, Object> map) throws Exception;
	
	
}