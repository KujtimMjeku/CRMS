	package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


/**
 * The persistent class for the tblcar database table.
 * 
 */
@Entity
@Table(name="tblcar")
public class Car{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private float base_Price_Per_Day;

	private String color;

	@Temporal(TemporalType.DATE)
	private Date date_of_Manufacturing;

	private String regjistration_Number;
	private String image_name;
	private byte[] image;
	//bi-directional many-to-one association to Booking
	/*@OneToMany(mappedBy="tblcar")
	private List<Booking> tblbookings;*/

	//bi-directional many-to-one association to Branch
	/*@ManyToOne
	@JoinColumn(name="Branch_ID")
	private Branch tblbranch;*/

	//bi-directional many-to-one association to CarType
	@ManyToOne
	@JoinColumn(name="Car_type_ID")
	private CarType tblcarType;

	public Car() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public float getBase_Price_Per_Day() {
		return this.base_Price_Per_Day;
	}

	public void setBase_Price_Per_Day(float base_Price_Per_Day) {
		this.base_Price_Per_Day = base_Price_Per_Day;
	}

	public String getColor() {
		return this.color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public Date getDate_of_Manufacturing() {
		return this.date_of_Manufacturing;
	}

	public void setDate_of_Manufacturing(Date date_of_Manufacturing) {
		this.date_of_Manufacturing = date_of_Manufacturing;
	}

	public String getRegjistration_Number() {
		return this.regjistration_Number;
	}

	public void setRegjistration_Number(String regjistration_Number) {
		this.regjistration_Number = regjistration_Number;
	}
	
/*
	public List<Booking> getTblbookings() {
		return this.tblbookings;
	}

	public void setTblbookings(List<Booking> tblbookings) {
		this.tblbookings = tblbookings;
	}
*/
/*	public Booking addTblbooking(Booking tblbooking) {
		getTblbookings().add(tblbooking);
		tblbooking.setTblcar(this);

		return tblbooking;
	}

	public Booking removeTblbooking(Booking tblbooking) {
		getTblbookings().remove(tblbooking);
		tblbooking.setTblcar(null);

		return tblbooking;
	}*/

	/*public Branch getTblbranch() {
		return this.tblbranch;
	}

	public void setTblbranch(Branch tblbranch) {
		this.tblbranch = tblbranch;
	}*/

	public String getImage_name() {
		return image_name;
	}

	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public CarType getTblcarType() {
		return this.tblcarType;
	}

	public void setTblcarType(CarType tblcarType) {
		this.tblcarType = tblcarType;
	}

	@Override
	public String toString() {
		return "Car [id=" + id + ", base_Price_Per_Day=" + base_Price_Per_Day + ", color=" + color
				+ ", date_of_Manufacturing=" + date_of_Manufacturing + ", regjistration_Number=" + regjistration_Number
				+ ", tblcarType="  + "]";
	}
	

}