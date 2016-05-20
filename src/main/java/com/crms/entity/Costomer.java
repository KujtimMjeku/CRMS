package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the tblcostomer database table.
 * 
 */
@Entity
@Table(name="tblcostomer")
public class Costomer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String company_Name;

	@Temporal(TemporalType.DATE)
	private Date date_of_Birth;

	private String email;

	private String first_Name;

	private String login_Name;

	@Temporal(TemporalType.TIMESTAMP)
	private Date register_Date;

	private String surname;

	//bi-directional many-to-one association to Booking
	@OneToMany(mappedBy="tblcostomer")
	private List<Booking> tblbookings;

	//bi-directional many-to-one association to CostomerAddress
	@OneToMany(mappedBy="tblcostomer")
	private List<CostomerAddress> tblcostomerAddresses;

	public Costomer() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCompany_Name() {
		return this.company_Name;
	}

	public void setCompany_Name(String company_Name) {
		this.company_Name = company_Name;
	}

	public Date getDate_of_Birth() {
		return this.date_of_Birth;
	}

	public void setDate_of_Birth(Date date_of_Birth) {
		this.date_of_Birth = date_of_Birth;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirst_Name() {
		return this.first_Name;
	}

	public void setFirst_Name(String first_Name) {
		this.first_Name = first_Name;
	}

	public String getLogin_Name() {
		return this.login_Name;
	}

	public void setLogin_Name(String login_Name) {
		this.login_Name = login_Name;
	}

	public Date getRegister_Date() {
		return this.register_Date;
	}

	public void setRegister_Date(Date register_Date) {
		this.register_Date = register_Date;
	}

	public String getSurname() {
		return this.surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public List<Booking> getTblbookings() {
		return this.tblbookings;
	}

	public void setTblbookings(List<Booking> tblbookings) {
		this.tblbookings = tblbookings;
	}

	public Booking addTblbooking(Booking tblbooking) {
		getTblbookings().add(tblbooking);
		tblbooking.setTblcostomer(this);

		return tblbooking;
	}

	public Booking removeTblbooking(Booking tblbooking) {
		getTblbookings().remove(tblbooking);
		tblbooking.setTblcostomer(null);

		return tblbooking;
	}

	public List<CostomerAddress> getTblcostomerAddresses() {
		return this.tblcostomerAddresses;
	}

	public void setTblcostomerAddresses(List<CostomerAddress> tblcostomerAddresses) {
		this.tblcostomerAddresses = tblcostomerAddresses;
	}

	public CostomerAddress addTblcostomerAddress(CostomerAddress tblcostomerAddress) {
		getTblcostomerAddresses().add(tblcostomerAddress);
		tblcostomerAddress.setTblcostomer(this);

		return tblcostomerAddress;
	}

	public CostomerAddress removeTblcostomerAddress(CostomerAddress tblcostomerAddress) {
		getTblcostomerAddresses().remove(tblcostomerAddress);
		tblcostomerAddress.setTblcostomer(null);

		return tblcostomerAddress;
	}

}