package com.crms.dao;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.crms.entity.Car;

public interface CarDAO extends CrudRepository<Car, Integer> {

	public List<Car> fetchFromTo(int start,int count);
}
