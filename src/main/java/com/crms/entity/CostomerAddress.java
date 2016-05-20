package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the tblcostomer_address database table.
 * 
 */
@Entity
@Table(name="tblcostomer_address")
public class CostomerAddress implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String city_Name;

	private String country;

	private String phone_Number;

	private String postal_Code;

	private String street_Name;

	private String street_Number;

	//bi-directional many-to-one association to Costomer
	@ManyToOne
	@JoinColumn(name="Costomer_ID")
	private Costomer tblcostomer;

	public CostomerAddress() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCity_Name() {
		return this.city_Name;
	}

	public void setCity_Name(String city_Name) {
		this.city_Name = city_Name;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getPhone_Number() {
		return this.phone_Number;
	}

	public void setPhone_Number(String phone_Number) {
		this.phone_Number = phone_Number;
	}

	public String getPostal_Code() {
		return this.postal_Code;
	}

	public void setPostal_Code(String postal_Code) {
		this.postal_Code = postal_Code;
	}

	public String getStreet_Name() {
		return this.street_Name;
	}

	public void setStreet_Name(String street_Name) {
		this.street_Name = street_Name;
	}

	public String getStreet_Number() {
		return this.street_Number;
	}

	public void setStreet_Number(String street_Number) {
		this.street_Number = street_Number;
	}

	public Costomer getTblcostomer() {
		return this.tblcostomer;
	}

	public void setTblcostomer(Costomer tblcostomer) {
		this.tblcostomer = tblcostomer;
	}

}