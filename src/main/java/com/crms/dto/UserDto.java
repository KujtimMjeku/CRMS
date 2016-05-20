package com.crms.dto;

import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import com.crms.entity.UserGroup;

public class UserDto {

	@NotEmpty
	private String name;
	@NotEmpty
	private String surename;

	@Temporal(TemporalType.DATE)
	@NotNull(message="The birth day is required")
	@Past(message="Date of birth most be the past")
	private Date birthDay;	
	@NotEmpty
	private String address;	
	@NotEmpty
	@Pattern(regexp="^\\+(?:[0-9] ?){6,14}[0-9]$",message="write right format of phone number")
	private String telephone;	
	
	@NotEmpty
	@Email(message="please write email correct")
	private String email;
	
	@NotEmpty
	private String username;
	

	private Set<Integer> groups;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSurename() {
		return surename;
	}
	public void setSurename(String surename) {
		this.surename = surename;
	}
	public Date getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Set<Integer> getGroups() {
		return groups;
	}
	public void setGroups(Set<Integer> groups) {
		this.groups = groups;
	}
	
	
	
	

}
