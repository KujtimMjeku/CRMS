package com.crms.controller;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityExistsException;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.crms.dto.UserDto;
import com.crms.entity.Car;
import com.crms.entity.User;
import com.crms.entity.UserGroup;
import com.crms.repository.UsersRepository;

@Controller
@RequestMapping("/accounts")
public class UserController {
	
	@Autowired 
	UsersRepository userRepo;

	@RequestMapping("/")
	public String goHome(Model model) {
		List<Integer> p=new ArrayList<>();
		p.add(1);
		p.add(2);
		p.add(3);
		model.addAttribute("morePage", true);
		model.addAttribute("pList", p);
		model.addAttribute("records_count", 10);
		model.addAttribute("users", userRepo.findAllUsers());
		return "pages/account";	
	}
	
	@RequestMapping("/view/{username}")
	public String goView(Model model,@PathVariable("username") String username) {
		model.addAttribute("user", userRepo.findUserNyUsername(username));
		return "pages/view_user";	
	}
	@RequestMapping("/edit/{username}")
	public String goEdit(Model model,@PathVariable("username") String username) {
		User u= userRepo.findUserNyUsername(username);		
		Set<UserGroup> ug= userRepo.findAllGroups();
		Set<UserGroup> ug1= new HashSet<>();
		boolean contains=false;
		for (UserGroup userGroup : ug) 
		{
			for (UserGroup userGroup1 : u.getGroups()) 
			{
				if (userGroup.getId() == userGroup1.getId()) 
				{
					contains = true;
					break;
				}	
			}
			if (!contains) 
			{
				ug1.add(userGroup);				
			}
			contains=false;
		}

		model.addAttribute("edit",true );
		model.addAttribute("groups",ug1 );
		model.addAttribute("user", u);
		return "forms/frm_users";	
	}
	@RequestMapping("/new/")
	public String goNew(Model model) {
		User u= new User();
		Set<UserGroup> ug= userRepo.findAllGroups();
		model.addAttribute("edit",false );
		model.addAttribute("groups",ug );
		model.addAttribute("user", u);
		return "forms/frm_users";	
	}
	@RequestMapping(value="/create/",method = RequestMethod.POST)
	@ResponseBody
	public  Map<String, Object> goCreate(
			@Valid @ModelAttribute("user") UserDto user,
			BindingResult bindingResult) 
	{
		Map<String,String> emailError=new HashMap<>();
		Map<String, Object> jsonResponse=new HashMap<String, Object>();
		if (bindingResult.hasErrors()) 
		{  
			jsonResponse.put("STATUS", "error");
			jsonResponse.put("VALUE", getErrorLists(bindingResult));
			System.out.println(bindingResult.getModel());			
        }
		else
		{
			try {
				String pw = userRepo.saveUser(user);
				jsonResponse.put("STATUS", "success");
				jsonResponse.put("PASSWORD", pw);
			} catch (DataIntegrityViolationException e) {
				emailError.put("email", "This email already exist");
				jsonResponse.put("STATUS", "error");
				jsonResponse.put("VALUE",emailError );
			}
			catch (EntityExistsException e) {
				emailError.put("username", "This user already exist");
				jsonResponse.put("STATUS", "error");
				jsonResponse.put("VALUE",emailError );
			}
			
					
		}
		return jsonResponse;
	}
	
	@RequestMapping(value="/update/",method = RequestMethod.POST)
	public String goUpdate(Model model,@ModelAttribute("user") UserDto user) {
		userRepo.updateUser(user);
		return "redirect:/accounts/";	
	}
	
	@RequestMapping("/delete/{username}")
	@ResponseBody
	public String goDelete(Model model,@PathVariable("username") String username) {
		model.addAttribute("user", userRepo.findUserNyUsername(username));
		return "Delete";	
	}
	
	@RequestMapping("/findAll")
	public String getUsers() {
		
		return "pages/account";	
	}
	
	public Map<String,String> getErrorLists(BindingResult result)
	{
		Map<String,String> error=new HashMap<String, String>();		
		for(FieldError fieldError : result.getFieldErrors()){
			error.put(fieldError.getField(), fieldError.getDefaultMessage());
        }		
		return error;
	}
}
