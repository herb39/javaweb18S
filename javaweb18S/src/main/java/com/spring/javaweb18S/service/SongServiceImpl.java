package com.spring.javaweb18S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeDriverService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb18S.common.JavawebProvide;
import com.spring.javaweb18S.dao.SongDAO;
import com.spring.javaweb18S.vo.ChartVO;
import com.spring.javaweb18S.vo.ChartVO2;
import com.spring.javaweb18S.vo.PlayListVO;
import com.spring.javaweb18S.vo.SongVO;

@Service
public class SongServiceImpl implements SongService {
	
	@Autowired
	SongDAO songDAO;
	
	@Override
	public List<ChartVO> getChart() {
		return songDAO.getChart();
	}
	
	@Scheduled(cron = "0 0 * * * *")
	public void setChartUpdate() {
		String url = "https://www.melon.com/chart/index.htm";
		Document doc = null;
		Elements element;
		int ranking = 0;
		String image, title, artist, album;
		Elements temp;
		String str = "div.ellipsis.rank";
		List<ChartVO2> vos = new ArrayList<>();
		
		try {
			 doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 1 ~ 50위
		element = doc.select("tr.lst50");
		for (int i = 0; i < 50; i++) {
			// 차트 순위
			temp = element.select("span.rank");
			ranking = Integer.parseInt(temp.get(i).text());
			// 앨범 이미지
			image = element.select("td div a img").get(i).attr("src");
			// 곡 제목
			temp = element.select(str + "01");
			title = temp.get(i).text();
			// 아티스트
			temp = element.select(str + "02").select("span");
			artist = temp.get(i).text();
			// 앨범 제목
			temp = element.select(str + "03");
			album = temp.get(i).text();
			
			vos.add(new ChartVO2(image, title, artist, album, ranking));
		}

		// 51위 ~ 100위
		element = doc.select("tr.lst100");
		for (int i = 0; i < 50; i++) {
			temp = element.select("span.rank");
			ranking = Integer.parseInt(temp.get(i).text());
			image = element.select("td div a img").get(i).attr("src");
			temp = element.select(str + "01");
			title = temp.get(i).text();
			temp = element.select(str + "02").select("span");
			artist = temp.get(i).text();
			temp = element.select(str + "03");
			album = temp.get(i).text();
			vos.add(new ChartVO2(image, title, artist, album, ranking));
		}
		System.out.println("차트 크롤링 작업 끝");
		saveChart(vos);
		
		songDAO.setMatchingSong();
	}
	
	public void saveChart(List<ChartVO2> vos) {
	    for (ChartVO2 vo : vos) {
	        songDAO.setChartUpdate(vo);
	    }
	}
	
//	@Scheduled(cron = "0 5 0 * * *")
	public void songInfo() {
		WebElement webElement;
		String image = null;
		String title = null;
		String artist = null;
		String album = null;
		String releaseDate = null;
		String genre = null;
		String lyrics = null;
		
		
		final File driverFile = new File("src/main/resources/chromedriver");
		final String driverFilePath = driverFile.getAbsolutePath();
		if(!driverFile.exists() && driverFile.isFile()) {
			throw new RuntimeException("not found file. or this is not file" + driverFilePath);
		}
		
		final ChromeDriverService service;
		service = new ChromeDriverService.Builder().usingDriverExecutable(driverFile).usingAnyFreePort().build();
//		ChromeOptions options = new ChromeOptions();
		// 브라우저가 눈에 보이지 않고 내부적으로 돈다.
		// 설정하지 않을 시 실제 크롬 창이 생성되고, 어떤 순서로 진행되는지 확인할 수 있다.
//		options.addArguments("headless");
		
		// 위에서 설정한 옵션은 담은 드라이버 객체 생성
		// 옵션을 설정하지 않았을 때에는 생략 가능하다.
		// WebDriver객체가 곧 하나의 브라우저 창이라 생각한다.
		
//		try {
//			service.start();
//		} catch(IOException e1) {
//			e1.printStackTrace();
//		}
		
		//final WebDriver driver = new ChromeDriver(options);
		final WebDriver driver =  new ChromeDriver(service);
//		final WebDriverWait wait = new WebDriverWait(driver, 10);
		
		try {
			driver.get("https://www.melon.com/chart/index.htm");
			Thread.sleep(3000);
			
//			JavascriptExecutor js = (JavascriptExecutor) driver;
			
            for (int i = 1; i <= 100; i++) {
            	driver.findElement(By.xpath("/html/body/div/div[3]/div/div/div[3]/form/div/table/tbody/tr["+i+"]/td[5]/div/a")).click();
            	Thread.sleep(2000);
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"d_song_org\"]/a/img")); // image 요소 식별
            	image = webElement.getAttribute("src"); // 이미지 URL 가져오기
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"downloadfrm\"]/div/div/div[2]/div[1]/div[1]"));
            	title = webElement.getText();
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"downloadfrm\"]/div/div/div[2]/div[1]/div[2]/a"));
            	artist = webElement.getText();
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"downloadfrm\"]/div/div/div[2]/div[2]/dl/dd[1]/a"));
            	album = webElement.getText();
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"downloadfrm\"]/div/div/div[2]/div[2]/dl/dd[2]"));
            	releaseDate = webElement.getText();
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"downloadfrm\"]/div/div/div[2]/div[2]/dl/dd[3]"));
            	genre = webElement.getText();
            	
            	webElement = driver.findElement(By.xpath("//*[@id=\"d_video_summary\"]"));
            	lyrics = webElement.getText();
            	
            	SongVO songVO = new SongVO(image, title, artist, album, releaseDate, genre, lyrics);
            	
            	if (songDAO.getSongTitle(songVO.getTitle()) == null) {
            		songDAO.setSongInfoInsert(songVO);
            	}
            	
            	driver.navigate().back();
            	Thread.sleep(2000);
            }
            
	    } catch (Exception e2) {
	        e2.printStackTrace();
	    } finally {
	        // 프로그램이 종료되면 resource 해제
	        driver.quit();
	        service.stop();
	    }
	}

	@Override
	public SongVO getSongInfo(int idx) {
		return songDAO.getSongInfo(idx);
	}

	@Override
	public List<PlayListVO> getPlayListIdx(int idx) {
		return songDAO.getPlayListIdx(idx);
	}

	@Override
	public List<SongVO> getSongList() {
		return songDAO.getSongList();
	}

	@Override
	public int setSongInfoAdminInsert(MultipartFile fName, SongVO vo) {
		int res = 0;
		try {
			if (fName != null) {
				String oFileName = fName.getOriginalFilename();
				
				if(!oFileName.equals("") && oFileName != null) {
					JavawebProvide jp = new JavawebProvide();
					jp.writeFile(fName, oFileName, "music");
					
					vo.setMusic(oFileName);
				}
			}
			else {
				vo.setMusic(null);
			}
//			System.out.println("vo : " + vo);
			songDAO.setSongInfoAdminInsert(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int setSongInfoUpdate(MultipartFile fName, SongVO vo) {
		int res = 0;
		try {
			if (fName != null) {
				String oFileName = fName.getOriginalFilename();
				
				if(!oFileName.equals("") && oFileName != null) {
					JavawebProvide jp = new JavawebProvide();
					jp.writeFile(fName, oFileName, "music");
					
					vo.setMusic(oFileName);
				}
			}
			else {
				vo.setMusic(null);
			}
//			System.out.println("vo.getMusic() : " + vo.getMusic());
			songDAO.setSongInfoUpdate(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int setSongDelete(int idx) {
		return songDAO.setSongDelete(idx);
	}

	@Override
	public List<SongVO> getSongInfoSearch(String search, String searchString) {
//		System.out.println(search);
//		System.out.println(searchString);
		return songDAO.getSongInfoSearch(search, searchString);
	}

	@Override
	public List<ChartVO> getSongSearch(String search, String searchString) {
		return songDAO.getSongSearch(search, searchString);
	}

	@Override
	public List<SongVO> getSongListT() {
		return songDAO.getSongListT();
	}
	
	
}
