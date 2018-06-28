package com.anl.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
        locations ={"file:C:\\Users\\wlwl0\\Documents\\GitHub\\Anl\\Anl\\web\\WEB-INF\\config\\context-*.xml"})


public class testDataSource {

	@Inject
    private DataSource ds;
    
    
    @Test
    public void testDS() throws Exception{
    	Statement stmt =null;
    	ResultSet rs =null;
        try(Connection con = ds.getConnection()){
        	stmt = con.createStatement();
        	System.out.println("sdf");
        	rs = stmt.executeQuery("SELECT * FROM test");
        	 while ( rs.next() ) {
                 String lastName = rs.getString("id");
                 System.out.println(lastName);
             }
        	
        	System.out.println("dataSource설정 성공");
            
            System.out.println(con);
        }catch(Exception e){
            System.out.println("실패");
            e.printStackTrace();
        }
        stmt.close();
        rs.close();
    }


}
