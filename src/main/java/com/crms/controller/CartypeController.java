package com.crms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crms.dao.*;
import com.crms.entity.CarType;
import com.fasterxml.jackson.databind.JsonSerializable;

/**
 * @author JEE4
 *
 */
@Controller
public class CartypeController {

	@Autowired
	private CarTypeDAO carTypeDao;
	
	@RequestMapping(value="cartype", method = RequestMethod.GET) 
	public String start(Model model) {		
		model.addAttribute("cartypes", carTypeDao.findAll());
		model.addAttribute("records_count", carTypeDao.numberOfRows());
		model.addAttribute("pList", carTypeDao.pagesList(5));
		model.addAttribute("cartypee", new CarType());
		System.out.println(SecurityContextHolder.getContext().getAuthentication().getPrincipal());
		model.addAttribute("username", SecurityContextHolder.getContext().getAuthentication().getName());
		return "pages/cartype";
	}
	
	@RequestMapping(value="cartype/edit/{id}", method = RequestMethod.GET) 
	public String goEdit(Model model,@PathVariable(value="id") int id) {
		model.addAttribute("cartypee", carTypeDao.find(id));
		return "forms/frm_car_type";
	}
	
	@RequestMapping(value="cartype/update/{id}", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> goUpdate(
			Model model, 
			@Valid @ModelAttribute CarType carType,
			BindingResult bindingResult) 
	{
		Map<String, Object> jsonResponse=new HashMap<String, Object>();
		if (bindingResult.hasErrors()) 
		{  
			jsonResponse.put("STATUS", "error");
			jsonResponse.put("VALUE", getErrorLists(bindingResult));
			System.out.println(bindingResult.getModel());			
        }
		else
		{
			jsonResponse.put("STATUS", "success");
			jsonResponse.put("VALUE", "");
			carTypeDao.insert(carType);			
		}
		return jsonResponse;
	}	
	
	public Map<String,String> getErrorLists(BindingResult result)
	{
		Map<String,String> error=new HashMap<String, String>();		
		for(FieldError fieldError : result.getFieldErrors()){
			error.put(fieldError.getField(), fieldError.getDefaultMessage());
        }		
		return error;
	}
	
	
	
	
	
	@RequestMapping(value="cartype/delete/{id}", method = RequestMethod.POST) 
	public String goDelete(Model model,@PathVariable(value="id") int id) {
		carTypeDao.delete(id);
		return "redirect:/cartype";
	}
	
	@RequestMapping(value="cartype/add", method=RequestMethod.GET)
	public String goAdd(Model model) {
		model.addAttribute("cartypee", new CarType());
		return "forms/frm_car_type";
	}
	@RequestMapping(value="cartype/save")
	public String Save(Model model,@ModelAttribute CarType carType) {
		carTypeDao.insert(carType);
		System.out.println(carType);
		return "redirect:/cartype";
	}
	
	/**
	 * @param model
	 * @param carType
	 * @param bindingResult
	 * @return json value { STATUS:success or error, VALUE:"" empty string or json error array}
	 */
	@RequestMapping(value="cartype/save", method = RequestMethod.POST) 
	public @ResponseBody Map<String, Object> goSave(
			Model model, 
			@Valid @ModelAttribute CarType carType,
			BindingResult bindingResult) 
	{
		Map<String, Object> jsonResponse=new HashMap<String, Object>();
		if (bindingResult.hasErrors()) 
		{  
			carType.setName("Hello");
			jsonResponse.put("STATUS", "error");
			jsonResponse.put("VALUE", getErrorLists(bindingResult));
			System.out.println(bindingResult.getModel());			
        }
		else
		{
			jsonResponse.put("STATUS", "success");
			jsonResponse.put("VALUE", "");
			carTypeDao.insert(carType);			
		}
		return jsonResponse;
	}	
}
