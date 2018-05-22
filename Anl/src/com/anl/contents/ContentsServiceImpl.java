package com.anl.contents;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.anl.dao.ContentsDao;

@Service("ContentsService")
public class ContentsServiceImpl implements ContentsService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Autowired
    private ContentsDao contentsDao;
     
    @Override
    public List<Map<String, Object>> selectContentsList(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return contentsDao.selectContentsList(map);
    }
    
    @Override
    public Map<String, Object> selectContentsOne(Map<String, Object> map) throws Exception {
    	
    	
    	log.debug("in service");
        return contentsDao.selectContentsOne(map);
    }
 
}