package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the tblbranch_address database table.
 * 
 */
@Entity
@Table(name="tblbranch_address")
public class BranchAddress implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int branch_ID;

	private String city_Name;

	private String country;

	private String phone_Number;

	private String postal_Code;

	private String street_Name;

	private String street_Number;

	//bi-directional one-to-one association to Branch
	@OneToOne
	@JoinColumn(name="Branch_ID")
	private Branch tblbranch;

	public BranchAddress() {
	}

	public int getBranch_ID() {
		return this.branch_ID;
	}

	public void setBranch_ID(int branch_ID) {
		this.branch_ID = branch_ID;
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

	public Branch getTblbranch() {
		return this.tblbranch;
	}

	public void setTblbranch(Branch tblbranch) {
		this.tblbranch = tblbranch;
	}

}