package com.crms.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.crms.exception.ResourceNotFoundException;

@ControllerAdvice
public class ErrorController {
	
	@ExceptionHandler(NoHandlerFoundException.class)
    public String handleResourceNotFoundException() {
		System.out.println("test");
        return "errors/404";
    }
	
	
	@ExceptionHandler(AccessDeniedException.class)
    public String handleResource() {
		System.out.println("test");
        return "errors/403";
    }
/*	@ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(org.springframework.http.HttpStatus.FORBIDDEN)
    public String handleResourceAcesException() {
        return "errors/404";
	}*/

}
