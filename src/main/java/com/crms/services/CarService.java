package com.crms.services;
import com.crms.entity.Car;
import java.util.List;;

public interface CarService {
	
	public long getRecordNumber();
	public List<Car> getPage(int page, int rowPerPage);
	public List<Integer> getPagingButtons(int page, int rowPerPage,int rowCount,int maxNumberOfButtons);
}
