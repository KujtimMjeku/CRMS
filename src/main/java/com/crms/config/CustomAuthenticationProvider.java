package com.crms.config;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.stereotype.Component;

import com.crms.entity.User;
import com.crms.services.CustomUserDetailsService;


@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	CustomUserDetailsService userService;
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String name = authentication.getName();
        String password = authentication.getCredentials().toString();
        
        BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder();
        
        User user = (User) userService.loadUserByUsername(name);
        // use the credentials to try to authenticate against the third party system
        if (user==null || !user.getUsername().equalsIgnoreCase(name)) {
        	throw new BadCredentialsException("Username not found.");
        	
        }
        if (!bcrypt.matches(password, user.getPassword())) {
            throw new BadCredentialsException("Wrong password.");
        }
        
        Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
        
        return new UsernamePasswordAuthenticationToken(user, password, authorities);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return true;
	}

}
