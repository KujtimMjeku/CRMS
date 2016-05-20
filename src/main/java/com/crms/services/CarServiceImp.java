package com.crms.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.stereotype.Service;

import com.crms.dao.CarDAO;
import com.crms.entity.Car;

@Service
public class CarServiceImp implements CarService {

	@Autowired
	private CarDAO carDao;
	
	@Override
	public long getRecordNumber() {
		return carDao.count();
	}

	@Override
	public List<Car> getPage(int page, int rowPerPage) {
		int start=(page-1) * rowPerPage;
		int count =rowPerPage;
		return carDao.fetchFromTo(start, count);
	}

	@Override
	public List<Integer> getPagingButtons(int page, int rowPerPage, int rowCount,int maxNumberOfButtons) {
		List<Integer> buttons=new ArrayList<>();
		if(!(rowPerPage>0))
			return null;
		int nPage=rowCount/rowPerPage;
		
		int start=1;
		int end=1;
		if(rowCount%rowPerPage != 0)
			nPage++;
		if(nPage>maxNumberOfButtons)
		{
			if(maxNumberOfButtons/2>=page)
			{
				start=1;
				end =maxNumberOfButtons;
			}
			else if(nPage-page<maxNumberOfButtons/2)
			{
				start=nPage-maxNumberOfButtons;
				end = nPage;
			}
			else if(nPage<page)
			{
				start=nPage-maxNumberOfButtons;
				end = nPage;
			}
			else
			{
				start=page-maxNumberOfButtons/2;
				end =page+maxNumberOfButtons/2;
			}
		}
		else
		{
			start=1;
			end = nPage;
		}
		for (int i = start; i <= end; i++) {
			buttons.add(i);
		}
		return buttons;
	}

}
