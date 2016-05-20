package com.crms.dao;

import java.io.Serializable;
import java.util.List;


public interface AbstractDAO<T, ID extends Serializable> {

	public T findOne(ID id);
	public List<T> findAll();
}
