package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the tblbranch database table.
 * 
 */
@Entity
@Table(name="tblbranch")
public class Branch implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String name;

	//bi-directional many-to-one association to Agency
	@ManyToOne
	@JoinColumn(name="Agency_ID")
	private Agency tblagency;

	//bi-directional one-to-one association to BranchAddress
	@OneToOne(mappedBy="tblbranch")
	private BranchAddress tblbranchAddress;

	//bi-directional many-to-one association to Car
	/*@OneToMany(mappedBy="tblbranch")
	private List<Car> tblcars;*/

	public Branch() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Agency getTblagency() {
		return this.tblagency;
	}

	public void setTblagency(Agency tblagency) {
		this.tblagency = tblagency;
	}

	public BranchAddress getTblbranchAddress() {
		return this.tblbranchAddress;
	}

	public void setTblbranchAddress(BranchAddress tblbranchAddress) {
		this.tblbranchAddress = tblbranchAddress;
	}

	/*public List<Car> getTblcars() {
		return this.tblcars;
	}

	public void setTblcars(List<Car> tblcars) {
		this.tblcars = tblcars;
	}*/
/*
	public Car addTblcar(Car tblcar) {
		getTblcars().add(tblcar);
		tblcar.setTblbranch(this);

		return tblcar;
	}

	public Car removeTblcar(Car tblcar) {
		getTblcars().remove(tblcar);
		tblcar.setTblbranch(null);

		return tblcar;
	}*/

}