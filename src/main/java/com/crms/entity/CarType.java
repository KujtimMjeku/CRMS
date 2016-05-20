package com.crms.entity;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * The persistent class for the tblcar_type database table.
 * 
 */
@Entity
@Table(name = "tblcar_type")
public class CarType {

	private int id;

	private boolean automatic;

	
	private String name;

	private String producer;

	private String type;

	private List<Car> tblcars;

	public CarType() {

	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "Car_type_ID", updatable = false, nullable = false)
	public int getId() {
		return this.id;
	}

	@Column(name = "NAME", updatable = true, nullable = false)
	@NotNull
	@Size(min=3, max=30,message="* Field size most be beteween 3 and 30")
	public String getName() {
		return this.name;
	}

	@Column(name = "TYPE", updatable = true, nullable = false)
	@NotNull
	@Size(min=1, max=30,message="* Field size most be beteween 1  and 30")
	public String getType() {
		return this.type;
	}

	@Column(name = "PRODUCER", updatable = true, nullable = false)
	@NotNull
	//@Size(min=3, max=30,message="* Field size most be beteween 3 and 30")
	public String getProducer() {
		return this.producer;
	}

	@Column(name = "AUTOMATIC", updatable = true, nullable = false)
	public boolean getAutomatic() {
		return this.automatic;
	}

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "tblcarType")
	public List<Car> getTblcars() {
		return this.tblcars;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setAutomatic(boolean automatic) {
		this.automatic = automatic;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setProducer(String producer) {
		this.producer = producer;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setTblcars(List<Car> tblcars) {
		this.tblcars = tblcars;
	}

	public Car addTblcar(Car tblcar) {
		getTblcars().add(tblcar);

		return tblcar;
	}

	public Car removeTblcar(Car tblcar) {
		getTblcars().remove(tblcar);
		return tblcar;
	}

	@Override
	public String toString() {
		return "CarType [id=" + id + ", automatic=" + automatic + ", name=" + name + ", producer=" + producer
				+ ", type=" + type + ", tblcars=" + tblcars + "]";
	}

}