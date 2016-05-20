package com.crms.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.stereotype.Service;


@Service
public class UserGrupServiceImp implements UserGrupService {


	@Autowired
	JdbcUserDetailsManager userDetailsManager;
	
	
	
	public List<String> finUserGroup() {
		
		return userDetailsManager.findAllGroups();
		
	}
}
