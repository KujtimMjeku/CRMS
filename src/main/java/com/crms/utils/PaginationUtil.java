package com.crms.utils;

import java.util.ArrayList;
import java.util.List;

public class PaginationUtil
{
	private long rowNumber;
	private int page;
	private int perPage;
	private int numberOfShownBtns;
	private String url;
	private boolean leftBtn;
	private boolean rightBtn;
	private boolean leftEmpty;
	private boolean rightEmpty;
	private List<Integer> buttons;
	
	public PaginationUtil() {
		rowNumber=10;
		page=1;
		perPage=10;
		numberOfShownBtns=4;
		url="index";
		Paginate();
	}

	private void Paginate() {
		int rowCount = Math.toIntExact(rowNumber);
		List<Integer> buttons=new ArrayList<>();
		if(!(rowCount>0))
			return ;
		int nPage=rowCount/perPage;
		
		int start=1;
		int end=1;
		if(rowCount%perPage != 0)
			nPage++;
		if(nPage>numberOfShownBtns)
		{
			if(numberOfShownBtns/2>=page)
			{
				start=1;
				end =numberOfShownBtns;
				leftEmpty=false;
				rightEmpty=true;
			}
			else if(nPage-page<numberOfShownBtns/2)
			{
				start=nPage-numberOfShownBtns;
				end = nPage;
				leftEmpty=true;
				rightEmpty=false;
			}
			else if(nPage<page)
			{
				start=nPage-numberOfShownBtns;
				end = nPage;
				leftEmpty=true;
				rightEmpty=false;
			}
			else
			{
				start=page-numberOfShownBtns/2;
				end =page+numberOfShownBtns/2;
				leftEmpty=true;
				rightEmpty=true;
			}
		}
		else
		{
			start=1;
			end = nPage;
			leftEmpty=false;
			rightEmpty=false;
		}
		for (int i = start; i <= end; i++) {
			buttons.add(i);
		}
		this.setButtons(buttons);
		if(page==1)
		{
			leftBtn=false;
		}
		else
		{
			leftBtn=true;
		}
		if(page==nPage)
		{
			rightBtn=false;
		}
		else
		{
			rightBtn=true;
		}
		
	}
	
	
	
	public long getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(long rowNumber) {
		this.rowNumber = rowNumber;
		Paginate();
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
		Paginate();
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
		Paginate();
	}

	public int getNumberOfShownBtns() {
		return numberOfShownBtns;
		
	}

	public void setNumberOfShownBtns(int numberOfShownBtns) {
		this.numberOfShownBtns = numberOfShownBtns;
		Paginate();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
		Paginate();
	}

	public boolean isLeftBtn() {
		return leftBtn;
	}

	public boolean isRightBtn() {
		return rightBtn;
	}

	public boolean isLeftEmpty() {
		return leftEmpty;
	}

	public boolean isRightEmpty() {
		return rightEmpty;
	}

	public List<Integer> getButtons() {
		return buttons;
	}

	public void setButtons(List<Integer> buttons) {
		this.buttons = buttons;
	}
	
	
}