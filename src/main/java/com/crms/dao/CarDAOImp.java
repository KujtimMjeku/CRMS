package com.crms.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;

import org.hibernate.SessionFactory;
import org.neo4j.cypher.internal.compiler.v2_2.planner.logical.steps.labelScanLeafPlanner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crms.entity.Car;

import scala.collection.immutable.Set.Set4;

@Repository
@Transactional
public class CarDAOImp implements CarDAO {

	@PersistenceContext
	private EntityManager em;

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public long count() {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = qb.createQuery(Long.class);
		cq.select(qb.count(cq.from(Car.class)));
		return em.createQuery(cq).getSingleResult();
	}

	@Override
	@Transactional
	public void delete(Integer id) {
		em.remove(findOne(id));
	}

	@Override
	@Transactional
	public void delete(Car car) {
		em.remove(car);

	}

	@Override
	@Transactional
	public void delete(Iterable<? extends Car> cars) {
		Iterator<Car> cariterator = (Iterator<Car>) cars.iterator();
		while (cariterator.hasNext()) {
			delete(cariterator.next());
		}

	}

	@Override
	@Transactional
	public void deleteAll() {
		em.createQuery("Delete t from Car t");
	}

	@Override
	@Transactional
	public boolean exists(Integer id) {
		em.find(Car.class, id);
		if (em.find(Car.class, id) != null) {
			return true;
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Iterable<Car> findAll() {
		return em.createQuery("Select t from Car t").getResultList();
	}

	@Override
	@Transactional
	public Iterable<Car> findAll(Iterable<Integer> ids) {
		List<Car> car = new ArrayList<>();
		Iterator<Integer> idsIterrator = ids.iterator();
		while (idsIterrator.hasNext()) {
			car.add(findOne(idsIterrator.next()));
		}
		return car;
		/*
		 * cq.multiselect(arg0); return em.createQuery(cq).getSingleResult();
		 */
	}

	@Override
	@Transactional
	public Car findOne(Integer id) {
		return em.find(Car.class, id);
	}

	@Override
	@Transactional
	public <S extends Car> S save(S car) {

		System.out.println(car);
		em.merge(car);
		//sessionFactory.getCurrentSession().saveOrUpdate(car);
		return car;

	}

	@Override
	@Transactional
	public <S extends Car> Iterable<S> save(Iterable<S> cars) {

		List<S> result = new ArrayList<S>();

		if (cars == null) {
			return result;
		}
		for (S car : cars) {
			result.add(save(car));
		}

		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Car> fetchFromTo(int start, int count) {
		Query query= em.createQuery("SELECT t FROM Car t");
		query.setFirstResult(start);
		query.setMaxResults(count);
		return query.getResultList();
	}

}
