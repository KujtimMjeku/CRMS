	package com.crms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;

import com.crms.exception.ResourceNotFoundException;

@Controller
public class HomeController {
	
	@RequestMapping(value="/")
	public String goHome(){
		return "home";
		
	}
	
	/*@ExceptionHandler(ResourceNotFoundException.class)
    public String handleResourceNotFoundException() {
        return "errors/404";
    }*/
}

