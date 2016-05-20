package com.crms.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.core.GenericTypeResolver;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Transactional
abstract class AbstractDAOImp<T, ID extends Serializable> implements AbstractDAO<T, ID>{

	@PersistenceContext
	private EntityManager em;
	
	Class<T> type;
	
	@SuppressWarnings("unchecked")
	public AbstractDAOImp() {
		this.type = (Class<T>)((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}
	
	@Override
	@Transactional
	public T findOne(ID id) {
		System.err.println(id);
	   return  (T)em.find(this.getClassType(), id);
	}

	@Override
	public List<T> findAll() {
		return em.createQuery("Select g from UserGroup g").getResultList();
	}
	
	public Class<T> getClassType() {
		return this.type;
	}
}
