package com.crms.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tblbooking database table.
 * 
 */
@Entity
@Table(name="tblbooking")
public class Booking implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int booking_Number;

	@Temporal(TemporalType.DATE)
	private Date booking_Date;

	@Temporal(TemporalType.DATE)
	private Date return_Date;

	private String time_Stamp;

	//bi-directional many-to-one association to Agency
	@ManyToOne
	@JoinColumn(name="Agency_ID")
	private Agency tblagency;

	//bi-directional many-to-one association to Car
	@ManyToOne
	@JoinColumn(name="Car_ID")
	private Car tblcar;

	//bi-directional many-to-one association to Costomer
	@ManyToOne
	@JoinColumn(name="Costomer_ID")
	private Costomer tblcostomer;

	public Booking() {
	}

	public int getBooking_Number() {
		return this.booking_Number;
	}

	public void setBooking_Number(int booking_Number) {
		this.booking_Number = booking_Number;
	}

	public Date getBooking_Date() {
		return this.booking_Date;
	}

	public void setBooking_Date(Date booking_Date) {
		this.booking_Date = booking_Date;
	}

	public Date getReturn_Date() {
		return this.return_Date;
	}

	public void setReturn_Date(Date return_Date) {
		this.return_Date = return_Date;
	}

	public String getTime_Stamp() {
		return this.time_Stamp;
	}

	public void setTime_Stamp(String time_Stamp) {
		this.time_Stamp = time_Stamp;
	}

	public Agency getTblagency() {
		return this.tblagency;
	}

	public void setTblagency(Agency tblagency) {
		this.tblagency = tblagency;
	}

	public Car getTblcar() {
		return this.tblcar;
	}

	public void setTblcar(Car tblcar) {
		this.tblcar = tblcar;
	}

	public Costomer getTblcostomer() {
		return this.tblcostomer;
	}

	public void setTblcostomer(Costomer tblcostomer) {
		this.tblcostomer = tblcostomer;
	}

}