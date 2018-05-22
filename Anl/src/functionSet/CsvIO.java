package functionSet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CsvIO {
	//String wdpath = System.getProperty("user.dir");
	//String path =wdpath+"\\WebContent\\datafile\\";
	String path ="C:\\Users\\wlwl0\\Documents\\GitHub\\Anl\\anl\\WebContent\\datafile\\";
	
	
	public String write(MultipartFile uploadFile) {

		FileOutputStream fos=null;
		String filename="";
		try {
			filename = uploadFile.getOriginalFilename();
			byte filedata [] = uploadFile.getBytes();			
			fos = new FileOutputStream(path+filename);
			fos.write(filedata);
		}catch(Exception e){
			e.getStackTrace();
		}finally {
			if (fos!=null) {
				try {
					fos.close();
				}catch(Exception e) {
					e.getStackTrace();
				}
			}
		}
		return filename;
	}
	public List<List<String>> read(String filename) {
		List<List<String>> data = new ArrayList<List<String>>();
		BufferedReader br =null;
		try {
			br = Files.newBufferedReader(Paths.get(path+filename));

			Charset.forName("UTF-8");
			String line ="";
			while((line = br.readLine())!=null) {
				List<String> tmp = new ArrayList<String>();
				String arr[] = line.split(",");
				tmp = Arrays.asList(arr);
				data.add(tmp);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (br!=null) {
					br.close();
				}				
			}catch(Exception e){
				e.printStackTrace();
			}			
		}
		return data;
	}
	
}
