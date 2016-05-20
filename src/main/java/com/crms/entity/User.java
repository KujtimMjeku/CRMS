package com.crms.entity;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;

import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name="users")
public class User implements  UserDetails, CredentialsContainer {

	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

	@Column(name="fname")
	private String name;
	
	@Column(name="lname")
	private String surename;
	
	@Column(name="bday")
	@Temporal(TemporalType.DATE)
	private Date birthDay;
	
	@Column(name="address")
	private String address;
	
	@Column(name="telephone")
	private String telephone;
	
	@Column(unique=true)
	private String email;
	
	private String password;
	@Id
	private String username;
	
	@Transient
	private Set<GrantedAuthority> authorities;
	private boolean enabled;
	
	 @ManyToMany(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	 @JoinTable(
	 name="group_members",
	    		  joinColumns=@JoinColumn(name="username", referencedColumnName="username"),
	    		  inverseJoinColumns=@JoinColumn(name="group_id", referencedColumnName="id"))
	private Set<UserGroup> groups;
	
	

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

	public Set<UserGroup> getGroups() {
		return groups;
	}

	public void setGroups(Set<UserGroup> groups) {
		this.groups = groups;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setAuthorities(Set<GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public void eraseCredentials() {
		this.password = null;
		
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Set<String> authority=new HashSet<>();
		for (UserGroup group : groups) {
			authority.addAll(group.getAuthorities());
		}
		Set<GrantedAuthority> authList=new HashSet<GrantedAuthority>(AuthorityUtils.createAuthorityList(authority.toArray(new String[authority.size()])));
		this.setAuthorities(authList);
		return this.authorities;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.username;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", password=[protected]" +", username=" + username + ", authorities="
				+ authorities + ", enabled=" + enabled + "]";
	}

	
	

}
