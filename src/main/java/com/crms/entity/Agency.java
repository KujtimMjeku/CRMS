package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the tblagency database table.
 * 
 */
@Entity
@Table(name="tblagency")
public class Agency implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String agency_Name;

	//bi-directional many-to-one association to Booking
	@OneToMany(mappedBy="tblagency")
	private List<Booking> tblbookings;

	//bi-directional many-to-one association to Branch
	@OneToMany(mappedBy="tblagency")
	private List<Branch> tblbranches;

	public Agency() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAgency_Name() {
		return this.agency_Name;
	}

	public void setAgency_Name(String agency_Name) {
		this.agency_Name = agency_Name;
	}

	public List<Booking> getTblbookings() {
		return this.tblbookings;
	}

	public void setTblbookings(List<Booking> tblbookings) {
		this.tblbookings = tblbookings;
	}

	public Booking addTblbooking(Booking tblbooking) {
		getTblbookings().add(tblbooking);
		tblbooking.setTblagency(this);

		return tblbooking;
	}

	public Booking removeTblbooking(Booking tblbooking) {
		getTblbookings().remove(tblbooking);
		tblbooking.setTblagency(null);

		return tblbooking;
	}

	public List<Branch> getTblbranches() {
		return this.tblbranches;
	}

	public void setTblbranches(List<Branch> tblbranches) {
		this.tblbranches = tblbranches;
	}

	public Branch addTblbranch(Branch tblbranch) {
		getTblbranches().add(tblbranch);
		tblbranch.setTblagency(this);

		return tblbranch;
	}

	public Branch removeTblbranch(Branch tblbranch) {
		getTblbranches().remove(tblbranch);
		tblbranch.setTblagency(null);

		return tblbranch;
	}

}