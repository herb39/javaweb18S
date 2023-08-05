package com.spring.javaweb18S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb18S.dao.BoardDAO;

@Service
public class PageProcess {

	@Autowired
	BoardDAO boardDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();

		int totRecCnt = 0;
		String search = "";

		if (section.equals("board")) {
			if (part.equals("")) totRecCnt = boardDAO.totRecCnt();
			else {
				search = part;
//				System.out.println(search);
				totRecCnt = boardDAO.totRecCntSearch(search, searchString);
			}
		}

		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;

		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);

		return pageVO;
	}
	
	public PageVO sis(String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		String search = "";
		
		if (!part.equals("") || part != null) {
			search = part;
		}
		
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}

}
